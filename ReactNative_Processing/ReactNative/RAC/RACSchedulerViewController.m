//
//  RACSchedulerViewController.m
//  ReactNative
//
//  Created by admin on 16/9/10.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import "RACSchedulerViewController.h"

@interface RACSchedulerViewController ()
@property(nonatomic,strong)RACSignal * testSignal;
@end

@implementation RACSchedulerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSignal];
    [self testTheMethodOfScheduler];
}

#pragma mark - 创建信号
-(void)initSignal{
    RACSignal * signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"sendTestSignal%@",[NSThread currentThread]);
        [subscriber sendNext:@1];
        [subscriber sendCompleted];
        return [RACDisposable disposableWithBlock:^{
        }];
    }];
    self.testSignal = signal;
}

#pragma mark -  测试方法
-(void)testTheMethodOfScheduler{
    [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"sendSignal%@",[NSThread currentThread]);
        [subscriber sendNext:@1];
        return [RACDisposable disposableWithBlock:^{
        }];
    }] subscribeOn:[RACScheduler scheduler]] subscribeNext:^(id x) {
        NSLog(@"receiveSignal%@",[NSThread currentThread]);
    }];
    
//    [[self.testSignal deliverOn:[RACScheduler scheduler]] subscribeNext:^(id x) {
//        NSLog(@"receiveSignal%@",[NSThread currentThread]);
//    }];
    
    
}
@end
