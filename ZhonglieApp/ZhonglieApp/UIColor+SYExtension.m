//
//  UIColor+SYExtension.m
//  ZhonglieApp
//
//  Created by 邱思雨 on 15/6/3.
//  Copyright (c) 2015年 PX. All rights reserved.
//

#import "UIColor+SYExtension.h"

@implementation UIColor (SYExtension)

+ (UIColor *)colorWithRGB:(int)aRGB
{
    int sRed   = (aRGB >> 16) & 0xff;
    int sGreen = (aRGB >>  8) & 0xff;
    int sBlue  = (aRGB      ) & 0xff;
    
    return [UIColor colorWithRed:((CGFloat)sRed / 0xff) green:((CGFloat)sGreen / 0xff) blue:((CGFloat)sBlue / 0xff) alpha:1.0];
}

+ (UIColor *)colorWithRGB:(int)aRGB WithAlpha:(CGFloat)aAlpha
{
    int sRed   = (aRGB >> 16) & 0xff;
    int sGreen = (aRGB >>  8) & 0xff;
    int sBlue  = (aRGB      ) & 0xff;
    
    return [UIColor colorWithRed:((CGFloat)sRed / 0xff) green:((CGFloat)sGreen / 0xff) blue:((CGFloat)sBlue / 0xff) alpha:aAlpha];
}



@end
