//
//  RACSubjectViewController.m
//  ReactNative
//
//  Created by admin on 16/9/10.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import "RACSubjectViewController.h"
#import "SubjectPersonViewModel.h"
@interface RACSubjectViewController ()

@end

@implementation RACSubjectViewController

#pragma mark - 生命周期 -
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"RACSubject";
    [self getInfo];
}


-(void)getInfo{
    SubjectPersonViewModel * viewModel = [[SubjectPersonViewModel alloc]init];
    //这是错误做法,先发送信号再订阅信号的话对于RACSubject来说的话是不可以的,RACReplaySubject可以先发送信号再去订阅
    //    [viewModel loadInfo];
    //先获取到RACSubject,再订阅他,和RACSignal基本相同的方式
    [[viewModel getSubject] subscribeNext:^(id x) {
        NSLog(@"%@",x);
    } error:^(NSError *error) {
        NSLog(@"%@",error);
    } completed:^{
        NSLog(@"完成");
    }];
    //发送信号
    [viewModel loadInfo];
}


@end
