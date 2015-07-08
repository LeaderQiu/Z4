//
//  PXTools.m
//  ZhonglieApp
//
//  Created by 邱思雨 on 15/6/3.
//  Copyright (c) 2015年 PX. All rights reserved.
//

#import "PXDataTools.h"
#import "PXCityGroup.h"
#import "MJExtension.h"


@implementation PXDataTools


static NSArray *_cityGroups;
+ (NSArray *)cityGroups
{
    if (!_cityGroups) {
        _cityGroups = [PXCityGroup objectArrayWithFilename:@"cityGroups.plist"];
    }
    return _cityGroups;
}

@end
