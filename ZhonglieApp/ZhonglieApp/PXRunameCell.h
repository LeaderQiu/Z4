//
//  PXRuname2Cell.h
//  ZhonglieApp
//
//  Created by 邱思雨 on 15/6/8.
//  Copyright (c) 2015年 PX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PXRuname;
@interface PXRunameCell : UITableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier target:(id)target action:(SEL)action target2:(id)target2 action2:(SEL)action2;

//暴露一个模型
@property (nonatomic,strong) PXRuname *Runame;

@end
