//
//  ReplaySubjectAppleModel.m
//  ReactNative
//
//  Created by admin on 16/9/10.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import "ReplaySubjectAppleModel.h"

@implementation ReplaySubjectAppleModel
-(NSString *)description{
    NSArray * keys = @[@"price",@"weight"];
    return [self dictionaryWithValuesForKeys:keys].description;
}
@end
