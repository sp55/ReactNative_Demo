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
#import "RNDefine.h"
#import "PersonViewModel.h"



@interface ViewController ()
@property(nonatomic,strong)UILabel * lb_name;
@property(nonatomic,strong)UILabel * lb_age;
@property(nonatomic,strong)UITextField * tf_name;
@property(nonatomic,strong)UITextField * tf_age;
@property(nonatomic,strong)UIButton * btn_event;

@property (strong, nonatomic)NSArray * dataArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    //获取信息
    [self getInfo];
    //处理事件
    [self handlingEvents];
    [self twoWayBinding];
}
-(void)initUI
{
    UITextField * tf_name = [[UITextField alloc]initWithFrame:CGRectMake(kScreenWidth/2-100, 100,200, 40)];
    tf_name.borderStyle = UITextBorderStyleLine;
    tf_name.placeholder = @"姓名";
    self.tf_name = tf_name;
    [self.view addSubview:tf_name];
    
    UITextField * tf_age = [[UITextField alloc]initWithFrame:CGRectMake(kScreenWidth/2-100, 150,200, 40)];
    tf_age.borderStyle = UITextBorderStyleLine;
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
    
    UIButton * btn_event = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_event.frame = CGRectMake(kScreenWidth/2-100, 300, 200, 40);
    [btn_event setTitle:@"监听事件" forState:UIControlStateNormal];
    [btn_event setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn_event setBackgroundColor:[UIColor redColor]];
    self.btn_event = btn_event;
    [self.view addSubview:btn_event];
    
    
}

#warning RAC在使用的时候由于系统提供的信号是始终存在的,所以在block中使用属性或者成员变量几乎都会涉及到一个循环引用的问题,有两种方法可以解决,使用weakself解决或者RAC提供的weak-strong dance
//在 block 的外部使用 @weakify(self)
//在 block 的内部使用 @strongify(self)
-(void)dealloc{
    NSLog(@"已销毁");
}

#pragma mark - 获取信息 -
-(void)getInfo{
    PersonViewModel * viewModel = [[PersonViewModel alloc]init];
    //这是signal对象方法中能把三种情况全部列举出来的对象方法,根据需求决定,一般使用最简单的就好
    [[viewModel loadInfo] subscribeNext:^(id x) {
        //接收到正常发送信号,并打印信号传过来的信息
        NSLog(@"%@",x);
        self.dataArray = [NSArray array];
        self.dataArray = x;
        
    } error:^(NSError *error) {
        //接收到错误信号,并打印出错误信息
        NSLog(@"%@",error);
    } completed:^{
        //接收到完成信号,并打印出完成信息,若为错误信号则不打印
        NSLog(@"完成");
        
    }];
}

#pragma mark - 处理事件 -
-(void)handlingEvents{
    @weakify(self);
    //按钮点击
    [[self.btn_event rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        NSLog(@"%@",self.dataArray.firstObject);
    }];
    
    
    //name输入框输入内容实时监听
    [[self.tf_name rac_textSignal] subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
    //年龄输入框输入内容实时监听
    [[self.tf_age rac_textSignal] subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
    //信号组合获取,注意将id类型改为RACTuple
    [[RACSignal combineLatest:@[self.tf_name.rac_textSignal,self.tf_age.rac_textSignal]] subscribeNext:^(RACTuple *x) {
        NSString * name = x.first;
        NSString * age = x.second;
        NSLog(@"name:%@,age:%@",name,age);
    }];
    
    //根据textfield内容决定按钮是否可以点击
    // reduce 中，可以通过接收的参数进行计算，并且返回需要的数值！
    [[RACSignal combineLatest:@[self.tf_name.rac_textSignal,self.tf_age.rac_textSignal] reduce:^id(NSString * name , NSString * age){
        return @(name.length>0&&age.length>0);
    }] subscribeNext:^(id x) {
        @strongify(self);
        self.btn_event.enabled = [x boolValue];
        
    }];
    
}

#pragma mark - 双向绑定
-(void)twoWayBinding{
    //一般双向绑定是指UI控件和模型互相绑定的,一般是在在改变一个值的情况下另外一个对象也会改变,类似KVO;
    //这里为了更好的体现出效果所以采用了textfield绑定到模型,模型绑定到label的做法,比较好理解
    //UI绑定模型
    PersonModel * model = [[PersonModel alloc]init];
    model = self.dataArray.firstObject;
    RAC(self.lb_name,text)=RACObserve(model, name);
    
#warning 这里不能使用基本数据类型,RAC中传递的都是id类型,使用基本类型会崩溃
    RAC(self.lb_age,text)=[RACObserve(model, age) map:^id(id value) {
        return [value description];
    }];
    //模型到UI
    [[RACSignal combineLatest:@[self.tf_name.rac_textSignal,self.tf_age.rac_textSignal]] subscribeNext:^(RACTuple * x) {
        model.name = x.first;
        model.age = [x.second intValue];
    }];
    //直接双向绑定
    //    RACChannelTo(self.lb_name,text) = RACChannelTo(model, name);
    
}

@end
