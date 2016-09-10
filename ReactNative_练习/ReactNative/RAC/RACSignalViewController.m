//
//  RACSignalViewController.m
//  ReactNative
//
//  Created by admin on 16/9/8.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import "RACSignalViewController.h"
/*
 总结
 
 .核心：
 .核心：信号类
 .信号类的作用：只要有数据改变就会把数据包装成信号传递出去
 .只要有数据改变就会有信号发出
 .数据发出，并不是信号类发出，信号类不能发送数据
 .使用方法：
 .创建信号
 .订阅信号
 .实现思路：
 .当一个信号被订阅，创建订阅者，并把nextBlock保存到订阅者里面。
 .创建的时候会返回 [RACDynamicSignal createSignal:didSubscribe];
 .调用RACDynamicSignal的didSubscribe
 .发送信号[subscriber sendNext:value];
 .拿到订阅者的nextBlock调用
 */
@interface RACSignalViewController ()
@property(nonatomic,strong)RACSignal * signal;
@end

@implementation RACSignalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

-(void)initUI{
    UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 80, 100, 40);
    [btn setTitle:@"点我" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn addTarget:self action:@selector(btnDidClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)btnDidClick{
    //创建信号
    RACSignal * signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"信号内容/signal content"];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"此时取消订阅");
        }];
    }];
    self.signal = signal;
    [self getSignal];
}

-(void)getSignal{
    //订阅信号同时返回一个取消订阅信号的对象
    //订阅信号
    RACDisposable * disposable = [self.signal subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    //完成后我们要取消订阅
    [disposable dispose];
}

-(void)dealloc{
    
}


@end
