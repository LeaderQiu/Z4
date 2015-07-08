//
//  PXRuname2Cell.m
//  ZhonglieApp
//
//  Created by 邱思雨 on 15/6/8.
//  Copyright (c) 2015年 PX. All rights reserved.
//

#import "PXRunameCell.h"
#import "PXRuname.h"

@interface PXRunameCell () 
@property (weak, nonatomic) IBOutlet UIButton *EditBtn;
@property (weak, nonatomic) IBOutlet UIButton *DeleteBtn;
@property (weak, nonatomic) IBOutlet UILabel *RiqiLabel;
@property (weak, nonatomic) IBOutlet UILabel *NameLabel;

//存放的模型数组
@property(nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation PXRunameCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier target:(id)target action:(SEL)action target2:(id)target2 action2:(SEL)action2
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        /**
         *  初始化cell
         */
        UIView *backV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 49)];
        
        backV.backgroundColor = [UIColor clearColor];
        self.selectedBackgroundView =backV;
        
        self = [[NSBundle mainBundle] loadNibNamed:@"PXRunameCell" owner:nil options:nil].firstObject;
        
        //设置为不可选中
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [_EditBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];

        [_DeleteBtn addTarget:target2 action:action2 forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(void)setRuname:(PXRuname *)Runame
{
    _Runame = Runame;
    
    self.RiqiLabel.text =Runame.created_time;
    
    
    self.NameLabel.text = Runame.title;
}

@end
