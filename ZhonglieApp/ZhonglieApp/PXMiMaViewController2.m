//
//  PXMiMaViewController2.m
//  ZhonglieApp
//
//  Created by 邱思雨 on 15/6/12.
//  Copyright (c) 2015年 PX. All rights reserved.
//

#import "PXMiMaViewController2.h"
#import "UIBarButtonItem+Extension.h"
#import "PXMiMaViewController1.h"
#import "Masonry.h"
#import "UIColor+SYExtension.h"
#import "PXMiMaViewController3.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"

@interface PXMiMaViewController2 ()<UITextFieldDelegate>

@property(nonatomic,strong) UITextField *TextField1;

@property(nonatomic,strong) UITextField *TextField2;

@property(nonatomic,assign)  NSInteger YanZhengMa;

@end

@implementation PXMiMaViewController2

- (void)viewDidLoad {
    
    self.navigationController.navigationBarHidden = NO;
    
    self.navigationItem.title = @"快速注册";
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"返回键" highImage:@"返回键" target:self action:@selector(BackClickBtn)];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self setupData];
}


-(void)setupData
{
    //帐号Lable
    UILabel *Zhanghao = [UILabel new];
    
    Zhanghao.text = @"电话号码";
    
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
    
    MiMa.text = @"验证码";
    
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
    
    
    //验证码不正确
    UILabel *ZhuCe = [UILabel new];
    
    ZhuCe.text = @"";
    
    ZhuCe.textColor = [UIColor colorWithRGB:0x7f7f7f];
    
    ZhuCe.font = [UIFont systemFontOfSize:18];
    
    [self.view addSubview:ZhuCe];
    
    [ZhuCe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-10);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(20);
        make.top.equalTo(Image2.mas_bottom).offset(10);
        
    }];
    
    
    //登录Btn
    UIButton *LoginBtn = [UIButton new];
    
    [LoginBtn setTitle:@"下一步" forState:UIControlStateNormal];
    
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
    
    //获取验证码
    UIButton *YZBtn = [UIButton new];
    
    [self.view addSubview:YZBtn];
    
    [YZBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [YZBtn setTitleColor:[UIColor colorWithRGB:0x0d8dd1] forState:UIControlStateNormal];
    
    [YZBtn addTarget:self action:@selector(YZBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [YZBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.bottom.equalTo(Image1.mas_top).offset(3);
        make.width.mas_equalTo(100);
    }];
    
    
}

//点击了获取验证码
-(void)YZBtnClick
{
    NSLog(@"点击了获取验证码%@",_TextField1.text);
    
    if ([_TextField1.text isEqualToString:@""]) {
        MBProgressHUD *hud =   [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        
        // Configure for text only and offset down
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"手机号码不能为空";
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        
        [hud hide:YES afterDelay:1.5];
    }else{
    MBProgressHUD *hud =   [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"验证码已发送";
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    
    [hud hide:YES afterDelay:1.5];
    
    
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *pamas = @{@"user_mobile":_TextField1.text};
    
    [mgr POST:@"http://123.57.147.235/index.php/home/user/userRegister" parameters:pamas success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
        NSLog(@"获取验证码%@",responseObject);
        
        NSInteger str = [[responseObject objectForKey:@"data"] intValue];
        
//        int code = [[responseObject objectForKey:@"data"] intValue];
//        
//        if (code != 1000) {
//            MBProgressHUD *hud =   [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
//            
//            // Configure for text only and offset down
//            hud.mode = MBProgressHUDModeText;
//            hud.labelText = @"此帐号已被注册";
//            hud.margin = 10.f;
//            hud.removeFromSuperViewOnHide = YES;
//            
//            [hud hide:YES afterDelay:1.5];
//        }else{
            self.YanZhengMa = str;
//        }
        
       
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
//        
//        MBProgressHUD *hud =   [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
//        
//        // Configure for text only and offset down
//        hud.mode = MBProgressHUDModeText;
//        hud.labelText = @"此帐号已被注册";
//        hud.margin = 10.f;
//        hud.removeFromSuperViewOnHide = YES;
//        
//        [hud hide:YES afterDelay:1.5];

    }];
    }

}

//点击确认修改按钮
-(void)NextBtnClick
{
    PXMiMaViewController3 *M3VC = [[PXMiMaViewController3 alloc]init];
    
    M3VC.Phonenumber = _TextField1.text;
    
    
    if ([_TextField2.text intValue] == self.YanZhengMa) {
        
        
        PXMiMaViewController3 *VC = [[PXMiMaViewController3 alloc]init];
        
        [self.navigationController pushViewController:VC animated:YES];


    }else{
        
                MBProgressHUD *hud =   [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        
                // Configure for text only and offset down
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"验证码输入有误";
                hud.margin = 10.f;
                hud.removeFromSuperViewOnHide = YES;
        
                [hud hide:YES afterDelay:1.5];
        
        NSLog(@"验证码输入有误==》|%zd|   |%zd|",_TextField2.text,self.YanZhengMa);
        

        
    }
    
}

//点击空白收起键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.TextField1 resignFirstResponder];
    
    [self.TextField2 resignFirstResponder];
    
    
}

//收起键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [_TextField1 resignFirstResponder];
    
    [_TextField2 resignFirstResponder];
    
    return YES;
}


//导航栏返回键
-(void)BackClickBtn
{
    PXMiMaViewController1 *MiMaV1 = [[PXMiMaViewController1 alloc]init];
    
    [self.navigationController pushViewController:MiMaV1 animated:YES];
}

@end
