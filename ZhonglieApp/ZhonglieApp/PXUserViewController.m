//
//  PXUserViewController.m
//  ZhonglieApp
//
//  Created by 邱思雨 on 15/5/25.
//  Copyright (c) 2015年 PX. All rights reserved.
//

#import "PXUserViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "UIColor+SYExtension.h"
#import "PXUserCenterView.h"
#import "AFNetworking.h"
#import "PXMiMaViewController1.h"
#import "Masonry.h"
#import "PXAlerayViewController.h"
#import "PXMiMaViewController3.h"
#import "PXRunameViewController.h"


@interface PXUserViewController () <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property(nonatomic,strong) UITextField *TF1;
@property(nonatomic,strong) UITextField *TF2;
@property(nonatomic,strong) UITextField *TF3;
@property(nonatomic,strong) UITextField *TF4;
@property(nonatomic,strong) UITextField *TF5;

@property(nonatomic,strong) UIView *OutV;

@end

@implementation PXUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image: [UIImage imageNamed:@"我的"]selectedImage:[UIImage imageNamed:@"我的-hover"]];
    
    self.navigationController.tabBarItem.title = @"我的";
    
    self.navigationController.navigationBarHidden = YES;
    
    self.view.backgroundColor = [UIColor colorWithRGB:0xececec];
    
    [self setupHeaderV];
    
    [self setupBtnV];
    
    [self setupTableV];
 
}

//设置头部数据
-(void)setupHeaderV
{
    
    UIView *HeaderV = [UIView new];
    
    UIImageView *BackImageV = [UIImageView new];
    UIImageView *LogoImageV = [UIImageView new];
    
    [BackImageV setImage:[UIImage imageNamed:@"形状-1"]];
    [LogoImageV setImage:[UIImage imageNamed:@"Logo形状-2"]];
    
    [BackImageV addSubview:LogoImageV];
    [HeaderV addSubview:BackImageV];
    [self.view addSubview:HeaderV];
    
    //HeaderV约束
    [HeaderV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.height.mas_equalTo(159);
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
    }];
    
    //BackImageV约束
    [BackImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(HeaderV);
        make.height.equalTo(HeaderV);
        make.top.equalTo(HeaderV);
        make.left.equalTo(HeaderV);
    }];
    
    //LogoImageV约束
    [LogoImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(BackImageV);
        make.width.mas_equalTo(97);
        make.height.mas_equalTo(97);
    }];
    
}


