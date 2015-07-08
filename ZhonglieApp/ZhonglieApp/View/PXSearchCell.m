//
//  PXSearchCell.m
//  ZhonglieApp
//
//  Created by 邱思雨 on 15/6/5.
//  Copyright (c) 2015年 PX. All rights reserved.
//

#import "PXSearchCell.h"


@interface PXSearchCell ()

@property (weak, nonatomic) IBOutlet UILabel *SearchLable;


@end



@implementation PXSearchCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        /**
         *  初始化cell
         *
         *  @return <#return value description#>
         */
        
        
        self = [[NSBundle mainBundle] loadNibNamed:@"PXSearchCell" owner:nil options:nil].firstObject;
        
        //设置为不可选中
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(NSString *)model
{
    _model = model;
    
    _SearchLable.text = model;
}

@end
