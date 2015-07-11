//
//  PXSearchHistoryCell.h
//  ZhonglieApp
//
//  Created by 邱思雨 on 15/6/4.
//  Copyright (c) 2015年 PX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PXSearchLabel;
@interface PXSearchHistoryCell : UITableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier target:(id)target action:(SEL)action target2:(id)target2 action2:(SEL)action2 target3:(id)target3 action3:(SEL)action3 target4:(id)target4 action4:(SEL)action4 target5:(id)target5 action5:(SEL)action5 target6:(id)target6 action6:(SEL)action6;

@property (nonatomic, strong) NSArray *searchLabels;

@end
