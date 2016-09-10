//
//  PersonModel.m
//  ReactNative
//
//  Created by admin on 16/9/10.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import "PersonModel.h"

@implementation PersonModel
-(NSString *)description{
    NSArray * keys = @[@"name",@"age"];
    return [self dictionaryWithValuesForKeys:keys].description;
}
@end
