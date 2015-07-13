//
//  PXDetail.h
//  ZhonglieApp
//
//  Created by 邱思雨 on 15/7/13.
//  Copyright (c) 2015年 PX. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PXDescription,PXCompany,PXPosition,PXRequir;

@interface PXDetail : NSObject

@property (nonatomic,strong) PXRequir *requir;

@property (nonatomic,strong) PXCompany *company;

@property (nonatomic,strong) PXDescription *description1;

@property (nonatomic,strong) PXPosition *position;


@end
