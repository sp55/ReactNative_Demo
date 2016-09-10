//
//  RACTimerViewController.m
//  ReactNative
//
//  Created by admin on 16/9/10.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import "RACTimerViewController.h"

@interface RACTimerViewController ()

@end

@implementation RACTimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self test1];
    [self test2];
}

-(void)test1{
    //五秒后执行一次
    [[RACScheduler mainThreadScheduler]afterDelay:5 schedule:^{
        NSLog(@"五秒后执行一次");
    }];
}

-(void)test2{
    //每隔两秒执行一次
    //这里要加takeUntil条件限制一下否则当控制器pop后依旧会执行
    [[[RACSignal interval:2 onScheduler:[RACScheduler mainThreadScheduler]] takeUntil:self.rac_willDeallocSignal ] subscribeNext:^(id x) {
        NSLog(@"每两秒执行一次");
    }];
}


@end
