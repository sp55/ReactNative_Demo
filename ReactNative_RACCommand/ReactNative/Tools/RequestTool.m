//
//  RequestTool.m
//  ReactNative
//
//  Created by admin on 16/9/10.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import "RequestTool.h"

@implementation RequestTool
+(NSURLSessionDataTask *)GET:(NSString *)URLString
                  parameters:(id)parameters
                    progress:(void (^)(NSProgress * _Nonnull))downloadProgress
                     success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                     failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure{
    NetworkManager * mgr = [NetworkManager shareManager];
    NSURLSessionDataTask * DataTask =[mgr GET:URLString parameters:parameters progress:downloadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,error);
    }];
    return DataTask;
}

+(NSURLSessionDataTask *)POST:(NSString *)URLString
                   parameters:(id)parameters
                     progress:(void (^)(NSProgress * _Nonnull))uploadProgress
                      success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                      failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure{
    NetworkManager * mgr = [NetworkManager shareManager];
    NSURLSessionDataTask * DataTask =[mgr POST:URLString parameters:parameters progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,error);
    }];
    return DataTask;
}

+(void)cancel{
    // 取消网络请求
    [[NetworkManager shareManager].operationQueue cancelAllOperations];
    // 取消任务中的所有网络请求
//    [[NetworkManager shareManager].tasks makeObjectsPerformSelector:@selector(cancel)];
     //杀死Session
//    [[NetworkManager shareManager] invalidateSessionCancelingTasks:YES];
    
}

@end
