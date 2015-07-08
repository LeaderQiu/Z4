//
//  PXDetailViewController.m
//  ZhonglieApp
//
//  Created by 邱思雨 on 15/6/5.
//  Copyright (c) 2015年 PX. All rights reserved.
//

#import "PXDetailViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "PXMainCell.h"
#import "PXRuname2ViewController.h"
#import "Masonry.h"



@interface PXDetailViewController () <UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *DetailV;

@property(nonatomic,strong) PXDetailViewController *DetailVC;

@end

@implementation PXDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
    //设置导航栏
    self.navigationController.navigationBarHidden = NO;
    
    self.navigationItem.title = @"职位详情";
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"返回键" highImage:@"返回键" target:self action:@selector(BackClickBtn)];
}

//跳转回上一个页面
-(void)BackClickBtn
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}




#pragma mark - Table view data source


//几个section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

//每个组几个cell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    } else if (section ==1) {
        return 4;
    } else if (section ==2) {
        return 5;
    } else {
        return 6;
    }
    
}

//自定义cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //创建推荐按钮
//    UIButton *TuiJianBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 300, 49)];
    UIButton *TuiJianBtn = [UIButton new];
    
    [TuiJianBtn setBackgroundImage:[UIImage imageNamed:@"推荐Btn"] forState:UIControlStateNormal];
    
    
    [TuiJianBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *TuiJianV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 70)];

    
    [TuiJianV addSubview:TuiJianBtn];
    
    //TuiJianBtn的约束
    [TuiJianBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(TuiJianV).insets(UIEdgeInsetsMake(10, 10, 10, 10));
    }];
    
  
    
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    static NSString *CellIdentifier = @"Cell";
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
#warning TODO xib加载不成功
    if (indexPath.section == 0) {
        
        static NSString *mainID = @"PXMainCell";
        
        PXMainCell *cell = [tableView dequeueReusableCellWithIdentifier:mainID];
        
        if (indexPath.row == 0) {
            cell = [[PXMainCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mainID];
        }
        

    }
   


    if (indexPath.section == 1) {
        switch (indexPath.row) {
                case 0:
                cell.textLabel.text = @"汇报对象";
                break;
                case 1:
                cell.textLabel.text = @"所属部门";
                break;
                case 2:
                cell.textLabel.text = @"下属人数";
                break;
                case 3:
                cell.textLabel.text = @"工作内容及要求";
                break;
                
            default:
                break;
        }
    }
    if (indexPath.section == 2) {
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"学       历";
                break;
            case 1:
                cell.textLabel.text = @"性       别";
                break;
            case 2:
                cell.textLabel.text = @"专业要求";
                break;
            case 3:
                cell.textLabel.text = @"年龄阶段";
                break;
            case 4:
                cell.textLabel.text = @"工作年限";
                break;
                
            default:
                break;
        }
    }
    if (indexPath.section == 3) {
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"公司名称";
                break;
            case 1:
                cell.textLabel.text = @"公司地址";
                break;
            case 2:
                cell.textLabel.text = @"公司人数";
                break;
            case 3:
                cell.textLabel.text = @"公司介绍";
                break;
            case 4:
                cell.textLabel.text = @"";
                break;
            case 5:
                cell.textLabel.text = @"";

                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                [cell.contentView addSubview:TuiJianV];
                
               
            default:
                break;
        }
    }
//    //推荐V的约束
//    [TuiJianV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(cell.contentView).insets(UIEdgeInsetsMake(10, 10, 10, 10));
//    }];
    
    return cell;
    
    
}

//点击推荐职位按钮
-(void)btnClick
{
    NSLog(@"点击了推荐按钮");
    
    PXRuname2ViewController *Runame2VC = [[PXRuname2ViewController alloc]init];
    
    [self.navigationController pushViewController:Runame2VC animated:YES];
}


#pragma mark - TableView 代理

//每个cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 3) {
        if (indexPath.row == 5) {
            return 80;
        }
    }
    return 44;
}

//每个组组名
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return nil;
    } else if (section == 1) {
        return @"职位描述";
    } else if (section == 2) {
        return @"职位要求";
    } else {
        return @"企业介绍";
    }
    
}

//底部视图高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 0;
}


//头部视图高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    } else {
        return 44;
    }
    
}

//自定义底部视图
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{

    return nil;
}



@end
