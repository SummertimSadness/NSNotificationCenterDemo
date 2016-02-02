//
//  ThirdViewController.m
//  NSNotificationCenterDemo
//
//  Created by Yasin on 16/2/2.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import "ThirdViewController.h"
#import "ManageObject.h"
@interface ThirdViewController ()
{
    ManageObject *obj;
}
@end

@implementation ThirdViewController
-(void)dealloc{
    NSLog(@"ThirdViewController释放了");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =[UIColor colorWithRed:0.8118 green:0.9793 blue:0.0609 alpha:1.0];
    obj = [[ManageObject alloc]init];
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
