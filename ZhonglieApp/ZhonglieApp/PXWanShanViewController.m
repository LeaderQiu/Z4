//
//  PXWanShanViewController.m
//  ZhonglieApp
//
//  Created by 邱思雨 on 15/6/24.
//  Copyright (c) 2015年 PX. All rights reserved.
//

#import "PXWanShanViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "UIColor+SYExtension.h"
#import "Masonry.h"
#import "PXSuccessViewController.h"
#import "PXRuname2ViewController.h"

@interface PXWanShanViewController ()<UITextFieldDelegate>

@property(nonatomic,strong) UITextField *TF1;
@property(nonatomic,strong) UITextField *TF2;
@property(nonatomic,strong) UITextField *TF3;
@property(nonatomic,strong) UITextField *TF4;
@property(nonatomic,strong) UITextField *TF5;

@end

@implementation PXWanShanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = NO;
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"返回键" highImage:@"返回键" target:self action:@selector(BackBtnClick)];
    
    self.navigationItem.title = @"完善信息";
   
//    self.view.backgroundColor = [UIColor colorWithRGB:0xececec];
    
    [self setupData];
    
}

//加载data
-(void)setupData
{
    UIScrollView *BackV = [UIScrollView new];
    
    BackV.backgroundColor = [UIColor colorWithRGB:0xececec];
    
    BackV.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    BackV.userInteractionEnabled = YES;
    BackV.scrollEnabled = YES;
    
    [self.view addSubview:BackV];
    
    [BackV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.equalTo(self.view);
    }];
    
    //添加收款信息Label
    UILabel *Label = [UILabel new];
    
    Label.text = @"收款信息";
    
    Label.font = [UIFont systemFontOfSize:20];
    
    [BackV addSubview:Label];
    
    [Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(BackV.mas_left).offset(10);
        make.top.equalTo(BackV.mas_top).offset(20);
    }];
    
    //添加dataV
    UIView *dataV = [UIView new];
    
    dataV.backgroundColor = [UIColor whiteColor];
    
    [BackV addSubview:dataV];
    
    [dataV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(300);
        make.top.equalTo(Label.mas_bottom).offset(20);
        make.width.equalTo(BackV);
        make.left.equalTo(BackV);
    }];
    
    //添加dataV内部控件
    
    int padding1 = 300/5;
    
    UIView *View1 = [UIView new];
    UIView *View2 = [UIView new];
    UIView *View3 = [UIView new];
    UIView *View4 = [UIView new];
    
    View1.backgroundColor = [UIColor colorWithRGB:0xececec];
    View2.backgroundColor = [UIColor colorWithRGB:0xececec];
    View3.backgroundColor = [UIColor colorWithRGB:0xececec];
    View4.backgroundColor = [UIColor colorWithRGB:0xececec];
    
    [dataV addSubview:View1];
    [dataV addSubview:View2];
    [dataV addSubview:View3];
    [dataV addSubview:View4];
    
    [View1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.left.equalTo(dataV);
        make.width.equalTo(dataV);
        make.top.equalTo(dataV.mas_top).offset(padding1*1);
    }];
    
    [View2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.left.equalTo(dataV);
        make.width.equalTo(dataV);
        make.top.equalTo(dataV.mas_top).offset(padding1*2);
    }];
    
    [View3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.left.equalTo(dataV);
        make.width.equalTo(dataV);
        make.top.equalTo(dataV.mas_top).offset(padding1*3);
    }];
    
    [View4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.left.equalTo(dataV);
        make.width.equalTo(dataV);
        make.top.equalTo(dataV.mas_top).offset(padding1*4);
    }];
    
    UILabel *Label1 = [UILabel new];
    UILabel *Label2 = [UILabel new];
    UILabel *Label3 = [UILabel new];
    UILabel *Label4 = [UILabel new];
    UILabel *Label5 = [UILabel new];
//
    Label1.text = @"真实姓名";
    Label2.text = @"移动电话";
    Label3.text = @"电子邮箱";
    Label4.text = @"银行卡号";
    Label5.text = @"开户行名称";
    
    Label1.font = [UIFont systemFontOfSize:20];
    Label2.font = [UIFont systemFontOfSize:20];
    Label3.font = [UIFont systemFontOfSize:20];
    Label4.font = [UIFont systemFontOfSize:20];
    Label5.font = [UIFont systemFontOfSize:20];
//
    [dataV addSubview:Label1];
    [dataV addSubview:Label2];
    [dataV addSubview:Label3];
    [dataV addSubview:Label4];
    [dataV addSubview:Label5];
