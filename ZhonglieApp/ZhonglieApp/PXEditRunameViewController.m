//
//  PXEditRunameViewController.m
//  ZhonglieApp
//
//  Created by 邱思雨 on 15/6/12.
//  Copyright (c) 2015年 PX. All rights reserved.
//

#import "PXEditRunameViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "UIColor+SYExtension.h"
#import "Masonry.h"

@interface PXEditRunameViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation PXEditRunameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = NO;
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"返回键" highImage:@"返回键" target:self action:@selector(BackBtnClick)];
    
    self.navigationItem.title = @"修改简历";
    
    
    [self setupScrollV];
    
    [self setupTableV];
}

//导航栏返回键
-(void)BackBtnClick
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

//加载tableView内容
-(void)setupTableV
{
    UITableView *TableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 620) style:UITableViewStyleGrouped];
    
    TableV.backgroundColor = [UIColor colorWithRGB:0xececec];
    
    TableV.delegate = self;
    TableV.dataSource = self;
    
    [self.view addSubview:TableV];
    
}
//加载ScrollView内容
-(void)setupScrollV
{
    
}


#pragma mark - Table代理和数据源

//每个cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellId = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellId];
        
        int section = indexPath.section;
        int row = indexPath.row;
        
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
            case 3:
                if (row == 0) {
                    cell.textLabel.text = @"姓名+职位+时间";
                }
                
            default:
                break;
        }
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
        UIView *footerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 49)];
        
        UIButton *BaoCunBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 49)];
        
        [BaoCunBtn setBackgroundImage:[UIImage imageNamed:@"保存并推荐"] forState:UIControlStateNormal];
        
        [footerV addSubview:BaoCunBtn];
        
        return footerV;
    }
    
    return nil;
}



@end
