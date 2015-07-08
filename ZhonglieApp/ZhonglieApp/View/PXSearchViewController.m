//
//  PXSearchViewController.m
//  ZhonglieApp
//
//  Created by 邱思雨 on 15/5/29.
//  Copyright (c) 2015年 PX. All rights reserved.
//

#import "PXSearchViewController.h"
#import "PXMainCell.h"
#import "UIBarButtonItem+Extension.h"
#import "Masonry.h"
#import "PXCityViewController.h"
#import "UIColor+SYExtension.h"


@interface PXSearchViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property(nonatomic,strong) UITableView *SearchV;
@property(nonatomic,strong) UITextField *TextField;
@end

@implementation PXSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //优化导航栏
    self.navigationController.navigationItem.title = @"";
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"返回键" highImage:@"返回键" target:self action:@selector(btnClickAction)];
    
    self.navigationItem.title = @"职位搜索";
   
    
    [self setupFirstV];

   
    
    [self setupTableV];
}

//导航栏返回键
-(void)btnClickAction
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

//加载头部视图
-(void)setupFirstV
{
    UIView *FirstV = [[UIView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 55)];

    
    //加载搜索栏
    UITextField *TextField = [UITextField new];
    
    _TextField = TextField;
    
    [self setupTextFiel];
    
    [FirstV addSubview:TextField];
    
   
    
    //加载地区选择Btn
    UIButton *Diqu = [UIButton new];

    [Diqu setTitleColor:[UIColor colorWithRGB:0x419dd6] forState:UIControlStateNormal];
    
    [Diqu addTarget:self action:@selector(DiquBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [FirstV addSubview:Diqu];
    
    [Diqu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(FirstV);
        make.left.equalTo(FirstV.mas_left).offset(10);
        make.width.mas_equalTo(70);
        make.top.equalTo(FirstV.mas_top).offset(10);
        make.bottom.equalTo(FirstV.mas_bottom).offset(-10);
    }];
    
    UILabel *Label1 = [UILabel new];
    
    Label1.text = @"北京";
    
    Label1.textColor = [UIColor colorWithRGB:0x419dd6];
    
    [Diqu addSubview:Label1];
    
    [self.view addSubview:FirstV];
    
    [Label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(Diqu.mas_left);
        make.top.equalTo(Diqu.mas_top).offset(10);
        make.bottom.equalTo(Diqu.mas_bottom).offset(-10);
    }];
    
    UIImageView *Image = [UIImageView new];
    
    [Image setImage:[UIImage imageNamed:@"下三角1"]];
    
    [Diqu addSubview:Image];
    
    [Image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(6);
        make.left.equalTo(Label1.mas_right).offset(10);
        make.centerY.equalTo(Label1);
    }];
    
    
    //TextField约束
    [TextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(Diqu.mas_right).offset(10);
        make.right.equalTo(FirstV).offset(-10);
        make.top.equalTo(FirstV.mas_top).offset(8);
        make.bottom.equalTo(FirstV.mas_bottom).offset(-10);
        
    }];
    
    UIView *bottomV = [UIView new];
    
    bottomV.backgroundColor = [UIColor colorWithRGB:0xececec];
    
    [FirstV addSubview:bottomV];
    
    [bottomV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.width.equalTo(FirstV);
        make.bottom.equalTo(FirstV.mas_bottom).offset(-3);
    }];
}

//点击地区选择
-(void)DiquBtnClick
{
    PXCityViewController *VC = [[PXCityViewController alloc]init];
    
    [self.navigationController pushViewController:VC animated:YES];
}

//加载tableView数据
-(void)setupTableV
{
    
    //创建tableView
    UITableView *SearchV = [[UITableView alloc]initWithFrame:CGRectMake(0, 116, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
    [self.view addSubview:SearchV];
    
    
    //设置tableView数据源代理
    SearchV.dataSource = self;
    SearchV.delegate = self;
    _SearchV = SearchV;
    
}


#pragma mark - TableView数据源

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

//自定义Cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"PXMainCell";
    
    PXMainCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[PXMainCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}


#pragma mark - TableView代理方法

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%zd", indexPath.row);
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 96.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 96.0;
}

//headerView的高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44.0f;
}

