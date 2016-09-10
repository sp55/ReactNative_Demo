//
//  ViewModel.h
//  ReactNative
//
//  Created by admin on 16/9/10.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface ViewModel : NSObject

//这里需要对command进行强引用,否则无法执行
@property(nonatomic,strong)RACCommand * command;

@end
