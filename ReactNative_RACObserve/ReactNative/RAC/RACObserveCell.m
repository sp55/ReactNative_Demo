//
//  RACObserveCell.m
//  ReactNative
//
//  Created by admin on 16/9/11.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import "RACObserveCell.h"
#import "RNDefine.h"
@implementation RACObserveCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    [[RACObserve(self,observeModel)ignore:nil]subscribeNext:^(id x) {
        self.titleLabel.text = self.observeModel.title;
    }];
    

}



@end
