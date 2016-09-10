//
//  RACSignalCombinerViewController.m
//  ReactNative
//
//  Created by admin on 16/9/10.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import "RACSignalCombinerViewController.h"

@interface RACSignalCombinerViewController ()
@property(nonatomic,strong)UILabel * lb_name;
@property(nonatomic,strong)UILabel * lb_age;
@property(nonatomic,strong)UITextField * tf_name;
@property(nonatomic,strong)UITextField * tf_age;
@property(nonatomic,strong)RACSignal * signalA;
@property(nonatomic,strong)RACSignal * signalB;
@end

@implementation RACSignalCombinerViewController

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initSignal];
    //信号的依赖
    [self testTheMethodOfConcat];
    //信号的条件执行
//    [self testTheMethodOfThen];
    //信号的组合
//    [self testTheMethodOfMerge];
    //信号的压缩(须成对)
//    [self testTheMethodOfZipWith];
    //信号的压缩,每个信号只要sendNext即可
//    [self testTheMethodOfCombineLatest];
    //信号的聚合
//    [self testOfTheMethodOfReduce];
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

#pragma mark - 创建信号
-(void)initSignal{
    RACSignal * signalA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"A"];
        [subscriber sendCompleted];
        return [RACDisposable disposableWithBlock:^{
        }];
    }];
    RACSignal * signalB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"B"];
        [subscriber sendCompleted];
        return [RACDisposable disposableWithBlock:^{
        }];
    }];
    self.signalA = signalA;
    self.signalB = signalB;
}


#pragma mark - 信号组合处理 -

//信号的依赖
-(void)testTheMethodOfConcat{
    //这相当于网络请求中的依赖,必须先执行完信号A才会执行信号B
    //经常用作一个请求执行完毕后,才会执行另一个请求
    //注意信号A必须要执行发送完成信号,否则信号B无法执行
    RACSignal * concatSignal = [self.signalA concat:self.signalB];
    //这里我们是对这个拼接信号进行订阅
    [concatSignal subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
}

//信号的条件执行
-(void)testTheMethodOfThen{
    //当地一个信号执行完才会执行then后面的信号,同时第一个信号发送出来的东西不会被订阅到
    @weakify(self);
    [[self.signalA then:^RACSignal *{
        @strongify(self);
        return self.signalB;
    }] subscribeNext:^(id x) {
        //这里只会打印出信号B的数据
        NSLog(@"%@",x);
    }];
}

//信号的组合
-(void)testTheMethodOfMerge{
    RACSignal * nameSignal = [self.tf_name rac_textSignal];
    RACSignal * ageSignal = [self.tf_age rac_textSignal];
    //将两个信号组成为一个信号,若其中一个子信号发送了对象,那么组合信号也能够订阅到
    RACSignal * mergeSignal = [nameSignal merge:ageSignal];
    [mergeSignal subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
}

//信号的压缩(须成对)
-(void)testTheMethodOfZipWith{
    //信号A和B会压缩成为一个信号,当二者'同时'发送数据时,并且把两个信号的内容合并成一个元组，才会触发压缩流的next事件
    //注意这里的'同时'二字指的并不是时间上的同时,只要信号A发送,信号B也发送就可以了,并不需要同时,但一定要成对
    RACSignal * zipSignal1 = [self.signalA zipWith:self.signalB];
    [zipSignal1 subscribeNext:^(id x) {
        NSLog(@"--%@",x);
    }];
    
    RACSignal * nameSignal = [self.tf_name rac_textSignal];
    RACSignal * ageSignal = [self.tf_age rac_textSignal];
    RACSignal * zipSignal2 = [nameSignal zipWith:ageSignal];
    //这里会把姓名和年龄输入框的信号包装成一个元祖,这里看起来效果会比较明显,年龄和姓名输入框若多次变动后,他们的信号呈现一个多一个少的情况下那么是无法订阅成功的
    //必须信号称对包装成元祖才可以
    [zipSignal2 subscribeNext:^(id x) {
        NSLog(@"==%@",x);
    }];
    
}

//信号的压缩,每个信号只要sendNext即可
-(void)testTheMethodOfCombineLatest{
    RACSignal * nameSignal = [self.tf_name rac_textSignal];
    RACSignal * ageSignal = [self.tf_age rac_textSignal];
    //和zip相似,只要两个信号都发送过至少一次信号就会执行,不同的是zip要求更为苛刻,需要二者信号每次执行时都必须成对,否则无法订阅成功
    RACSignal * combineSignal = [nameSignal combineLatestWith:ageSignal];
    [combineSignal subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
}

//信号的聚合
-(void)testOfTheMethodOfReduce{
    RACSignal * nameSignal = [self.tf_name rac_textSignal];
    RACSignal * ageSignal = [self.tf_age rac_textSignal];
    //先组合再聚合
    //reduce后的参数需要自己添加,添加以前方传来的信号的数据为准
    //return类似映射,可以对数据进行处理再发送给订阅者
    RACSignal * reduceSignal = [RACSignal combineLatest:@[nameSignal,ageSignal] reduce:^id(NSString * name,NSString * age){
        return [NSString stringWithFormat:@"姓名:%@,年龄:%@",name,age];
    }];
    [reduceSignal subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
}



@end
