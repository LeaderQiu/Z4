//
//  PXSearchHistoryCell.m
//  ZhonglieApp
//
//  Created by 邱思雨 on 15/6/4.
//  Copyright (c) 2015年 PX. All rights reserved.
//

#import "PXSearchHistoryCell.h"
#import "PXSearchLabel.h"
#import "PXMainViewController.h"
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



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier target:(id)target action:(SEL)action target2:(id)target2 action2:(SEL)action2 target3:(id)target3 action3:(SEL)action3 target4:(id)target4 action4:(SEL)action4 target5:(id)target5 action5:(SEL)action5 target6:(id)target6 action6:(SEL)action6
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
        
        [_Btn1 addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        
        [_Btn2 addTarget:target2 action:action2 forControlEvents:UIControlEventTouchUpInside];
        
        [_Btn3 addTarget:target3 action:action3 forControlEvents:UIControlEventTouchUpInside];
        
        [_Btn4 addTarget:target4 action:action4 forControlEvents:UIControlEventTouchUpInside];
        
        [_Btn5 addTarget:target5 action:action5 forControlEvents:UIControlEventTouchUpInside];
        
        [_Btn6 addTarget:target6 action:action6 forControlEvents:UIControlEventTouchUpInside];
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
  
#warning TODO 热搜标签传值问题
    PXMainViewController *MainVC = [[PXMainViewController alloc]init];
    MainVC.SearchLabel1  = lable01.title;
    
    NSLog(@"SearchLabel1%@",MainVC.SearchLabel1);

    [self.Btn1 setTitle:lable01.title forState:UIControlStateNormal];
    
    [self.Btn2 setTitle:lable02.title forState:UIControlStateNormal];
    
    [self.Btn3 setTitle:lable03.title forState:UIControlStateNormal];
    
    [self.Btn4 setTitle:lable04.title forState:UIControlStateNormal];
    
    [self.Btn5 setTitle:lable05.title forState:UIControlStateNormal];
    
    [self.Btn6 setTitle:lable06.title forState:UIControlStateNormal];
    

//    [_Btn3 setBackgroundColor:[UIColor blackColor]];
}

@end
