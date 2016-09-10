//
//  RACKVOViewController.m
//  ReactNative
//
//  Created by admin on 16/9/10.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import "RACKVOViewController.h"

@interface RACKVOViewController ()

@end

@implementation RACKVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

#pragma mark - UI
-(void)initUI{
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:scrollView];
    
    UIView * contentView = [[UIView alloc]initWithFrame:CGRectInset(scrollView.frame, 100, 100)];
    contentView.backgroundColor = [UIColor redColor];
    [scrollView addSubview:contentView];
    
 
    //代替KVO
    [RACObserve(scrollView, contentOffset) subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
    
}


@end
