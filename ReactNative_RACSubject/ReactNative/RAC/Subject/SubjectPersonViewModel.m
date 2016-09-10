//
//  SubjectPersonViewModel.m
//  ReactNative
//
//  Created by admin on 16/9/10.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import "SubjectPersonViewModel.h"


@interface SubjectPersonViewModel ()
@property(nonatomic,strong)NSMutableArray <SubjectPersonModel*>* dataArray;
@property(nonatomic,strong)RACSubject * subject;
@end

@implementation SubjectPersonViewModel
#pragma mark - 读取数据 -

-(RACSubject *)getSubject{
    RACSubject * subject = [RACSubject subject];
    self.subject = subject;
    return subject;
    
}
-( void)loadInfo{
    BOOL isError = NO;
    if (isError) {
        [self.subject sendError:[NSError errorWithDomain:@"baidu" code:2333 userInfo:@{@"errorMessage":@"异常错误"}]];
    }else{
        [self creatInfo];
        [self.subject sendNext:_dataArray];
    }
    [self.subject sendCompleted];
    
}

#pragma mark - 创建数据 -
-(void)creatInfo{
    _dataArray = [NSMutableArray array];
    for (int i =0; i<20; i++) {
        SubjectPersonModel * model = [[SubjectPersonModel alloc]init];
        model.name = [@"zhangsan" stringByAppendingFormat:@"%d",i];
        model.age = 15 + arc4random_uniform(20);
        [_dataArray addObject:model];
    }
}

@end
