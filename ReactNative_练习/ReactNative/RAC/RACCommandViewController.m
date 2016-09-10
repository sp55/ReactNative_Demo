//
//  RACCommandViewController.m
//  ReactNative
//
//  Created by admin on 16/9/8.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

/*
 监听事件完成或者按钮点击
 */

#import "RACCommandViewController.h"

@interface RACCommandViewController ()

@end

@implementation RACCommandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

-(void)initUI{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 100, 20);
    [btn setTitle:@"处理事件" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(didClickEventBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    

    UIButton * btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(100, 200, 100, 20);
    [btn2 setTitle:@"监听事件" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [btn2 addTarget:self action:@selector(didObserceClickBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];

}

-(void)didClickEventBtn{
    RACCommand * command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        NSLog(@"input:%@",input);
        //这里主要体现了一个链式编程的思想
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:@"数据"];
            return nil;
        }];
    }];
    
    [command.executionSignals subscribeNext:^(RACSignal * x) {
        [x subscribeNext:^(id x) {
            NSLog(@"%@",x);
        }];
    }];
    [command execute:@3];

}

-(void)didObserceClickBtn{
    RACCommand * command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        NSLog(@"input:%@",input);
        //这里主要体现了一个链式编程的思想
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:@"数据"];
            [subscriber sendCompleted];
            return nil;
        }];
    }];
    //监听事件是否完成
    [command.executing subscribeNext:^(id x) {
        if ([x boolValue]==YES) {
            NSLog(@"正在执行%@",x);
        } else {
            NSLog(@"执行完成/没有执行");
        }
    }];
    
    [command execute:@1];
}


@end
