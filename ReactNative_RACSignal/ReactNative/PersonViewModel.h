//
//  PersonViewModel.h
//  ReactNative
//
//  Created by admin on 16/9/10.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "PersonModel.h"
@interface PersonViewModel : NSObject
-(RACSignal*)loadInfo;
@end
