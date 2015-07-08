//
//  PXOrderCell.h
//  ZhonglieApp
//
//  Created by 邱思雨 on 15/7/8.
//  Copyright (c) 2015年 PX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PXOrderCell : NSObject

@property(nonatomic,strong) NSString* order_status;
@property(nonatomic,strong) NSString* position_created_time;
@property(nonatomic,strong) NSString* position_reward;
@property (nonatomic,strong) NSString *position_salary;
@property (nonatomic,strong) NSString *position_title;

@end
