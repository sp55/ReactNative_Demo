//
//  RACDelegateViewController.m
//  ReactNative
//
//  Created by admin on 16/9/10.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import "RACDelegateViewController.h"

@interface RACDelegateViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation RACDelegateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

#pragma mark - UI 

-(void)initUI{
    self.automaticallyAdjustsScrollViewInsets=NO;
    UITableView * tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
    [self.view addSubview:tableview];

    [[self rac_signalForSelector:@selector(tableView:didSelectRowAtIndexPath:) fromProtocol:@protocol(UITableViewDelegate) ] subscribeNext:^(RACTuple * x) {
        NSLog(@"点击了");
        NSLog(@"%@,%@",x.first,x.second);
    }];
    
    //这样子不带协议是无法代替代理的,虽然能达到效果,这个方法表示某个selector被调用时执行一段代码.带有协议参数的表示该selector实现了某个协议，所以可以用它来实现Delegate。
    [[self rac_signalForSelector:@selector(tableView:didSelectRowAtIndexPath:)] subscribeNext:^(RACTuple* x) {
        NSLog(@"%@",[x class]);
        NSLog(@"%@",x);
    }];
    
    //这里是个坑,必须将代理最后设置,否则信号是无法订阅到的
    //雷纯峰大大是这样子解释的:在设置代理的时候，系统会缓存这个代理对象实现了哪些代码方法
    //如果将代理放在订阅信号前设置,那么当控制器成为代理时是无法缓存这个代理对象实现了哪些代码方法的
    tableview.delegate = self;
    tableview.dataSource = self;
    [tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
}

#pragma mark - 数据源方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 100;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [NSString stringWithFormat:@"点我---%ld",indexPath.row];
    return cell;
}


@end
