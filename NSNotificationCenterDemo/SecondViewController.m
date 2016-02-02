//
//  SecondViewController.m
//  NSNotificationCenterDemo
//
//  Created by Yasin on 16/2/2.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()
{
    id notificationObserver;
}
//或者
//@property (nonatomic, strong) id notificationObserver;
@end

@implementation SecondViewController
-(void)dealloc{
//    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [[NSNotificationCenter defaultCenter]removeObserver:notificationObserver];
    NSLog(@"SecondViewController释放了");
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.1606 green:1.0 blue:0.0392 alpha:1.0];
    // Do any additional setup after loading the view.
    __weak typeof(self) weakSelf;
    notificationObserver = [[NSNotificationCenter defaultCenter]addObserverForName:@"MYNotificationCenter" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        NSLog(@"addObserverForName接收到通知");  //如果没有移除这个通知，每次接到通知时这个NSLog都会输出
        [weakSelf doSomeThing]; //如果没有移除这个通知，如果是直接使用self,则这个通知所在NSObject或者ViewController都不会释放，如果是使用weakSelf，则这个通知所在NSObject或者ViewController都会释放，就不会再继续调用doSomeThing方法
    }];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(doSomeThing) name:@"MYNotificationCenter" object:nil];
}
- (void)doSomeThing{
    NSLog(@"doSomeThing接收到通知");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
