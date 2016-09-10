//
//  RACSubjectDelegateNextViewController.m
//  ReactNative
//
//  Created by admin on 16/9/10.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import "RACSubjectDelegateNextViewController.h"

@interface RACSubjectDelegateNextViewController ()

@end

@implementation RACSubjectDelegateNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];    
    UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(kScreenWidth/2-50, 100, 100, 40);
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
//返回
-(void)btnAction
{
    if (self.delagetaSubject) {
        [self.delagetaSubject sendNext:@"haha"];
    //若想要持续代理必须注释掉这一步
//       self.delagetaSubject sendCompleted];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
