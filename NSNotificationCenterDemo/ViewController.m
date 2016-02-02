//
//  ViewController.m
//  NSNotificationCenterDemo
//
//  Created by Yasin on 16/2/2.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [[NSNotificationCenter defaultCenter]addObserverForName:@"MYNotificationCenter" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
//        NSLog(@"addObserverForName接收到通知");
//    }];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(doSomeThing) name:@"MYNotificationCenter" object:nil];
    
}
//- (void)doSomeThing{
//    NSLog(@"doSomeThing接收到通知");
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)notificationCenterClick:(id)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"MYNotificationCenter" object:nil];
}
- (IBAction)pushClick:(id)sender {
    UIViewController *view = [[SecondViewController alloc]init];
    [self.navigationController pushViewController:view animated:YES];
}
- (IBAction)pushThirdView:(id)sender {
    UIViewController *view = [[ThirdViewController alloc]init];
    [self.navigationController pushViewController:view animated:YES];
}

@end