//设置BtnView数据
-(void)setupBtnV
{
    UIView *BtnV = [[UIView alloc]initWithFrame:CGRectMake(0, 159, self.view.bounds.size.width, 51)];
    
    UIButton *TJJLBtn = [UIButton new];
    
    [TJJLBtn setBackgroundImage:[UIImage imageNamed:@"矩形-6"] forState:UIControlStateNormal];
    
    [TJJLBtn setTitle:@"推荐记录" forState:UIControlStateNormal];

    [TJJLBtn setTitleColor:[UIColor colorWithRGB:0x25a1db] forState:UIControlStateNormal];
    
    [TJJLBtn addTarget:self action:@selector(TJJLBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [BtnV addSubview:TJJLBtn];
    
    //TJJLBtn约束
    int padding1 = [UIScreen mainScreen].bounds.size.width/2;
    
    [TJJLBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(51);
        make.width.mas_equalTo(padding1);
        make.top.equalTo(BtnV);
        make.left.equalTo(BtnV);
        
    }];

    
//    UIButton *JJGLBtn = [[UIButton alloc]initWithFrame:CGRectMake(161, 0, 161, 51)];
    UIButton *JJGLBtn = [UIButton new];
    
    [JJGLBtn setBackgroundImage:[UIImage imageNamed:@"矩形-6"] forState:UIControlStateNormal];
    
    [JJGLBtn setTitle:@"简历管理" forState:UIControlStateNormal];
    
    [JJGLBtn setTitleColor:[UIColor colorWithRGB:0x25a1db] forState:UIControlStateNormal];
    
    [JJGLBtn addTarget:self action:@selector(JJGLBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [BtnV addSubview:JJGLBtn];
    [self.view addSubview:BtnV];
    
    //JJGLBtn约束
    [JJGLBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(51);
        make.width.mas_equalTo(padding1);
        make.left.equalTo(TJJLBtn.mas_right);
        make.right.equalTo(BtnV);
        make.top.equalTo(BtnV);
    }];
    
 

    
}

//设置TableV数据
-(void)setupTableV
{
    UIScrollView *TableV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 220, [UIScreen mainScreen].bounds.size.width, 500)];
    
    [self.view addSubview:TableV];
    
    TableV.backgroundColor = [UIColor colorWithRGB:0xececec];
  
    TableV.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 800);
    TableV.userInteractionEnabled = YES;
    TableV.scrollEnabled = YES;
    
    //加载dataV
    UIView *dataV = [UIView new];
    
    dataV.backgroundColor = [UIColor whiteColor];
    
    [TableV addSubview:dataV];
    
    [dataV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.height.mas_equalTo(250);
        make.top.equalTo(TableV.mas_top);
    }];
    
    int padding1 = (250-(18*5))/10;
    int padding2 = 250/5;
    
    //加载DataV内部控件
    UIImageView *Image1 = [UIImageView new];
    UIImageView *Image2 = [UIImageView new];
    UIImageView *Image3 = [UIImageView new];
    UIImageView *Image4 = [UIImageView new];
    UIImageView *Image5 = [UIImageView new];
    
    [Image1 setImage:[UIImage imageNamed:@"star-100"]];
    [Image2 setImage:[UIImage imageNamed:@"iphone-75"]];
    [Image3 setImage:[UIImage imageNamed:@"message-75"]];
    [Image4 setImage:[UIImage imageNamed:@"矩形-4"]];
    [Image5 setImage:[UIImage imageNamed:@"apartment-100"]];
    
    [dataV addSubview:Image1];
    [dataV addSubview:Image2];
    [dataV addSubview:Image3];
    [dataV addSubview:Image4];
    [dataV addSubview:Image5];
    
    [Image1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(dataV.mas_top).offset(padding1);
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(18);
    }];
    
    [Image2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(Image1.mas_bottom).offset(padding1*2);
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(18);
    }];
    
    [Image3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(Image2.mas_bottom).offset(padding1*2);
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(18);
    }];
    
    [Image4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(Image3.mas_bottom).offset(padding1*2);
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(18);
    }];
    
    [Image5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(Image4.mas_bottom).offset(padding1*2);
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(18);
    }];
    
    UILabel *Label1 = [UILabel new];
    UILabel *Label2 = [UILabel new];
    UILabel *Label3 = [UILabel new];
    UILabel *Label4 = [UILabel new];
    UILabel *Label5 = [UILabel new];
    
    Label1.text = @"真实姓名";
    Label2.text = @"移动电话";
    Label3.text = @"电子邮箱";
    Label4.text = @"银行卡号";
    Label5.text = @"开户行";
    
    [dataV addSubview:Label1];
    [dataV addSubview:Label2];
    [dataV addSubview:Label3];
    [dataV addSubview:Label4];
    [dataV addSubview:Label5];
    
    [Label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(Image1).offset(2);
        make.left.equalTo(Image1.mas_right).offset(10);
        make.width.mas_equalTo(80);
        
    }];
    
    [Label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(Image2).offset(2);
        make.left.equalTo(Image2.mas_right).offset(10);
        make.width.mas_equalTo(80);
        
    }];
    
    [Label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(Image3).offset(2);
        make.left.equalTo(Image3.mas_right).offset(10);
        make.width.mas_equalTo(80);
        
    }];
    
    [Label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(Image4).offset(2);
        make.left.equalTo(Image4.mas_right).offset(10);
        make.width.mas_equalTo(80);
        
    }];
    
    [Label5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(Image5).offset(2);
        make.left.equalTo(Image5.mas_right).offset(10);
        make.width.mas_equalTo(80);
        
    }];
    
    UIView *backV1 = [UIView new];
    UIView *backV2 = [UIView new];
    UIView *backV3 = [UIView new];
    UIView *backV4 = [UIView new];
   
    
    backV1.backgroundColor = [UIColor colorWithRGB:0xececec];
    backV2.backgroundColor = [UIColor colorWithRGB:0xececec];
    backV3.backgroundColor = [UIColor colorWithRGB:0xececec];
    backV4.backgroundColor = [UIColor colorWithRGB:0xececec];
    
    
    [dataV addSubview:backV1];
    [dataV addSubview:backV2];
    [dataV addSubview:backV3];
    [dataV addSubview:backV4];
  
    [backV1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.top.equalTo(dataV.mas_top).offset(padding2*1);
        make.left.equalTo(dataV.mas_left).offset(30);
        make.right.equalTo(dataV.mas_right).offset(-10);
    }];
    [backV2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.top.equalTo(dataV.mas_top).offset(padding2*2);
        make.left.equalTo(dataV.mas_left).offset(30);
        make.right.equalTo(dataV.mas_right).offset(-10);
    }];

    [backV3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.top.equalTo(dataV.mas_top).offset(padding2*3);
        make.left.equalTo(dataV.mas_left).offset(30);
        make.right.equalTo(dataV.mas_right).offset(-10);
    }];

    [backV4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.top.equalTo(dataV.mas_top).offset(padding2*4);
        make.left.equalTo(dataV.mas_left).offset(30);
        make.right.equalTo(dataV.mas_right).offset(-10);
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
    
    TF1.placeholder = @"冯明";
    TF2.placeholder = @"18510086666";
    TF3.placeholder = @"fengming@163.com";
    TF4.placeholder = @"6217************821";
    TF5.placeholder = @"中国建设银行";
    
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
        make.bottom.equalTo(backV1).offset(-3);
        make.left.equalTo(Label1.mas_right).offset(10);
        make.height.mas_equalTo(40);
    }];
    
    [TF2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(dataV).offset(-10);
        make.bottom.equalTo(backV2).offset(-3);
        make.left.equalTo(Label2.mas_right).offset(10);
        make.height.mas_equalTo(40);
    }];
    
    [TF3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(dataV).offset(-10);
        make.bottom.equalTo(backV3).offset(-3);
        make.left.equalTo(Label3.mas_right).offset(10);
        make.height.mas_equalTo(40);
    }];
    
    [TF4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(dataV).offset(-10);
        make.bottom.equalTo(backV4).offset(-3);
        make.left.equalTo(Label4.mas_right).offset(10);
        make.height.mas_equalTo(40);
    }];
    
    [TF5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(dataV).offset(-10);
        make.bottom.equalTo(dataV).offset(-3);
        make.left.equalTo(Label5.mas_right).offset(10);
        make.height.mas_equalTo(40);
    }];

    


