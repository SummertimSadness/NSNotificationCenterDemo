//
//  ManageObject.m
//  NSNotificationCenterDemo
//
//  Created by Yasin on 16/2/2.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import "ManageObject.h"

@implementation ManageObject
-(void)dealloc{
    NSLog(@"ManageObject释放了");
}
- (instancetype)init{
    if (self = [super init]) {
        __weak typeof(self) weakSelf;
        [[NSNotificationCenter defaultCenter]addObserverForName:@"MYNotificationCenter" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
            NSLog(@"addObserverForName接收到通知");
            [weakSelf doSomeThing];
        }];
    }
    return self;
}

- (void)doSomeThing{
    NSLog(@"doSomeThing接收到通知");
}
@end
