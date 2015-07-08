//
//  PXCityGroup.h
//  ZhonglieApp
//
//  Created by 邱思雨 on 15/6/3.
//  Copyright (c) 2015年 PX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PXCityGroup : NSObject

/**
 *  组名
 */
@property (nonatomic,copy) NSString *title;
/**
 *  组里城市的名称
 */
@property (nonatomic,strong) NSArray *cities;
@end
