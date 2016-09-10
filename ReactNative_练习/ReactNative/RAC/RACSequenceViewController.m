//
//  RACSequenceViewController.m
//  ReactNative
//
//  Created by admin on 16/9/8.
//  Copyright © 2016年 AlezJi. All rights reserved.
//
/*
 RACSequence可以更高效的遍历数组和字典
 */

#import "RACSequenceViewController.h"

@interface RACSequenceViewController ()

@end

@implementation RACSequenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray * array = @[@1,@2,@3,@4,@5,@4,@3,@2,@1];
    NSDictionary * dict = @{@"key1":@1,@"key2":@2,@"key3":@3};
    [self loadNsarray:array];
    [self loadDictionary:dict];
}

//读取
-(void)loadNsarray:(NSArray*)array{
    [array.rac_sequence.signal subscribeNext:^(id x) {
        NSLog(@"arrar-%@",[x class]);
    }error:^(NSError *error) {
        NSLog(@"arrar-%@",error);
    }completed:^{
        NSLog(@"arrar-完成");
    }];
}

-(void)loadDictionary:(NSDictionary*)dict{
    
    [dict.rac_sequence.signal subscribeNext:^(id x) {
        NSLog(@"dict-%@",x);
    }error:^(NSError *error) {
        NSLog(@"dict-%@",error);
    }completed:^{
        NSLog(@"dict-完成");
    }];
}


@end
