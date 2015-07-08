//
//  PXUserCenterView.m
//  ZhonglieApp
//
//  Created by 邱思雨 on 15/6/11.
//  Copyright (c) 2015年 PX. All rights reserved.
//

#import "PXUserCenterView.h"

@implementation PXUserCenterView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]){
        
        /**
         *  加载xib
         */
        self = [[NSBundle mainBundle] loadNibNamed:@"PXUserCenterView" owner:nil options:nil].firstObject;
    }
        
    return self;
}

@end
