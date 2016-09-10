//
//  NetworkManager.m
//  ReactNative
//
//  Created by admin on 16/9/10.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import "NetworkManager.h"

@implementation NetworkManager
//三种解析json格式
- (instancetype)init
{
    self = [super init];
    if (!self) return nil;
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain",@"text/html", nil];
    return self;
}

+(instancetype)shareManager{
    static NetworkManager * _instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc]init];
    });
    return _instance;
}

@end
