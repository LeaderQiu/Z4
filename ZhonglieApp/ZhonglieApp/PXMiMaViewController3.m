//
//  PXMiMaViewController3.m
//  ZhonglieApp
//
//  Created by 邱思雨 on 15/6/23.
//  Copyright (c) 2015年 PX. All rights reserved.
//

#import "PXMiMaViewController3.h"
#import "UIBarButtonItem+Extension.h"
#import "Masonry.h"
#import "UIColor+SYExtension.h"
#import "PXUserViewController.h"

@interface PXMiMaViewController3 () <UITextFieldDelegate>

@property(nonatomic,strong) UITextField *TextField1;

@property(nonatomic,strong) UITextField *TextField2;

@end

@implementation PXMiMaViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.navigationController.navigationBarHidden = NO;
    
    self.navigationItem.title = @"修改密码";
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"返回键" highImage:@"返回键" target:self action:@selector(BackClickBtn)];
    

    [self setupData];
}

-(void)setupData
{
    //帐号Lable
    UILabel *Zhanghao = [UILabel new];
    
    Zhanghao.text = @"输入密码";
    
    Zhanghao.textColor = [UIColor colorWithRGB:0x7f7f7f];
    
    Zhanghao.font = [UIFont systemFontOfSize:18];
    
    [self.view addSubview:Zhanghao];
    
    [Zhanghao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(10);
        make.top.equalTo(self.view.mas_top).offset(104);
        make.width.mas_equalTo(80);
    }];
    
    //下划线1
    UIImageView *Image1 = [UIImageView new];
    
    [Image1 setImage:[UIImage imageNamed:@"下划线"]];
    
    [self.view addSubview:Image1];
    
    [Image1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.top.equalTo(Zhanghao.mas_bottom).offset(2);
        make.height.mas_equalTo(5);
    }];
    
    //密码Lable
    UILabel *MiMa = [UILabel new];
    
    MiMa.text = @"确认密码";
    
    MiMa.textColor = [UIColor colorWithRGB:0x7f7f7f];
    
    MiMa.font = [UIFont systemFontOfSize:18];
    
    [self.view addSubview:MiMa];
    
    [MiMa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(10);
        make.top.equalTo(Image1.mas_bottom).offset(40);
        make.width.mas_equalTo(80);
        
    }];
    
    //下划线2
    UIImageView *Image2 = [UIImageView new];
    
    [Image2 setImage:[UIImage imageNamed:@"下划线"]];
    
    [self.view addSubview:Image2];
    
    [Image2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.top.equalTo(MiMa.mas_bottom).offset(2);
        make.height.mas_equalTo(5);
    }];
    
    
    //注册Btn
    UILabel *ZhuCe = [UILabel new];

    ZhuCe.text = @"密码太简单";
    
    ZhuCe.textColor = [UIColor colorWithRGB:0x7f7f7f];
    
    ZhuCe.font = [UIFont systemFontOfSize:18];
    
    [self.view addSubview:ZhuCe];
    
    [ZhuCe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
        make.top.equalTo(Image2.mas_bottom).offset(10);
        
    }];
    
    
    //登录Btn
    UIButton *LoginBtn = [UIButton new];
    
    [LoginBtn setTitle:@"确认修改" forState:UIControlStateNormal];
    
    [LoginBtn setBackgroundImage:[UIImage imageNamed:@"圆角矩形-4"] forState:UIControlStateNormal];
    
    [LoginBtn addTarget:self action:@selector(NextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:LoginBtn];
    
    [LoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.height.mas_equalTo(49);
        make.top.equalTo(ZhuCe.mas_bottom).offset(20);
        
    }];
    
    //TextField1
    UITextField *TextField1 = [UITextField new];
    
    _TextField1 = TextField1;
    
    TextField1.delegate = self;
    
    [self.view addSubview:TextField1];
    
    [TextField1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view);
        make.left.equalTo(Zhanghao.mas_right).offset(10);
        make.height.mas_equalTo(40);
        make.bottom.equalTo(Image1);
    }];
    
    //TextField2
    UITextField *TextField2 = [UITextField new];
    
    _TextField2 = TextField2;
    
    TextField2.delegate = self;
    
    [self.view addSubview:TextField2];
    
    [TextField2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view);
        make.left.equalTo(MiMa.mas_right).offset(10);
        make.height.mas_equalTo(40);
        make.bottom.equalTo(Image2);
    }];
    
    
    
    
}

//点击确认修改按钮
-(void)NextBtnClick
{
    PXUserViewController *VC = [[PXUserViewController alloc]init];
    
    [self.navigationController pushViewController:VC animated:YES];
}

//点击空白收起键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.TextField1 resignFirstResponder];
    
    [self.TextField2 resignFirstResponder];
}


//点击返回键
-(void)BackClickBtn
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
