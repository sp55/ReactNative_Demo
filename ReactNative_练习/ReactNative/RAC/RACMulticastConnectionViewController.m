//
//  RACMulticastConnectionViewController.m
//  ReactNative
//
//  Created by admin on 16/9/8.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

/*
 可以看到,RACMulticastConnection每次连接一次,信号发送的时候didSubscribeblock都会全部执行一遍,而不仅仅是subscriber发出的东西
 RACMulticastConnection主要运用的场景就是一个信号发出的时候有多个订阅者的情况
 */


#import "RACMulticastConnectionViewController.h"

@interface RACMulticastConnectionViewController ()
@property(nonatomic,strong)RACSignal * signal;

@end

@implementation RACMulticastConnectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self sendSignal];
    [self getSignal];
    [self getSecondSignal];
}

-(void)sendSignal{
    RACSignal * signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"发送信号");
        [subscriber sendNext:@"haha"];
        return nil;
    }];
    self.signal = signal;
    
}

-(void)getSignal{
    RACMulticastConnection * connection = [self.signal publish];
    [connection.signal subscribeNext:^(id x) {
        NSLog(@"1%@",x);
    }];
    [connection.signal subscribeNext:^(id x) {
        NSLog(@"2%@",x);
    }];
    //将信号源转化为热信号
    [connection connect];
}

-(void)getSecondSignal{
    RACMulticastConnection * connection = [self.signal publish];
    [connection.signal subscribeNext:^(id x) {
        NSLog(@"3%@",x);
    }];
    [connection connect];
}

@end
