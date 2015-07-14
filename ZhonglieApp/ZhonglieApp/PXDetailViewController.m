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
#import "AFNetworking.h"
#import "PXDetail.h"
#import "PXDescription.h"
#import "PXCompany.h"
#import "PXPosition.h"
#import "PXRequir.h"
#import "MJExtension.h"



@interface PXDetailViewController () <UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *DetailV;

@property(nonatomic,strong) PXDetailViewController *DetailVC;

@property(nonatomic,strong) NSMutableArray *dataArray;



//脑残属性们
//汇报对象
@property(nonatomic,copy)NSString *HuiBao;
//所属部门
@property(nonatomic,copy)NSString *SuoShu;
//下属人数
@property(nonatomic,copy)NSString *XiaShu;
//工作内容
@property(nonatomic,copy)NSString *GongZuo;

//学历
@property(nonatomic,copy)NSString *XueLi;
//性别
@property(nonatomic,copy) NSString* XingBie;
//专业
@property(nonatomic,copy)NSString *ZhuanYe;
//年龄要求
@property(nonatomic,copy)NSString *NianLing;
//工作年限
@property(nonatomic,copy)NSString *NianXian;

//公司名称
@property(nonatomic,copy)NSString *MingCheng;
//公司地址
@property(nonatomic,copy)NSString *DiZhi;
//公司简介
@property(nonatomic,copy)NSString *JianJie;


@end

@implementation PXDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    [self setupHTTPData:_pid];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
    //设置导航栏
    self.navigationController.navigationBarHidden = NO;
    
    self.navigationItem.title = @"职位详情";
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"返回键" highImage:@"返回键" target:self action:@selector(BackClickBtn)];
    
    
}

/**
 *  懒加载
 */
-(NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

//跳转回上一个页面
-(void)BackClickBtn
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

//网络请求数据
-(void)setupHTTPData:(NSString * )pid
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *pamas = @{@"pid":pid};
    
    [mgr POST:UrlStrPositionContent parameters:pamas success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
        NSLog(@"职位详情成功==》%@",responseObject);
        
//        
//        NSArray *dictArray = [responseObject objectForKey:@"data"];
//
//        NSLog(@"+++%@",dictArray);
        
        self.HuiBao = [[[responseObject objectForKey:@"data"] objectForKey:@"description"] objectForKey:@"ups"];
        
        self.SuoShu = [[[responseObject objectForKey:@"data"] objectForKey:@"description"] objectForKey:@"section"];
        
        self.XiaShu = [[[responseObject objectForKey:@"data"] objectForKey:@"description"] objectForKey:@"person_total"];
        
        self.GongZuo = [[[responseObject objectForKey:@"data"] objectForKey:@"description"] objectForKey:@"content"];
        
         self.XueLi = [[[responseObject objectForKey:@"data"] objectForKey:@"requir"] objectForKey:@"edu"];
        
        self.XingBie = [[[responseObject objectForKey:@"data"] objectForKey:@"requir"] objectForKey:@"sex"];
        
        self.ZhuanYe = [[[responseObject objectForKey:@"data"] objectForKey:@"requir"] objectForKey:@"professional"];
        
        self.NianLing = [[[responseObject objectForKey:@"data"] objectForKey:@"requir"] objectForKey:@"age"];
        
        self.NianXian = [[[responseObject objectForKey:@"data"] objectForKey:@"requir"] objectForKey:@"work_time"];
        
        self.MingCheng = [[[responseObject objectForKey:@"data"] objectForKey:@"company"] objectForKey:@"name"];
        
        self.DiZhi = [[[responseObject objectForKey:@"data"] objectForKey:@"company"] objectForKey:@"address"];
        
        self.JianJie = [[[responseObject objectForKey:@"data"] objectForKey:@"company"] objectForKey:@"introduction"];
        
        [self.tableView reloadData];
        
        

        
        NSLog(@"职位详情dataArray==>%@",self.dataArray);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        NSLog(@"职位详情失败==》%@",error);
    }];
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
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
   

    
    
#warning TODO xib加载不成功
    if (indexPath.section == 0) {
        
        static NSString *mainID = @"PXMainCell";
        
        PXMainCell *cell = [tableView dequeueReusableCellWithIdentifier:mainID];
        
        if (indexPath.row == 0) {
            cell = [[PXMainCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mainID];
        }
        
        return cell;
    }
   


    if (indexPath.section == 1) {
        switch (indexPath.row) {
                case 0:
                cell.textLabel.text = @"汇报对象";
                cell.detailTextLabel.text = self.HuiBao;
                break;
                case 1:
                cell.textLabel.text = @"所属部门";
                cell.detailTextLabel.text = self.SuoShu;
                break;
                case 2:
                cell.textLabel.text = @"下属人数";
                cell.detailTextLabel.text = self.XiaShu;
                break;
                case 3:
                cell.textLabel.text = @"工作内容及要求";
#warning TODO 后台传<null>无法解决
//                if ([self.GongZuo isEqualToString:@"null"]) {
////                    cell.detailTextLabel.text = self.GongZuo;
//                    NSLog(@"***");
//                }
//                
                break;
                
            default:
                break;
        }
    }
    if (indexPath.section == 2) {
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"学       历";
                cell.detailTextLabel.text = self.XueLi;
                break;
            case 1:
                cell.textLabel.text = @"性       别";
                if ([self.XingBie isEqualToString:@"1"]) {
                    cell.detailTextLabel.text = @"男";
                }else if([self.XingBie isEqualToString:@"0"]){
                    cell.detailTextLabel.text = @"女";
                }else{
                    cell.detailTextLabel.text = @"男女不限";
                }
                break;
            case 2:
                cell.textLabel.text = @"专业要求";
                cell.detailTextLabel.text = self.ZhuanYe;
                break;
            case 3:
                cell.textLabel.text = @"年龄阶段";
                if ([self.NianLing isEqualToString:@"1"]) {
                    cell.detailTextLabel.text = @"20-30岁";
                }else if([self.NianLing isEqualToString:@"2"]){
                    cell.detailTextLabel.text = @"30-35";
                }else if([self.NianLing isEqualToString:@"3"]){
                    cell.detailTextLabel.text = @"35-40";
                }else{
                    cell.detailTextLabel.text = @"45及以上";
                }
                break;
            case 4:
                cell.textLabel.text = @"工作年限";
                if ([self.NianXian isEqualToString:@"1"]) {
                    cell.detailTextLabel.text = @"1年以上";
                }else if([self.NianXian isEqualToString:@"2"]){
                    cell.detailTextLabel.text = @"2-3年";
                }else if([self.NianXian isEqualToString:@"3"]){
                    cell.detailTextLabel.text = @"3-5年";
                }else{
                    cell.detailTextLabel.text = @"5年以上";
                }

                break;
                
            default:
                break;
        }
    }
    if (indexPath.section == 3) {
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"公司名称";
                cell.detailTextLabel.text = self.MingCheng;
                break;
            case 1:
                cell.textLabel.text = @"公司地址";
                cell.detailTextLabel.text = self.DiZhi;
                break;
            case 2:
                cell.textLabel.text = @"公司人数";
                break;
            case 3:
                cell.textLabel.text = @"公司介绍";
                cell.detailTextLabel.text = self.JianJie;
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
    if(indexPath.section == 0){
        return 90;
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
