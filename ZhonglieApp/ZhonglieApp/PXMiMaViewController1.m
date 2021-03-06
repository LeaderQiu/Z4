//
//  PXMiMaViewController1.m
//  ZhonglieApp
//
//  Created by 邱思雨 on 15/6/12.
//  Copyright (c) 2015年 PX. All rights reserved.
//

#import "PXMiMaViewController1.h"
#import "UIBarButtonItem+Extension.h"
#import "PXMiMaViewController2.h"
#import "Masonry.h"
#import "UIColor+SYExtension.h"
#import "PXUserViewController.h"
#import "AFNetworking.h"
#import "PXLogin.h"
#import "MJExtension.h"


@interface PXMiMaViewController1 ()<UITextFieldDelegate>

@property(nonatomic,strong) UITextField *TextField1;

@property(nonatomic,strong) UITextField *TextField2;

/**存放的职位列表模型数组*/
@property(nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation PXMiMaViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = NO;
    
    self.navigationItem.title = @"帐号登录";
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"返回键" highImage:@"返回键" target:self action:@selector(BackClickBtn)];
    
    self.view.backgroundColor = [UIColor whiteColor];

    
    [self setupData];
    
   
}

//懒加载
-(NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

-(void)setupData
{
    //帐号Lable
    UILabel *Zhanghao = [UILabel new];
    
    Zhanghao.text = @"帐号";
    
    Zhanghao.textColor = [UIColor colorWithRGB:0x7f7f7f];
    
    Zhanghao.font = [UIFont systemFontOfSize:18];
    
    [self.view addSubview:Zhanghao];
    
    [Zhanghao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(10);
        make.top.equalTo(self.view.mas_top).offset(104);
        make.width.mas_equalTo(40);
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
    
    MiMa.text = @"密码";
    
    MiMa.textColor = [UIColor colorWithRGB:0x7f7f7f];
    
    MiMa.font = [UIFont systemFontOfSize:18];
    
    [self.view addSubview:MiMa];
    
    [MiMa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(10);
        make.top.equalTo(Image1.mas_bottom).offset(40);
        make.width.mas_equalTo(40);
        
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
    
    //忘记密码Btn
    UIButton *WangJinBtn = [UIButton new];
    
    [WangJinBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [WangJinBtn setTitleColor:[UIColor colorWithRGB:0x0d8dd1] forState:UIControlStateNormal];
    
    [WangJinBtn addTarget:self action:@selector(WangjiBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:WangJinBtn];
    
    [WangJinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(9);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(20);
        make.top.equalTo(Image2.mas_bottom).offset(10);
        
    }];
    
    //注册Btn
    UIButton *ZhuCe = [UIButton new];
    
    [ZhuCe setTitle:@"注册" forState:UIControlStateNormal];
    [ZhuCe setTitleColor:[UIColor colorWithRGB:0x0d8dd1] forState:UIControlStateNormal];
    [ZhuCe setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight]; //设置右对齐
    
    [ZhuCe addTarget:self action:@selector(ZhuCeClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:ZhuCe];
    
    [ZhuCe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-10);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(20);
        make.top.equalTo(Image2.mas_bottom).offset(10);
        
    }];
    
    
    //登录Btn
    UIButton *LoginBtn = [UIButton new];
    
    [LoginBtn setTitle:@"登录" forState:UIControlStateNormal];
    
    [LoginBtn setBackgroundImage:[UIImage imageNamed:@"圆角矩形-4"] forState:UIControlStateNormal];
    
    [LoginBtn addTarget:self action:@selector(NextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:LoginBtn];
    
    [LoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.height.mas_equalTo(49);
        make.top.equalTo(WangJinBtn.mas_bottom).offset(20);
        
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

//注册Btn点击
-(void)ZhuCeClick
{
    PXMiMaViewController2 *VC = [[PXMiMaViewController2 alloc]init];
    
    [self.navigationController pushViewController:VC animated:YES];
    
    NSLog(@"点击了注册");
}

//忘记密码Btn点击
-(void)WangjiBtnClick
{
    PXMiMaViewController2 *VC = [[PXMiMaViewController2 alloc]init];
    
    [self.navigationController pushViewController:VC animated:YES];
    
    NSLog(@"点击了忘记密码");
    
    
}




//登录按钮点击事件
-(void)NextBtnClick
{
    NSLog(@"点击了登录");
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *pamas = @{@"user_mobile":@"15911056241",@"user_passwd":@""};
    
    [mgr POST:@"http://123.57.147.235/index.php/home/user/userLogin" parameters:pamas success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
        NSLog(@"帐号登录成功回调%@",responseObject);
        
        NSArray *dictArray = [responseObject objectForKey:@"data"];
        NSMutableArray *tempArray = [NSMutableArray array];
        
        for (NSDictionary *dict in dictArray) {
            
            PXLogin *login = [PXLogin objectWithKeyValues:dict];
            
            [tempArray addObject:login];
        }
        
        [self.dataArray addObjectsFromArray:tempArray];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        NSLog(@"帐号登录失败回调%@",error);
    }];
    
    PXUserViewController *VC = [[PXUserViewController alloc]init];
    
    [self.navigationController pushViewController:VC animated:YES];
}

//导航栏返回键
-(void)BackClickBtn
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

//点击空白收起键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.TextField1 resignFirstResponder];
    
    [self.TextField2 resignFirstResponder];
}


@end
