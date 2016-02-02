# NSNotificationCenterDemo
测试时使用的Demo
[简书博文地址](http://www.jianshu.com/p/26323f5b823d)

最近看到一段有趣的代码

```
if ([[UIDevice currentDevice].systemVersion floatValue] < 9.0) {
__weak typeof(self) weakSelf;
[[NSNotificationCenter defaultCenter] addObserverForName:kMEChangeNotification
object:nil
queue:[NSOperationQueue mainQueue]
usingBlock:^(NSNotification * _Nonnull note) {
[weakSelf doSomeThing];
}];
} else {
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doSomeThing) name:kMEChangeNotification object:nil];
}
```
一开始看到就猜想难道不同的系统接受通知的姿势不一样？但是之前一直都在用`addObserver`，也没出现过问题啊，感觉这串代码是多此一举，就没在管。后来有一次因为没有`removeObserver`引发了崩溃，才发现这串代码是有深意的。最近整理了一下，留作笔记，因为这里面特别绕

####规则只有一个，无论什么时候都不可以打破

规则：`addObserverForName`的`block`里面必须使用`weakSelf`，否则会造成循环引用导致当前类无法释放
####注意事项
* 注意事项一：`doSomeThing`里面如果要刷新UI，最好是回调主线程。
因为`通知的接收所在的线程`是基于`发送通知所在的线程`,如果通知是在主线程发出的，通知的接收也是在主线程，如果通知的发送是在子线程，通知的接收也是在子线程。也就是说如果你不能保证你的通知一定是在主线程发送的，就最好回到主线程刷新UI
```
-(void)doSomeThing
{
//do something

dispatch_async(dispatch_get_main_queue(), ^{
// UI
});
}
```
* 注意事项二：通知的移除要调用各自的移除方法
`addObserverForName`和`addObserver`通知的移除方法是不一样的
`addObserver`通知的移除方法是`[[NSNotificationCenter defaultCenter]removeObserver:self]`,这是最常见的，然而对于`addObserverForName`是没有用的，
`addObserverForName`通知的移除方法是在声明的时候要记录通知变量
```
@interface SecondViewController ()
{
id notificationObserver;
}
//或者
//@property (nonatomic, strong) id notificationObserver;
@end

__weak typeof(self) weakSelf;
notificationObserver = [[NSNotificationCenter defaultCenter]addObserverForName:@"MYNotificationCenter" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
NSLog(@"addObserverForName接收到通知");
[weakSelf doSomeThing];
}];
```
然后使用`[[NSNotificationCenter defaultCenter]removeObserver:notificationObserver];`移除

####打破概念特别注意事项
特别注意事项：通知的移除不一定非要写
对于addObserverForName：
```
__weak typeof(self) weakSelf;
notificationObserver = [[NSNotificationCenter defaultCenter]addObserverForName:@"MYNotificationCenter" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
NSLog(@"addObserverForName接收到通知");  //如果没有移除这个通知，每次接到通知时这个NSLog都会输出
[weakSelf doSomeThing]; //如果没有移除这个通知，如果是直接使用self,则这个通知所在NSObject或者ViewController都不会释放，如果是使用weakSelf，则这个通知所在NSObject或者ViewController都会释放，就不会再继续调用doSomeThing方法
}];
```
对于addObserver：
这里要分ViewController和普通NSObject两个说起
ViewController：在调用ViewController的dealloc的时候，系统会调用`[[NSNotificationCenter defaultCenter]removeObserver:self]`方法，所以如果是在viewDidLoad中使用addObserver添加监听者的话可以省掉移除。当然，如果是在viewWillAppear中添加的话，那么就要在viewWillAppear中自己移除，`而且`，最好是使用` [[NSNotificationCenter defaultCenter] removeObserver:self name:@"test" object:nil];`而非`[[NSNotificationCenter defaultCenter]removeObserver:self]`,否则很有可能你会把系统的其他通知也移除了

普通NSObject:在iOS9之后，NSObject也会像ViewController一样在dealloc时调用`[[NSNotificationCenter defaultCenter]removeObserver:self]`方法，在iOS9之前的不会调用，需要自己写。

文字开头的那段代码应用场景：在使用类别的时候如果我们添加了通知，那么我们是没有办法在类别里面重写dealloc的，如果不移除通知就会出现野指针，这个时候我们就可以在iOS9以上使用addObserver，将通知的移除交给系统，iOS9一下使用addObserverForName+weakSelf，虽然通知依然存在，但是不会调用doSomeThing方法（不要直接在block里面写处理过程啊）。


![ViewController、NSObject、Notification释放图表(YES:释放)](http://upload-images.jianshu.io/upload_images/1024259-10cba67928a1689e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)