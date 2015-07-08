//
//  PXSuccessViewController.m
//  ZhonglieApp
//
//  Created by 邱思雨 on 15/6/9.
//  Copyright (c) 2015年 PX. All rights reserved.
//

#import "PXSuccessViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "PXRuname2ViewController.h"
#import "Masonry.h"
#import "PXAlerayViewController.h"

@interface PXSuccessViewController ()

@property(nonatomic,strong) UIButton *ChaKanBtn;
@property(nonatomic,strong) UIButton *JiXuBtn;

@end

@implementation PXSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBarController.tabBar.hidden = YES;
    
    self.navigationController.navigationBarHidden = NO;
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"返回键" highImage:@"返回键" target:self action:@selector(BackClickBtn)];
    
    self.navigationItem.title = @"投递成功";
   
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupBtn];
    
    [self setupImage];
}



//导航栏返回键
-(void)BackClickBtn
{
     PXRuname2ViewController *Runame2VC = [[PXRuname2ViewController alloc]init];
    
    CATransition* transition = [CATransition animation];
    transition.type = kCATransitionPush;//可更改为其他方式
    transition.subtype = kCATransitionFromLeft;//可更改为其他方式
    
    [self.navigationController pushViewController:Runame2VC animated:NO];
    
   
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
}

//设置推荐成功图片
-(void)setupImage
{
    UIImageView *SuccessImageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"推荐成功"]];
    
    [self.view addSubview:SuccessImageV];
    
    //SuccessImageV约束
    [SuccessImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(100);
        make.bottom.equalTo(self.view.mas_bottom).offset(-100);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
    }];
    
    
}

//设置两个Btn数据
-(void)setupBtn
{
  
    //设置查看推荐记录按钮
//    UIButton *ChaKanBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 500, 145,48)];
    
    UIButton *ChaKanBtn = [UIButton new];
    _ChaKanBtn = ChaKanBtn;
    
    [ChaKanBtn setBackgroundImage:[UIImage imageNamed:@"查看推荐记录"] forState:UIControlStateNormal];
    
    [ChaKanBtn setTitle:@"查看推荐记录" forState:UIControlStateNormal];
    
    [ChaKanBtn addTarget:self action:@selector(ChaKanClick) forControlEvents:UIControlEventTouchUpInside];

    //设置继续推荐按钮
//    UIButton *JiXuBtn = [[UIButton alloc]initWithFrame:CGRectMake(165, 500, 145, 48)];
    UIButton *JiXuBtn = [UIButton new];
    _JiXuBtn = JiXuBtn;
    
    [JiXuBtn setBackgroundImage:[UIImage imageNamed:@"继续推荐"] forState:UIControlStateNormal];
    
    [JiXuBtn setTitle:@"继续推荐" forState:UIControlStateNormal];
    
    [JiXuBtn addTarget:self action:@selector(JiXuClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:ChaKanBtn];
    [self.view addSubview:JiXuBtn];
    
    //设置两个Btn约束
    int padding1 = 20;
    
    [ChaKanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(padding1);
        make.bottom.equalTo(self.view.mas_bottom).offset(-padding1);
        make.right.equalTo(JiXuBtn.mas_left).offset(-padding1);
        make.height.mas_equalTo(48);
        make.width.equalTo(JiXuBtn);
        
    }];
    
    [JiXuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-padding1);
        make.bottom.equalTo(self.view.mas_bottom).offset(-padding1);
        make.left.equalTo(ChaKanBtn.mas_right).offset(-padding1);
        make.height.mas_equalTo(48);
        
    }];
}

//点击查看
-(void)ChaKanClick
{
    PXAlerayViewController *VC = [[PXAlerayViewController alloc]init];
    
    [self.navigationController pushViewController:VC  animated:YES];
    
    NSLog(@"点击了查看");
}

//点击继续推荐
-(void)JiXuClick
{
    PXRuname2ViewController *Runame2VC = [[PXRuname2ViewController alloc]init];
    
    CATransition* transition = [CATransition animation];
    transition.type = kCATransitionPush;//可更改为其他方式
    transition.subtype = kCATransitionFromLeft;//可更改为其他方式
    //    [self.navigationController.view.layeraddAnimation:transition forKey:kCATransition];
    
    [self.navigationController pushViewController:Runame2VC animated:NO];
}

@end
