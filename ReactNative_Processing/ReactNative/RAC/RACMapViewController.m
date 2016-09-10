//
//  RACMapViewController.m
//  ReactNative
//
//  Created by admin on 16/9/10.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import "RACMapViewController.h"

#import "RACReturnSignal.h"


@interface RACMapViewController ()
@property(nonatomic,strong)UILabel * lb_name;
@property(nonatomic,strong)UILabel * lb_age;
@property(nonatomic,strong)UITextField * tf_name;
@property(nonatomic,strong)UITextField * tf_age;
@end

@implementation RACMapViewController

#pragma mark - 生命周期 
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    //测试Map方法
    [self testTheMethodOfMap];
    //测试FlatternMap
    [self testTheMethodOfFlatternMap];
}

-(void)dealloc{
    NSLog(@"销毁");
}

#pragma mark - UI 
-(void)initUI{
    
    UITextField * tf_name = [[UITextField alloc]initWithFrame:CGRectMake(kScreenWidth/2-100, 100,200, 40)];
    tf_name.borderStyle = UITextBorderStyleRoundedRect;
    tf_name.placeholder = @"姓名";
    self.tf_name = tf_name;
    [self.view addSubview:tf_name];

    UITextField * tf_age = [[UITextField alloc]initWithFrame:CGRectMake(kScreenWidth/2-100, 150,200, 40)];
    tf_age.borderStyle = UITextBorderStyleRoundedRect;
    tf_age.placeholder = @"年龄";
    self.tf_age = tf_age;
    [self.view addSubview:tf_age];
    
    UILabel * lb_name = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2-100, 200,200, 40)];
    lb_name.text = @"姓名";
    self.lb_name = lb_name;
    [self.view addSubview:lb_name];
    
    UILabel * lb_age = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2-100, 250,200, 40)];
    lb_age.text = @"年龄";
    self.lb_age = lb_age;
    [self.view addSubview:lb_age];
    
    
}

-(void)testTheMethodOfMap{
    //这里可以使用绑定写法来更快捷的达到目的,这里主要是为了体验map所以就不展示了,详情请看RACSignal的绑定
    //这里的映射(map)前面有讲过主要是为了对block的返回值进行处理
    @weakify(self);
    [[[self.tf_name rac_textSignal] map:^id(id value) {
        return [NSString stringWithFormat:@"名字是:%@",value];
    }] subscribeNext:^(id x) {
        @strongify(self);
        self.lb_name.text = x;
        
    }];
    
}

-(void)testTheMethodOfFlatternMap{
    //FlatternMap返回的是一个信号,而map返回的是信号,一般情况下我们使用的是map,只有信号中的信号我们才会使用FlatternMap
    //同时使用FlatternMap我们需要导入RACReturnSignal.h
    @weakify(self);
    [[[self.tf_age rac_textSignal] flattenMap:^RACStream *(id value) {
        return [RACReturnSignal return:[NSString stringWithFormat:@"年龄是:%@",value]];
    }] subscribeNext:^(id x) {
        @strongify(self);
        self.lb_age.text = x;
    }];
}


@end
