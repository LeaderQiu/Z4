//
//  PXAddRunameViewController.m
//  ZhonglieApp
//
//  Created by 邱思雨 on 15/6/12.
//  Copyright (c) 2015年 PX. All rights reserved.
//

#import "PXAddRunameViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "UIColor+SYExtension.h"
#import "Masonry.h"


@interface PXAddRunameViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) UITextField *TextField;

@end

@implementation PXAddRunameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = NO;
    
    self.navigationItem.title = @"简历推荐";
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"返回键" highImage:@"返回键" target:self action:@selector(BackBtnClick)];
    
//    [self setupHeaderV];
    

    
    [self setupTableV];
}


//加载tableView内容
-(void)setupTableV
{
    UITableView *TableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 600) style:UITableViewStyleGrouped];
    
    TableV.backgroundColor = [UIColor colorWithRGB:0xececec];
    
    TableV.delegate = self;
    TableV.dataSource = self;
    
    [self.view addSubview:TableV];
    
}


//加载头部搜索栏
-(void)setupHeaderV
{
    UIView *HeaderV = [[UIView alloc]initWithFrame:CGRectMake(0, 64,[UIScreen mainScreen].bounds.size.width, 50)];
    
    HeaderV.backgroundColor = [UIColor whiteColor];
    
//    UITextField *TextField = [[UITextField alloc]initWithFrame:CGRectMake(10, 10, 300, 33)];
    UITextField *TextField = [UITextField new];
    
    _TextField = TextField;
    
    TextField.delegate = self;
    
    TextField.background = [UIImage imageNamed:@"searchBar"];
    
    [self setupTextFiel];
    
    
    [HeaderV addSubview:TextField];
    [self.view addSubview:HeaderV];
    
    //TextField约束
    [TextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(HeaderV).insets(UIEdgeInsetsMake(10, 10, 10, 10));
    }];
}

//TextField细节处理
-(void)setupTextFiel
{
    
    self.TextField.borderStyle = UITextBorderStyleNone;
    self.TextField.keyboardType = UIKeyboardTypeDefault;
    self.TextField.delegate = self;
    
    self.TextField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.TextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.TextField.returnKeyType = UIReturnKeySearch;
    
    self.TextField.background = [UIImage imageNamed:@"searchBar"];
    
    
    UIImageView *Searchimage=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"查找职位"]];
    self.TextField.leftView=Searchimage;
    self.TextField.leftViewMode = UITextFieldViewModeUnlessEditing;
    
    self.TextField.userInteractionEnabled = YES;
    
    self.TextField.textColor = [UIColor whiteColor];
    
    self.TextField.clearsOnBeginEditing = YES;
    
    self.TextField.font = [UIFont fontWithName:@"Helvetica-Bold"size:16];
}

//点击搜索键收回键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    textField.text = @"";
    
    return YES;
}

//开始编辑时隐藏查找职位图片
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    self.TextField.leftViewMode = UITextFieldViewModeNever;
}


//导航栏返回键点击事件
-(void)BackBtnClick
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


#pragma mark - Table代理和数据源

//每个cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellId = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellId];
    }
    
        NSInteger section = indexPath.section;
        NSInteger row = indexPath.row;
        
        switch (section) {
            case 0:
                if (row == 0) {
                    cell.textLabel.text = @"姓名：";
                }
                if (row == 1) {
                    cell.textLabel.text = @"性别：";
                }
                if (row == 2) {
                    cell.textLabel.text = @"年龄：";
                }
                if (row == 3) {
                    cell.textLabel.text = @"移动电话：";
                }
                break;
            case 1:
                if (row == 0) {
                    cell.textLabel.text = @"学校：";
                }
                if (row == 1) {
                    cell.textLabel.text = @"专业：";
                }
                if (row == 2) {
                    cell.textLabel.text = @"学历：";
                }
                break;
            case 2:
                if (row == 0) {
                    cell.textLabel.text = @"公司：";
                }
                if (row == 1) {
                    cell.textLabel.text = @"职位：";
                }
                if (row == 2) {
                    cell.textLabel.text = @"在职时间：";
                }
                if (row == 3) {
                    cell.textLabel.text = @"工作业绩及推荐内容：";
                }
                break;
            case 3:
                if (row == 0) {
                    cell.textLabel.text = @"姓名+职位+时间";
                }
                break;
                
            default:
                break;
        }

    return cell;

}

//头部标题
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"个人信息";
    }
    if (section == 1) {
        return @"教育经历";
    }
    if (section == 2) {
        return @"工作经历";
    }
    if (section == 3) {
        return @"简历名称";
    }

    return @"个人信息";
}

//组头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

//每组几个cell
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section == 0) {
        return 4;
    }
    if (section == 1) {
        return 3;
    }
    if (section == 2) {
        return 4;
    }
    if (section == 3) {
        return 1;
    }
    return 3;
}
//几个组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
//底部视图
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 3) {
        UIView *footerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 80)];
        
        UIButton *BaoCunBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 49)];
        
        [BaoCunBtn setBackgroundImage:[UIImage imageNamed:@"保存并推荐"] forState:UIControlStateNormal];
        
        [footerV addSubview:BaoCunBtn];
        return footerV;
    }
    
    return nil;
}



@end
