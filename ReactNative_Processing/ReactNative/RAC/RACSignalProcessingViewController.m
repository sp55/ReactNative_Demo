//
//  RACSignalProcessingViewController.m
//  ReactNative
//
//  Created by admin on 16/9/10.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import "RACSignalProcessingViewController.h"

@interface RACSignalProcessingViewController ()
@property(nonatomic,strong)UITextField * tf_name;
@property(nonatomic,strong)UITextField * tf_age;
@property(nonatomic,strong)RACSignal * nameSignal;
@property(nonatomic,strong)RACSignal * ageSignal;
@property(nonatomic,strong)RACSignal * testSignal;
@end

@implementation RACSignalProcessingViewController

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initSignal];
    //过滤
//    [self testOfTheMethodOfFilter];
    //忽略
//    [self testOfTheMethodOfIgnore];
    //数据不同信号才会被订阅到
//    [self testTheMethodOfDistinctUntilChanged];
    //获取前n个信号
//    [self testTheMethodOfTake];
    //获取最后几次信号
//    [self testTheMethodOfTakeLast];
    //跳过几个信号不接收
//    [self testTheMethodOfSkip];
    //获取信号中信号的最新(最后一个)信号
    [self testTheMethodOfSwitcToLatest];
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

}
#pragma mark - 创建信号
-(void)initSignal{
    RACSignal * nameSignal = [self.tf_name rac_textSignal];
    RACSignal * ageSignal = [self.tf_age rac_textSignal];
    self.nameSignal = nameSignal;
    self.ageSignal = ageSignal;
    RACSignal * signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@1];
        [subscriber sendNext:@1];
        [subscriber sendNext:@2];
        [subscriber sendNext:@1];
        [subscriber sendNext:@1];
        [subscriber sendNext:@3];
        [subscriber sendNext:@1];
        [subscriber sendNext:@1];
        [subscriber sendNext:@1];
        [subscriber sendCompleted];
        return [RACDisposable disposableWithBlock:^{
        }];
    }];
    self.testSignal = signal;
}





#pragma mark - 测试方法
//过滤
-(void)testOfTheMethodOfFilter{
    //对value进行过滤,若value的值满足条件订阅者才能够订阅到
    [[self.nameSignal filter:^BOOL(NSString * value) {
        //NSLog(@"value--%@",value);
        return value.length>3;
    }] subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
}

//忽略
-(void)testOfTheMethodOfIgnore{
    //当信号传输的数据时ignore后的参数时,订阅者就会忽略这个信号,ignore可以嵌套,一般用来判断非空
    [[[self.nameSignal ignore:@"A"] ignore:@"B"] subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
}

//数据不同信号才会被订阅到
-(void)testTheMethodOfDistinctUntilChanged{
    //输入不同的字符才会获取到数值,可以用在对服务器的请求上过滤一些相同的请求,降低服务器压力
    //演示效果可能不太好,我重新写一组信号
    [[self.nameSignal distinctUntilChanged] subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    //从这里可以看出只有与上一个信号所传递的值不相同订阅者才会打印
    [[self.testSignal distinctUntilChanged] subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
}

//获取前n个信号
-(void)testTheMethodOfTake{
    [[self.testSignal take:3] subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
}

//获取最后几次信号
-(void)testTheMethodOfTakeLast{
    [[self.testSignal takeLast:3] subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
}

//对信号的监听条件释放
-(void)testTheMethodOfTakeUntil{
    //当对象被销毁后将不再监听
    //这里takeuntil后面的参数可以自己创建信号
    [[self.nameSignal takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
}

//跳过几个信号不接收
-(void)testTheMethodOfSkip{
    [[self.testSignal skip:5] subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
}

//获取信号中信号的最新(最后一个)信号
-(void)testTheMethodOfSwitcToLatest{
    RACSignal * signalOfSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:self.testSignal];
        [subscriber sendCompleted];
        return [RACDisposable disposableWithBlock:^{
        }];
    }];
    [[signalOfSignal switchToLatest] subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
}
@end
