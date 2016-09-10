//
//  RACTargetOfUISignalViewController.m
//  ReactNative
//
//  Created by admin on 16/9/10.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import "RACTargetOfUISignalViewController.h"

@interface RACTargetOfUISignalViewController ()
@property(strong,nonatomic)UITextField *tf;

@end

@implementation RACTargetOfUISignalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
-(void)initUI
{
    self.tf=[[UITextField alloc] initWithFrame:CGRectMake(kScreenWidth/2-80, 100, 160,40)];
    [self.tf setBorderStyle:UITextBorderStyleLine];
    self.tf.placeholder = @"TargetOfUI";
    [self.tf setClearButtonMode:UITextFieldViewModeAlways];
    [self.view addSubview:self.tf];
    
    
    //输出textfiled中的数据,具体的第一篇笔记有详细讲述
    [[self.tf rac_textSignal] subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
}
@end
