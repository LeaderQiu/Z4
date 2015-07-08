//
//  PXSearchHistoryCell.m
//  ZhonglieApp
//
//  Created by 邱思雨 on 15/6/4.
//  Copyright (c) 2015年 PX. All rights reserved.
//

#import "PXSearchHistoryCell.h"
#import "PXSearchLabel.h"

@interface PXSearchHistoryCell ()
@property (weak, nonatomic) IBOutlet UIButton *Btn1;
@property (weak, nonatomic) IBOutlet UIButton *Btn2;
@property (weak, nonatomic) IBOutlet UIButton *Btn3;
@property (weak, nonatomic) IBOutlet UIButton *Btn4;
@property (weak, nonatomic) IBOutlet UIButton *Btn5;
@property (weak, nonatomic) IBOutlet UIButton *Btn6;

/**存放的模型数组*/
@property(nonatomic,strong) NSMutableArray *dataArray1;

@end




@implementation PXSearchHistoryCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        /**
         *  初始化cell
         *
         *  @return
         */

        
        
        
        
        //加载xib
        self = [[NSBundle mainBundle] loadNibNamed:@"PXSearchHistoryCell" owner:nil options:nil].firstObject;
        
        //设置为不可选中
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

//-(void)setSearchLabel:(PXSearchLabel *)searchLabel
//{
//    [self.Btn1 setTitle:searchLabel.title forState:UIControlStateNormal];
//}

- (void)setSearchLabels:(NSArray *)searchLabels {
    
    _searchLabels = searchLabels;
    
    PXSearchLabel *lable01 = searchLabels[0];
    PXSearchLabel *lable02 = searchLabels[1];
    PXSearchLabel *lable03 = searchLabels[2];
    PXSearchLabel *lable04 = searchLabels[3];
    PXSearchLabel *lable05 = searchLabels[4];
    PXSearchLabel *lable06 = searchLabels[5];

    [self.Btn1 setTitle:lable01.title forState:UIControlStateNormal];
    
    [self.Btn2 setTitle:lable02.title forState:UIControlStateNormal];
    
    [self.Btn3 setTitle:lable03.title forState:UIControlStateNormal];
    
    [self.Btn4 setTitle:lable04.title forState:UIControlStateNormal];
    
    [self.Btn5 setTitle:lable05.title forState:UIControlStateNormal];
    
    [self.Btn6 setTitle:lable06.title forState:UIControlStateNormal];
    

//    [_Btn3 setBackgroundColor:[UIColor blackColor]];
}

@end
