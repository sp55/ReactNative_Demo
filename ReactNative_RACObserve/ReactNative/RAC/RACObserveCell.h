//
//  RACObserveCell.h
//  ReactNative
//
//  Created by admin on 16/9/11.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RACObserveModel.h"
@interface RACObserveCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property(strong,nonatomic)RACObserveModel *observeModel;

@end