//    //加载MiMaV
    
    UIView *MiMaV = [[UIView alloc]initWithFrame:CGRectMake(0, 260, self.view.bounds.size.width, 51)];
    MiMaV.backgroundColor = [UIColor whiteColor];
    
    UIImageView *MiMaImageV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 19, 18, 18)];
    [MiMaImageV setImage:[UIImage imageNamed:@"lock-256"]];
    
    UIButton *MiMaBtn = [[UIButton alloc]initWithFrame:CGRectMake(38, 0, 300, 51)];
    [MiMaBtn setTitle:@"密码中心" forState:UIControlStateNormal];
    
    //title居左
    MiMaBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    //title颜色
    [MiMaBtn setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    
    MiMaBtn.userInteractionEnabled = YES;
    
    [MiMaBtn addTarget:self action:@selector(MiMaClick) forControlEvents:UIControlEventTouchUpInside];
    
    [MiMaV addSubview:MiMaImageV];
    [MiMaV addSubview:MiMaBtn];
    [TableV addSubview:MiMaV];
    //加载用户登出按钮
    UIView *OutV = [[UIView alloc]initWithFrame:CGRectMake(0, 311, self.view.bounds.size.width, 300)];
    
    _OutV  = OutV;
    
    OutV.backgroundColor = [UIColor clearColor];
    
    UIButton *TuiChuBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, self.view.bounds.size.width-20, 49)];
    
    [TuiChuBtn setBackgroundImage:[UIImage imageNamed:@"退出登录"] forState:UIControlStateNormal];
    
    [TuiChuBtn setTitle:@"帐号退出" forState:UIControlStateNormal];
    
    [OutV addSubview:TuiChuBtn];
    
    [TableV addSubview:OutV];

    [self.view addSubview:TableV];
}

//密码中心点击事件
-(void)MiMaClick
{
    PXMiMaViewController3 *VC = [[PXMiMaViewController3 alloc]init];
    
    [self.navigationController pushViewController:VC animated:YES];
    
    NSLog(@"点击了密码中心");
}

//推荐记录Btn点击事件
-(void)TJJLBtnClick
{
    PXAlerayViewController *VC = [[PXAlerayViewController alloc]init];
    
    [self.navigationController pushViewController:VC animated:YES];
    
    
}

//点击简历管理按钮
-(void)JJGLBtnClick
{
    PXRunameViewController *VC = [PXRunameViewController new];
    
    [self.navigationController pushViewController:VC animated:YES];
    
}
//view消失时显示导航栏
-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
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

@end
