//
//  RACSubjectViewController.m
//  ReactNative
//
//  Created by admin on 16/9/8.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import "RACSubjectViewController.h"

@interface RACSubjectViewController ()

@end

@implementation RACSubjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建信号
    RACSubject * subject = [RACSubject subject];
    //订阅信号
    [subject subscribeNext:^(id x) {
        NSLog(@"此处先订阅信号,信号传值是%@",x);
    }];
    //发送信号
    [subject sendNext:@2];
}
/*
 注意 RACSubject和RACReplaySubject的区别 RACSubject必须要先订阅信号之后才能发送信号， 而RACReplaySubject可以先发送信号后订阅.
 */


@end