//
    [Label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(dataV.mas_left).offset(10);
        make.height.mas_equalTo(20);
        make.bottom.equalTo(View1.mas_top).offset(-20);
        make.width.mas_equalTo(100);
    }];

    [Label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(dataV.mas_left).offset(10);
        make.height.mas_equalTo(20);
        make.bottom.equalTo(View2.mas_top).offset(-20);
        make.width.mas_equalTo(100);
    }];

    
    [Label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(dataV.mas_left).offset(10);
        make.height.mas_equalTo(20);
        make.bottom.equalTo(View3.mas_top).offset(-20);
        make.width.mas_equalTo(100);
    }];

    
    [Label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(dataV.mas_left).offset(10);
        make.height.mas_equalTo(20);
        make.bottom.equalTo(View4.mas_top).offset(-20);
        make.width.mas_equalTo(100);
    }];

    
    [Label5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(dataV.mas_left).offset(10);
        make.height.mas_equalTo(20);
        make.top.equalTo(View4.mas_bottom).offset(20);
        make.width.mas_equalTo(100);
    }];
    
    UITextField *TF1 = [UITextField new];
    UITextField *TF2 = [UITextField new];
    UITextField *TF3 = [UITextField new];
    UITextField *TF4 = [UITextField new];
    UITextField *TF5 = [UITextField new];
    
    _TF1 = TF1;
    _TF2 = TF2;
    _TF3 = TF3;
    _TF4 = TF4;
    _TF5 = TF5;
    
    TF1.delegate = self;
    TF2.delegate = self;
    TF3.delegate = self;
    TF4.delegate = self;
    TF5.delegate = self;
    
  
    TF4.placeholder = @"银行卡号需本人身份证开户";
   
    
    TF1.textAlignment = UITextAlignmentRight;
    TF2.textAlignment = UITextAlignmentRight;
    TF3.textAlignment = UITextAlignmentRight;
    TF4.textAlignment = UITextAlignmentRight;
    TF5.textAlignment = UITextAlignmentRight;
    
    [dataV addSubview:TF1];
    [dataV addSubview:TF2];
    [dataV addSubview:TF3];
    [dataV addSubview:TF4];
    [dataV addSubview:TF5];
    
    [TF1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(dataV).offset(-10);
        make.bottom.equalTo(View1).offset(-10);
        make.left.equalTo(Label1.mas_right).offset(10);
        make.height.mas_equalTo(40);
    }];
    
    [TF2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(dataV).offset(-10);
        make.bottom.equalTo(View2).offset(-3);
        make.left.equalTo(Label2.mas_right).offset(10);
        make.height.mas_equalTo(40);
    }];
    
    [TF3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(dataV).offset(-10);
        make.bottom.equalTo(View3).offset(-3);
        make.left.equalTo(Label3.mas_right).offset(10);
        make.height.mas_equalTo(40);
    }];
    
    [TF4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(dataV).offset(-10);
        make.bottom.equalTo(View4).offset(-3);
        make.left.equalTo(Label4.mas_right).offset(10);
        make.height.mas_equalTo(40);
    }];
    
    [TF5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(dataV).offset(-10);
        make.bottom.equalTo(BackV).offset(-3);
        make.left.equalTo(Label5.mas_right).offset(10);
        make.height.mas_equalTo(40);
    }];
    
    UIButton *TJBtn = [UIButton new];
    UIButton *TGBtn = [UIButton new];
    
    [TJBtn setBackgroundImage:[UIImage imageNamed:@"矩形-3"] forState:UIControlStateNormal];
    [TGBtn setBackgroundImage:[UIImage imageNamed:@"矩形-3-拷贝"] forState:UIControlStateNormal];
    
    [TJBtn setTitle:@"提交" forState:UIControlStateNormal];
    [TGBtn setTitle:@"跳过" forState:UIControlStateNormal];
    
    [TJBtn addTarget:self action:@selector(TJBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [TGBtn addTarget:self action:@selector(TGBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [BackV addSubview:TJBtn];
    [BackV addSubview:TGBtn];
    
    [TJBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(BackV.mas_left).offset(10);
        make.right.equalTo(dataV.mas_right).offset(-10);
        make.top.equalTo(dataV.mas_bottom).offset(10);
        make.height.mas_equalTo(49);
    }];
    
    [TGBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(BackV.mas_left).offset(10);
        make.right.equalTo(dataV.mas_right).offset(-10);
        make.top.equalTo(TJBtn.mas_bottom).offset(10);
        make.height.mas_equalTo(49);
    }];

}
//点击了跳过按钮
-(void)TGBtnClick
{
    PXSuccessViewController *VC = [PXSuccessViewController new];
    
    [self.navigationController pushViewController:VC animated:YES];
    
    NSLog(@"点击了跳过按钮");
}

//点击了提交按钮
-(void)TJBtnClick
{
    
    PXSuccessViewController *VC = [PXSuccessViewController new];
    
    [self.navigationController pushViewController:VC animated:YES];
    
    NSLog(@"点击了提交按钮");
}


//点击空白收键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_TF1 resignFirstResponder];
    [_TF2 resignFirstResponder];
    [_TF3 resignFirstResponder];
    [_TF4 resignFirstResponder];
    [_TF5 resignFirstResponder];
}
//点击键盘搜索键手键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_TF1 resignFirstResponder];
    [_TF2 resignFirstResponder];
    [_TF3 resignFirstResponder];
    [_TF4 resignFirstResponder];
    [_TF5 resignFirstResponder];
    return YES;
}

//导航栏返回键
-(void)BackBtnClick
{
    PXRuname2ViewController *VC = [PXRuname2ViewController new];
    
    [self.navigationController pushViewController:VC animated:YES];
}

@end
