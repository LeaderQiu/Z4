//
//  PXRuname2ViewController.m
//  ZhonglieApp
//
//  Created by 邱思雨 on 15/6/8.
//  Copyright (c) 2015年 PX. All rights reserved.
//

#import "PXRuname2ViewController.h"
#import "PXRuname2Cell.h"
#import "UIBarButtonItem+Extension.h"
#import "PXDetailViewController.h"
#import "PXSuccessViewController.h"
#import "Masonry.h"
#import "PXWanShanViewController.h"



@interface PXRuname2ViewController ()<UITextFieldDelegate,UITableViewDataSource,UITabBarDelegate>

@property(nonatomic,strong) UITextField *TextField;


@end

@implementation PXRuname2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image: [UIImage imageNamed:@"runame"]selectedImage:[UIImage imageNamed:@"runame-hover"]];
    
    self.navigationController.navigationBarHidden = NO;
    
    self.navigationItem.title = @"简历推荐";
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"返回键" highImage:@"返回键" target:self action:@selector(BackClickBtn)];
    
    
    [self setupFirstV];
    
    [self setupTableV];
    
    
}

//点击返回键
-(void)BackClickBtn
{
//     PXDetailViewController *DetailVC = [[PXDetailViewController alloc]initWithStyle:UITableViewStyleGrouped];
//    
//        [self.navigationController popToViewController:DetailVC animated:YES];

    [self.navigationController popToRootViewControllerAnimated:YES];

}

//点击键盘搜索键，收回键盘.***跳转页面****
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    textField.text = @" ";
    
    return YES;
    
}


-(void)setupFirstV
{
    UIView *FirstV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 49)];
    
    [FirstV setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"搜索栏Cell背景"]]];
    
    //添加TextFiel
    UITextField *TextField = [UITextField new];
    
    _TextField = TextField;
    
    [self setupTextFiel];
    [FirstV addSubview:TextField];
    
    [self.view addSubview:FirstV];
    
    //TextField约束
    [TextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(FirstV).insets(UIEdgeInsetsMake(7, 10, 7, 10));
    }];
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
    
    self.TextField.background = [UIImage imageNamed:@"搜索栏"];
    
    
    UIImageView *Searchimage=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"查找简历"]];
    self.TextField.leftView=Searchimage;
    self.TextField.leftViewMode = UITextFieldViewModeUnlessEditing;
    
    self.TextField.userInteractionEnabled = YES;
    
    self.TextField.textColor = [UIColor blackColor];
    
    self.TextField.clearsOnBeginEditing = YES;
    
    self.TextField.font = [UIFont fontWithName:@"Helvetica-Bold"size:16];
}

//开始编辑时隐藏查找职位图片
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    self.TextField.leftViewMode = UITextFieldViewModeNever;
    
    //    [self setupSearchHistory];
    
}

//设置TableView
-(void)setupTableV
{
    
    self.tableView.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height) ;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.rowHeight = 49;
}


#pragma mark - Table view data source

//几个cell

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 8;
}

//设置cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *RunameID = @"Runame2Cell";
    
    PXRuname2Cell *cell = [tableView dequeueReusableCellWithIdentifier:RunameID];
    
    if (cell == nil) {
        cell = [[PXRuname2Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RunameID target:self action:@selector(TuiJianSuccess)];
    }
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
}

//点击推荐跳转到成功界面
-(void)TuiJianSuccess
{
//    PXSuccessViewController *SuccessVC = [[PXSuccessViewController alloc]init];
    PXWanShanViewController *VC = [[PXWanShanViewController alloc]init];
    
    [self.navigationController pushViewController:VC animated:YES];
}

@end
