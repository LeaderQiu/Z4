//
//  PXZhiWei.h
//  ZhonglieApp
//
//  Created by 邱思雨 on 15/6/17.
//  Copyright (c) 2015年 PX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PXZhiWei : NSObject

/** 职位标题 */
@property (nonatomic, copy) NSString *position_title;
/** 职位状态 */
@property (nonatomic, assign) NSInteger position_status;
/** 是否认证 */
@property (nonatomic, assign) NSInteger position_auth;
/** 职位发布时间 */
@property (nonatomic, copy) NSString *created_time;
/** 年薪 */
@property (nonatomic, copy) NSString *position_salary;
/** 奖励金额 */
@property (nonatomic, copy) NSString *position_reward;
/** 职位诱惑 */
@property (nonatomic, copy) NSString *position_advantage;



@end
