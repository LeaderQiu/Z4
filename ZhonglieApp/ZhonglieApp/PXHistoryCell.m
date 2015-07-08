//
//  PXHistoryCell.m
//  ZhonglieApp
//
//  Created by 邱思雨 on 15/6/9.
//  Copyright (c) 2015年 PX. All rights reserved.
//

#import "PXHistoryCell.h"
#import "PXOrderCell.h"

@interface PXHistoryCell ()

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *salary;
@property (weak, nonatomic) IBOutlet UILabel *createdtime;
@property (weak, nonatomic) IBOutlet UILabel *reward;
@property (weak, nonatomic) IBOutlet UIImageView *image;

/**存放的模型数组*/
@property(nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation PXHistoryCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        /**
         *  初始化cell
         */
        
        self = [[NSBundle mainBundle] loadNibNamed:@"PXHistoryCell" owner:nil options:nil].firstObject;
    }
    return self;
}

-(void)setOrderList:(PXOrderCell *)OrderList
{
    _OrderList = OrderList;
    
    self.title.text = OrderList.position_title;
    
    self.salary.text = OrderList.position_salary;
    
    self.reward.text = OrderList.position_reward;
    
    self.createdtime.text = OrderList.position_created_time;
    
    
}

@end
