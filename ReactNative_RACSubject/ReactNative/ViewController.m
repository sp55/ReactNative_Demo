//
//  ViewController.m
//  ReactNative
//
//  Created by admin on 16/9/8.
//  Copyright © 2016年 AlezJi. All rights
//源码
//https://github.com/SkyHarute/StudyForRACreserved.

//cocoaPods失败原因

//http://www.jianshu.com/p/6e9b27dfb970
//iOS开发RAC学习笔记(一)RACSignal

#import "ViewController.h"


#import "RACSubjectViewController.h"
#import "RACReplaySubjectViewController.h"
#import "RACSubjectDelegateViewController.h"



@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(strong,nonatomic)NSArray *dataArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
-(void)initUI
{
    
    self.dataArr=@[@"RACSubject",@"RACReplaySubject",@"RACSubject代替代理"];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    UITableView * tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
    tableview.tableFooterView = [UIView new];
    [self.view addSubview:tableview];
    tableview.dataSource = self;
    tableview.delegate = self;
    [tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}
#pragma mark - 数据源方法 -
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.dataArr[indexPath.row];
    return cell;
}

#pragma mark - 代理方法 -
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            RACSubjectViewController * vc = [[RACSubjectViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 1:
        {
            RACReplaySubjectViewController * vc =[[RACReplaySubjectViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 2:
        {
            RACSubjectDelegateViewController * vc = [[RACSubjectDelegateViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
            
        default:
            break;
    }
}

@end
