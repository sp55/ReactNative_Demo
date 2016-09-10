//
//  RACNotificationViewController.m
//  ReactNative
//
//  Created by admin on 16/9/10.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import "RACNotificationViewController.h"

@interface RACNotificationViewController ()
@property(strong,nonatomic)UITextField *tf;
@end

@implementation RACNotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initUI];
    
    [self sendNotification];
    [self getNotification];
}
-(void)initUI
{
    self.tf=[[UITextField alloc] initWithFrame:CGRectMake(kScreenWidth/2-80, 100, 160,40)];
    [self.tf setBorderStyle:UITextBorderStyleLine];
    self.tf.placeholder = @"RAC通知";
    [self.tf setClearButtonMode:UITextFieldViewModeAlways];
    [self.view addSubview:self.tf];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
-(void)getNotification{
    //代替通知
    //takeUntil会接收一个signal,当signal触发后会把之前的信号释放掉
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardDidShowNotification object:nil] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        NSLog(@"键盘弹出");
    }];
    
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardDidHideNotification object:nil] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        NSLog(@"键盘消失");
    }];
    
    
    //这个写法有个问题,这样子写信号不会被释放,当你再次收到键盘弹出的通知时他会叠加上次的信号进行执行,并一直叠加下去,所以我们在用上面的写法
    //    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardDidShowNotification object:nil] subscribeNext:^(id x) {
    //        NSLog(@"键盘弹出");
    //    }];
    
    //这里这样写只是为了给大家开拓一种思路,selector的方法可以应需求更改,即当这个方法执行后,产生一个信号告知控制器释放掉这个订阅的信号
    RACSignal * deallocSignal = [self rac_signalForSelector:@selector(viewWillDisappear:)];
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"haha" object:nil] takeUntil:deallocSignal] subscribeNext:^(id x) {
        NSLog(@"haha");
    }];
    
}
-(void)sendNotification{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"haha" object:nil userInfo:nil];
}
-(void)dealloc{
    
    NSLog(@"控制器销毁");
}

@end
