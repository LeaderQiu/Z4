//
//  PXMainCell.m
//  ZhonglieApp
//
//  Created by mukang on 15/5/28.
//  Copyright (c) 2015年 PX. All rights reserved.
//

#import "PXMainCell.h"
#import "PXZhiWei.h"

@interface PXMainCell ()

@property (strong, nonatomic) IBOutlet UILabel *positionTitle;

@property (strong,nonatomic) IBOutlet UILabel *positionSalary;
@property (weak, nonatomic) IBOutlet UILabel *positionAdvantage;
@property (weak, nonatomic) IBOutlet UILabel *createdTime;
@property (strong,nonatomic) IBOutlet UILabel *positionReward;
@property (weak, nonatomic) IBOutlet UIImageView *positionAuth;
@property (weak, nonatomic) IBOutlet UIImageView *positionStatus;


/**存放的模型数组*/
@property(nonatomic,strong) NSMutableArray *dataArray;

@end


@implementation PXMainCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];
        
        
        /**
         *  这里写初始化cell内部控件的代码
         */
        
        //加载xib
        self = [[NSBundle mainBundle] loadNibNamed:@"PXMainCell" owner:nil options:nil].firstObject;
        
        [self.positionTitle sizeToFit];
        
        
    }
    
    return self;
}

-(void)setZhiWei:(PXZhiWei *)zhiWei
{
    _zhiWei = zhiWei;
    
    self.positionTitle.text = zhiWei.position_title;
    
    self.positionSalary.text = zhiWei.position_salary;
    
    self.positionAdvantage.text = zhiWei.position_advantage;
    
    self.createdTime.text = zhiWei.created_time;
    
    self.positionReward.text = zhiWei.position_reward;
    
    self.positionAuth.hidden = zhiWei.position_auth;
    
    self.positionStatus.hidden = !zhiWei.position_status;
}



@end
