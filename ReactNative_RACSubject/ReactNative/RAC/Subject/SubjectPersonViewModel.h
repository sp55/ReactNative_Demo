//
//  SubjectPersonViewModel.h
//  ReactNative
//
//  Created by admin on 16/9/10.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SubjectPersonModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
@interface SubjectPersonViewModel : NSObject

-(RACSubject *)getSubject;
-(void)loadInfo;

@end
