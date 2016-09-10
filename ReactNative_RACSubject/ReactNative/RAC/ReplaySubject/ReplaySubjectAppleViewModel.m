//
//  ReplaySubjectAppleViewModel.m
//  ReactNative
//
//  Created by admin on 16/9/10.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import "ReplaySubjectAppleViewModel.h"

@interface ReplaySubjectAppleViewModel ()
@property(nonatomic,strong)NSMutableArray * dataArray;
@end

@implementation ReplaySubjectAppleViewModel
-(RACReplaySubject* )loadInfo{
    RACReplaySubject * replaySubject = [RACReplaySubject subject];
    BOOL isError = NO;
    if (isError) {
        [replaySubject sendError:[NSError errorWithDomain:@"baidu" code:2333 userInfo:@{@"errorMessage":@"异常错误"}]];
    } else {
        [self creatInfo];
        [replaySubject sendNext:self.dataArray];
    }
    [replaySubject sendCompleted];
    return replaySubject;
}

#pragma mark - 创建数据
-(void)creatInfo{
    _dataArray = [NSMutableArray array];
    for (int i =0; i<20; i++) {
        ReplaySubjectAppleModel  * model = [[ReplaySubjectAppleModel  alloc]init];
        model.price = [NSString stringWithFormat:@"%@",@(1 + arc4random_uniform(3))];
        model.weight =[NSString stringWithFormat:@"%@",@(15 + arc4random_uniform(20))];
        [_dataArray addObject:model];
    }
}

@end
