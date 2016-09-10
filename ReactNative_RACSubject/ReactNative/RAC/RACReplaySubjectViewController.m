//
//  RACReplaySubjectViewController.m
//  ReactNative
//
//  Created by admin on 16/9/10.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import "RACReplaySubjectViewController.h"
#import "ReplaySubjectAppleViewModel.h"
@interface RACReplaySubjectViewController ()

@end

@implementation RACReplaySubjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"RACReplaySubject";
    [self getInfo];
}

//RACReplaySubject对于订阅和发送信号的顺序掌握的比较宽松,可以先发送信号在进行订阅也可以
-(void)getInfo{
    ReplaySubjectAppleViewModel * viewModel = [[ReplaySubjectAppleViewModel alloc]init];
    [[viewModel loadInfo] subscribeNext:^(id x) {
        NSLog(@"%@",x);
    } error:^(NSError *error) {
        NSLog(@"%@",error);
    } completed:^{
        NSLog(@"完成");
    }];
}

@end