//headerView设置headerView的属性
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    
    UIView *headerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
    
    UIImageView *backImageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"头部背景"]];
    
    [headerV addSubview:backImageV];
    
    [self.view addSubview:headerV];
    
    
    
    //backImageV约束
    [backImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(headerV);
    }];
    
    //创建三个筛选按钮
    UIButton *ShiJian = [UIButton new];
    
    [ShiJian setImage:[UIImage imageNamed:@"发布时间"] forState:UIControlStateNormal];
    
    [ShiJian addTarget:self action:@selector(FaBuClick) forControlEvents:UIControlEventTouchUpInside];
    
    [headerV addSubview:ShiJian];
    

    UIButton *ZhuangTai = [UIButton new];

    
    [ZhuangTai setImage:[UIImage imageNamed:@"奖励金额"] forState:UIControlStateNormal];
    
    [ZhuangTai addTarget:self action:@selector(JiangLiClick) forControlEvents:UIControlEventTouchUpInside];
    
    [headerV addSubview:ZhuangTai];
    

    UIButton *DaiYu = [UIButton new];

    
    [DaiYu setImage:[UIImage imageNamed:@"更多筛选"] forState:UIControlStateNormal];
    
    [DaiYu addTarget:self action:@selector(GengDuoClick) forControlEvents:UIControlEventTouchUpInside];
    
    [headerV addSubview:DaiYu];
    
    //发布时间约束
    
    int padding1 = ([UIScreen mainScreen].bounds.size.width/3);
    
    [ShiJian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(padding1);
        make.height.equalTo(headerV);
        make.top.equalTo(headerV);
        make.left.equalTo(headerV);
    }];
    
    //奖励金额约束
    [ZhuangTai mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(padding1);
        make.height.equalTo(headerV);
        make.left.equalTo(ShiJian.mas_right);
        make.top.equalTo(headerV);
    }];
    
    //更多筛选约束
    [DaiYu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(padding1);
        make.height.equalTo(headerV);
        make.right.equalTo(headerV);
        make.top.equalTo(headerV);
    }];
    
    return headerV;
    
}

//点击发布时间按钮
-(void)FaBuClick
{
    NSLog(@"点击了发布时间");
}

//点击发布时间按钮
-(void)JiangLiClick
{
    NSLog(@"点击了奖励金额");
}

//点击发布时间按钮
-(void)GengDuoClick
{
    NSLog(@"点击了更多筛选");
}


//设置TextField细节
-(void)setupTextFiel
{
    
    self.TextField.borderStyle = UITextBorderStyleNone;
    self.TextField.keyboardType = UIKeyboardTypeDefault;
    self.TextField.delegate = self;
    
    self.TextField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.TextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.TextField.returnKeyType = UIReturnKeySearch;
    
    self.TextField.background = [UIImage imageNamed:@"搜索栏背景"];
    
    
    UIImageView *Searchimage=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"查找职位"]];
    self.TextField.leftView=Searchimage;
    self.TextField.leftViewMode = UITextFieldViewModeUnlessEditing;
    
    self.TextField.userInteractionEnabled = YES;
    
    self.TextField.textColor = [UIColor whiteColor];
    
    self.TextField.clearsOnBeginEditing = YES;
    
    self.TextField.font = [UIFont fontWithName:@"Helvetica-Bold"size:16];
    
    
}

#pragma mark - TextField代理方法

//开始编辑时隐藏查找职位图片
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    self.TextField.leftViewMode = UITextFieldViewModeNever;
}


//点击键盘搜索键，收回键盘.***跳转页面****
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    textField.text = @" ";
    
    
    [self updateViewConstraints];
    
    return YES;
    
}

//结束编辑时显示查找职位图片
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.TextField.leftViewMode = UITextFieldViewModeUnlessEditing;
    
}
//点击空白收键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_TextField resignFirstResponder];
    
    _TextField.text = @" ";
}


@end
