//
//  PXTools.h
//  ZhonglieApp
//
//  Created by 邱思雨 on 15/6/3.
//  Copyright (c) 2015年 PX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PXDataTools : NSObject

/**
 *  返回所有的城市组数据（里面都是HMCityGroup模型）
 */
+ (NSArray *)cityGroups;

/**
 *  返回所有的城市名称（里面都是NSString）
 */
//+ (NSArray *)cityNames;

@end
