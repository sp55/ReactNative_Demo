//
//  ReplaySubjectAppleViewModel.h
//  ReactNative
//
//  Created by admin on 16/9/10.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "ReplaySubjectAppleModel.h"
@interface ReplaySubjectAppleViewModel : NSObject
-(RACReplaySubject* )loadInfo;
@end
