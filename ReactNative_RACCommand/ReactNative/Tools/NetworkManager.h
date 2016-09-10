//
//  NetworkManager.h
//  ReactNative
//
//  Created by admin on 16/9/10.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface NetworkManager : AFHTTPSessionManager

//获取单例
+(instancetype)shareManager;

@end
