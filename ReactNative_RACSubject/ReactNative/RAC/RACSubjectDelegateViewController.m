//
//  RACSubjectDelegateViewController.m
//  ReactNative
//
//  Created by admin on 16/9/10.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import "RACSubjectDelegateViewController.h"
#import "RACSubjectDelegateNextViewController.h"
@interface RACSubjectDelegateViewController ()
@property(nonatomic,strong)RACSubject * subject;
@end

@implementation RACSubjectDelegateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"RACSubjectDelegate";

    
    UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(kScreenWidth/2-50, 100, 100, 40);
    [btn setTitle:@"下一页" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
//跳转到第二个页面
-(void)btnAction
{
    RACSubjectDelegateNextViewController *vc =[[RACSubjectDelegateNextViewController alloc] init];
    RACSubject * subject = [RACSubject subject];
    //将即将跳转的控制器对其RACSubject属性进行赋值,如果跳转页要让他的代理来做什么只需要发送响应的信号就可以了
    vc.delagetaSubject = subject;
    self.subject = subject;
    //这里有个原则,那就是还是要先订阅在发送信号
    [self getInfo];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - 订阅信号
-(void)getInfo{
    
    [self.subject subscribeNext:^(id x) {
        NSLog(@"result--%@",x);
    } error:^(NSError *error) {
        NSLog(@"%@",error);
    } completed:^{
        NSLog(@"完成");
    }];
}

@end
