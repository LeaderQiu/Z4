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
#import "AFNetworking.h"
#import "MJExtension.h"
#import "PXZhiWei.h"
#import "PXMainViewController.h"
#import "MBProgressHUD.h"
#import "UIColor+SYExtension.h"



@interface PXSearchViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property(nonatomic,strong) UITableView *SearchV;
@property(nonatomic,strong) UITextField *TextField;
//搜索栏用户输入的文字
@property(nonatomic,copy) NSString *UserText;

//用户选择的性别
@property(nonatomic,copy) NSString *UserSex;

//用户选择的薪资
@property(nonatomic,copy) NSString *UserMany;

//更多筛选的性别
@property(nonatomic,copy) NSString* SexNumber;

@property(nonatomic,strong) UIView *AlertV1;
@property(nonatomic,strong) UIView *AlertV2;
@property(nonatomic,strong) UIView *AlertV3;

@property int i1;
@property int i2;
@property int i3;
@property int i4;
@property int i5;
@property int i6;
@property int i7;

@property(nonatomic,strong) UIButton *Btn7;
@property(nonatomic,strong) UIButton *Btn8;
@property(nonatomic,strong) UIButton *Btn9;
@property(nonatomic,strong) UIButton *Btn10;
@property(nonatomic,strong) UIButton *Btn11;
@property(nonatomic,strong) UIButton *Btn12;
@property(nonatomic,strong) UIButton *Btn13;


/**存放的职位列表模型数组*/
@property(nonatomic,strong) NSMutableArray *dataArray;
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
    
    //进行文字搜索
    [self setupTextSearchWithText:_SearchText];
    
    
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

//文字搜索
-(void)setupTextSearchWithText:(NSString *)text
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *pamas = @{@"keywords":text,@"page":@"0"};
    
    NSLog(@"文字搜索的内容%@",text);
    
    [mgr POST:UrlStrPositionSearch parameters:pamas success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
        NSLog(@"文字搜索成功==》%@",responseObject);
        NSArray *dictarray = [responseObject objectForKey:@"data"];

        int code = [[responseObject objectForKey:@"code"] intValue];
        
        if (code != 1000) {
            
            MBProgressHUD *hud =   [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            
            // Configure for text only and offset down
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"对不起，目前没有此职位";
            hud.margin = 10.f;
            hud.removeFromSuperViewOnHide = YES;
            
            [hud hide:YES afterDelay:1];
            
            NSLog(@"搜索有误");
            
        }else{
            NSMutableArray *tempArray = [NSMutableArray array];
            
            for (NSDictionary *dict in dictarray) {
                PXZhiWei *zhiwei = [PXZhiWei objectWithKeyValues:dict];
                
                [tempArray addObject:zhiwei];
                
            }
            [self.dataArray addObjectsFromArray:tempArray];
            [self.SearchV reloadData];
            
        }
        
        
    
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        NSLog(@"文字搜索失败==》%@",error);
    }];
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
    
    return self.dataArray.count;
}

//自定义Cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"PXMainCell";
    
    PXMainCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    PXZhiWei *zhiWei = self.dataArray[indexPath.row];
    
    if (cell == nil) {
        cell = [[PXMainCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.zhiWei = zhiWei;
    
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
    self.AlertV2.hidden = YES;
    self.AlertV3.hidden = YES;
    NSLog(@"点击了发布时间");
    
    UIView *Alert1 = [UIView new];
    
    _AlertV1 = Alert1;

    UIImageView *backImage1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"弹出框左"]];
    
    UIButton *Btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *Btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *Btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    

    [Btn1 setTitle:@"最近一周" forState:UIControlStateNormal];
    [Btn2 setTitle:@"近一个月" forState:UIControlStateNormal];
    [Btn3 setTitle:@"全部" forState:UIControlStateNormal];

    
    [Btn1 setTitleColor:[UIColor colorWithRGB:0x4f4f4f] forState:UIControlStateNormal];
    [Btn2 setTitleColor:[UIColor colorWithRGB:0x4f4f4f] forState:UIControlStateNormal];
    [Btn3 setTitleColor:[UIColor colorWithRGB:0x4f4f4f] forState:UIControlStateNormal];
    
    Btn1.titleLabel.font = [UIFont systemFontOfSize:18];
    Btn2.titleLabel.font = [UIFont systemFontOfSize:18];
    Btn3.titleLabel.font = [UIFont systemFontOfSize:18];
    
   
    
    [Alert1 addSubview:backImage1];
    
    [Alert1 addSubview:Btn1];
    [Alert1 addSubview:Btn2];
    [Alert1 addSubview:Btn3];
    
    [Btn1 addTarget:self action:@selector(Btn1Click) forControlEvents:UIControlEventTouchUpInside];
    
    [Btn2 addTarget:self action:@selector(Btn2Click) forControlEvents:UIControlEventTouchUpInside];
    
    [Btn3 addTarget:self action:@selector(Btn3Click) forControlEvents:UIControlEventTouchUpInside];
    
    [self.SearchV addSubview:Alert1];
    
    //给backImage1设置约束
    [backImage1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(Alert1);
    }];
    
    //给Alert1设置约束
    [Alert1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.top.equalTo(self.SearchV.mas_top).offset(46);
        make.height.mas_equalTo(51);
    }];
    
    //给Btn设置约束
    int padding1 = (self.view.bounds.size.width-240)/4;
    
    NSLog(@"padding==>%d",padding1);
    
    [Btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(80);
        make.left.equalTo(Alert1.mas_left).offset(padding1);
        make.centerY.equalTo(Alert1.mas_centerY).offset(5);
    }];
    
    [Btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(80);
        make.left.equalTo(Btn1.mas_right).offset(padding1);
        make.centerY.equalTo(Alert1.mas_centerY).offset(5);
    }];
    
    [Btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(80);
        make.left.equalTo(Btn2.mas_right).offset(padding1);
        make.centerY.equalTo(Alert1.mas_centerY).offset(5);
    }];
}

//Btn1点击事件
-(void)Btn1Click
{
    self.AlertV3.hidden = YES;
    self.AlertV2.hidden = YES;
    self.AlertV1.hidden = YES;
    NSLog(@"Btn1");
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    if (self.UserText == nil) {
        
        MBProgressHUD *hud =   [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        
        // Configure for text only and offset down
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"对不起，目前没有此职位";
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        
        [hud hide:YES afterDelay:1];
    }else{
        NSDictionary *pamas = @{@"keywords":self.UserText,
                                @"page":@"0",
                                @"time":@"1"};
        
        [mgr POST:UrlStrPositionSearch parameters:pamas success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //
            NSLog(@"Btn1点击事件==》%@",responseObject);
            
            NSArray *dictarray = [responseObject objectForKey:@"data"];
            
            int code = [[responseObject objectForKey:@"code"] intValue];
            
            if (code != 1000) {
                
                MBProgressHUD *hud =   [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
                
                // Configure for text only and offset down
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"对不起，目前没有此职位";
                hud.margin = 10.f;
                hud.removeFromSuperViewOnHide = YES;
                
                [hud hide:YES afterDelay:1];
                
                NSLog(@"搜索有误");
                
            }else{
                NSMutableArray *tempArray = [NSMutableArray array];
                
                for (NSDictionary *dict in dictarray) {
                    PXZhiWei *zhiwei = [PXZhiWei objectWithKeyValues:dict];
                    
                    [tempArray addObject:zhiwei];
                    
                }
                [self.dataArray removeAllObjects];
                [self.dataArray addObjectsFromArray:tempArray];
                [self.SearchV reloadData];
                
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //
            NSLog(@"Btn1点击事件失败==》%@",error);
        }];

    }
    
    }

//Btn2点击事件
-(void)Btn2Click
{
    self.AlertV3.hidden = YES;
    self.AlertV2.hidden = YES;
    self.AlertV1.hidden = YES;
    NSLog(@"Btn2");
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    if (self.UserText == nil) {
        
        MBProgressHUD *hud =   [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        
        // Configure for text only and offset down
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"对不起，目前没有此职位";
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        
        [hud hide:YES afterDelay:1];
    }else{
        
        NSDictionary *pamas = @{@"keywords":self.UserText,
                                @"page":@"0",
                                @"time":@"2"};
        
        [mgr POST:UrlStrPositionSearch parameters:pamas success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //
            NSLog(@"Btn2点击事件==》%@",responseObject);
            
            NSArray *dictarray = [responseObject objectForKey:@"data"];
            
            int code = [[responseObject objectForKey:@"code"] intValue];
            
            if (code != 1000) {
                
                MBProgressHUD *hud =   [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
                
                // Configure for text only and offset down
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"对不起，目前没有此职位";
                hud.margin = 10.f;
                hud.removeFromSuperViewOnHide = YES;
                
                [hud hide:YES afterDelay:1];
                
                NSLog(@"搜索有误");
                
            }else{
                NSMutableArray *tempArray = [NSMutableArray array];
                
                for (NSDictionary *dict in dictarray) {
                    PXZhiWei *zhiwei = [PXZhiWei objectWithKeyValues:dict];
                    
                    [tempArray addObject:zhiwei];
                    
                }
                [self.dataArray removeAllObjects];
                [self.dataArray addObjectsFromArray:tempArray];
                [self.SearchV reloadData];
                
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //
            NSLog(@"Btn2点击事件失败==》%@",error);
        }];

    }
    
}

//Btn3点击事件
-(void)Btn3Click
{
    self.AlertV3.hidden = YES;
    self.AlertV2.hidden = YES;
    self.AlertV1.hidden = YES;
    NSLog(@"Btn3");
    
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    if (self.UserText == nil) {
        
        MBProgressHUD *hud =   [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        
        // Configure for text only and offset down
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"对不起，目前没有此职位";
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        
        [hud hide:YES afterDelay:1];
    }else{
        
        NSDictionary *pamas = @{@"keywords":self.UserText,
                                @"page":@"0",
                                @"time":@"3"};
        
        [mgr POST:UrlStrPositionSearch parameters:pamas success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //
            NSLog(@"Btn3点击事件==》%@",responseObject);
            
            NSArray *dictarray = [responseObject objectForKey:@"data"];
            
            int code = [[responseObject objectForKey:@"code"] intValue];
            
            if (code != 1000) {
                
                MBProgressHUD *hud =   [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
                
                // Configure for text only and offset down
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"对不起，目前没有此职位";
                hud.margin = 10.f;
                hud.removeFromSuperViewOnHide = YES;
                
                [hud hide:YES afterDelay:1];
                
                NSLog(@"搜索有误");
                
            }else{
                NSMutableArray *tempArray = [NSMutableArray array];
                
                for (NSDictionary *dict in dictarray) {
                    PXZhiWei *zhiwei = [PXZhiWei objectWithKeyValues:dict];
                    
                    [tempArray addObject:zhiwei];
                    
                }
                [self.dataArray removeAllObjects];
                [self.dataArray addObjectsFromArray:tempArray];
                [self.SearchV reloadData];
                
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //
            NSLog(@"Btn3点击事件失败==》%@",error);
        }];
        
    }
    

}

//点击奖励金额按钮
-(void)JiangLiClick
{
    self.AlertV1.hidden = YES;
    self.AlertV3.hidden = YES;
    NSLog(@"点击了发布时间");
    
    UIView *Alert2 = [UIView new];
    
    _AlertV2 = Alert2;
    
    UIImageView *backImage2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"弹出框中"]];
    
    UIButton *Btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *Btn5 = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *Btn6 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    [Btn4 setTitle:@"由高到低" forState:UIControlStateNormal];
    [Btn5 setTitle:@"由低到高" forState:UIControlStateNormal];
    [Btn6 setTitle:@"全部" forState:UIControlStateNormal];
    
    
    [Btn4 setTitleColor:[UIColor colorWithRGB:0x4f4f4f] forState:UIControlStateNormal];
    [Btn5 setTitleColor:[UIColor colorWithRGB:0x4f4f4f] forState:UIControlStateNormal];
    [Btn6 setTitleColor:[UIColor colorWithRGB:0x4f4f4f] forState:UIControlStateNormal];
    
    Btn4.titleLabel.font = [UIFont systemFontOfSize:18];
    Btn5.titleLabel.font = [UIFont systemFontOfSize:18];
    Btn6.titleLabel.font = [UIFont systemFontOfSize:18];
    
    
    
    [Alert2 addSubview:backImage2];
    
    [Alert2 addSubview:Btn4];
    [Alert2 addSubview:Btn5];
    [Alert2 addSubview:Btn6];
    
    [Btn4 addTarget:self action:@selector(Btn4Click) forControlEvents:UIControlEventTouchUpInside];
    
    [Btn5 addTarget:self action:@selector(Btn5Click) forControlEvents:UIControlEventTouchUpInside];
    
    [Btn6 addTarget:self action:@selector(Btn6Click) forControlEvents:UIControlEventTouchUpInside];
    
    [self.SearchV addSubview:Alert2];
    
    //给backImage1设置约束
    [backImage2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(Alert2);
    }];
    
    //给Alert1设置约束
    [Alert2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.top.equalTo(self.SearchV.mas_top).offset(46);
        make.height.mas_equalTo(51);
    }];
    
    //给Btn设置约束
    int padding1 = (self.view.bounds.size.width-240)/4;
    
    NSLog(@"padding==>%d",padding1);
    
    [Btn4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(80);
        make.left.equalTo(Alert2.mas_left).offset(padding1);
        make.centerY.equalTo(Alert2.mas_centerY).offset(5);
    }];
    
    [Btn5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(80);
        make.left.equalTo(Btn4.mas_right).offset(padding1);
        make.centerY.equalTo(Alert2.mas_centerY).offset(5);
    }];
    
    [Btn6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(80);
        make.left.equalTo(Btn5.mas_right).offset(padding1);
        make.centerY.equalTo(Alert2.mas_centerY).offset(5);
    }];}

//Btn4点击事件
-(void)Btn4Click
{
    self.AlertV3.hidden = YES;
    self.AlertV2.hidden = YES;
    self.AlertV1.hidden = YES;
    NSLog(@"Btn4");
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    if (self.UserText == nil) {
        
        MBProgressHUD *hud =   [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        
        // Configure for text only and offset down
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"对不起，目前没有此职位";
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        
        [hud hide:YES afterDelay:1];
    }else{
        
        NSDictionary *pamas = @{@"keywords":self.UserText,
                                @"page":@"0",
                                @"reward":@"1"};
        
        [mgr POST:UrlStrPositionSearch parameters:pamas success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //
            NSLog(@"Btn4点击事件==》%@",responseObject);
            
            NSArray *dictarray = [responseObject objectForKey:@"data"];
            
            int code = [[responseObject objectForKey:@"code"] intValue];
            
            if (code != 1000) {
                
                MBProgressHUD *hud =   [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
                
                // Configure for text only and offset down
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"对不起，目前没有此职位";
                hud.margin = 10.f;
                hud.removeFromSuperViewOnHide = YES;
                
                [hud hide:YES afterDelay:1];
                
                NSLog(@"搜索有误");
                
            }else{
                NSMutableArray *tempArray = [NSMutableArray array];
                
                for (NSDictionary *dict in dictarray) {
                    PXZhiWei *zhiwei = [PXZhiWei objectWithKeyValues:dict];
                    
                    [tempArray addObject:zhiwei];
                    
                }
                [self.dataArray removeAllObjects];
                [self.dataArray addObjectsFromArray:tempArray];
                [self.SearchV reloadData];
                
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //
            NSLog(@"Btn4点击事件失败==》%@",error);
        }];
        
    }
    

}
//Btn5点击事件
-(void)Btn5Click
{
    self.AlertV3.hidden = YES;
    self.AlertV2.hidden = YES;
    self.AlertV1.hidden = YES;
    NSLog(@"Btn5");
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    if (self.UserText == nil) {
        
        MBProgressHUD *hud =   [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        
        // Configure for text only and offset down
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"对不起，目前没有此职位";
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        
        [hud hide:YES afterDelay:1];
    }else{
        
        NSDictionary *pamas = @{@"keywords":self.UserText,
                                @"page":@"0",
                                @"reward":@"2"};
        
        [mgr POST:UrlStrPositionSearch parameters:pamas success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //
            NSLog(@"Btn5点击事件==》%@",responseObject);
            
            NSArray *dictarray = [responseObject objectForKey:@"data"];
            
            int code = [[responseObject objectForKey:@"code"] intValue];
            
            if (code != 1000) {
                
                MBProgressHUD *hud =   [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
                
                // Configure for text only and offset down
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"对不起，目前没有此职位";
                hud.margin = 10.f;
                hud.removeFromSuperViewOnHide = YES;
                
                [hud hide:YES afterDelay:1];
                
                NSLog(@"搜索有误");
                
            }else{
                NSMutableArray *tempArray = [NSMutableArray array];
                
                for (NSDictionary *dict in dictarray) {
                    PXZhiWei *zhiwei = [PXZhiWei objectWithKeyValues:dict];
                    
                    [tempArray addObject:zhiwei];
                    
                }
                [self.dataArray removeAllObjects];
                [self.dataArray addObjectsFromArray:tempArray];
                [self.SearchV reloadData];
                
                
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //
            NSLog(@"Btn5点击事件失败==》%@",error);
        }];
        
    }
    

}
//Btn6点击事件
-(void)Btn6Click
{
    self.AlertV3.hidden = YES;
    self.AlertV2.hidden = YES;
    self.AlertV1.hidden = YES;
    NSLog(@"Btn6");
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    if (self.UserText == nil) {
        
        MBProgressHUD *hud =   [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        
        // Configure for text only and offset down
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"对不起，目前没有此职位";
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        
        [hud hide:YES afterDelay:1];
    }else{
        
        NSDictionary *pamas = @{@"keywords":self.UserText,
                                @"page":@"0",
                                @"reward":@"3"};
        
        [mgr POST:UrlStrPositionSearch parameters:pamas success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //
            NSLog(@"Btn6点击事件==》%@",responseObject);
            
            NSArray *dictarray = [responseObject objectForKey:@"data"];
            
            int code = [[responseObject objectForKey:@"code"] intValue];
            
            if (code != 1000) {
                
                MBProgressHUD *hud =   [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
                
                // Configure for text only and offset down
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"对不起，目前没有此职位";
                hud.margin = 10.f;
                hud.removeFromSuperViewOnHide = YES;
                
                [hud hide:YES afterDelay:1];
                
                NSLog(@"搜索有误");
                
            }else{
                NSMutableArray *tempArray = [NSMutableArray array];
                
                for (NSDictionary *dict in dictarray) {
                    PXZhiWei *zhiwei = [PXZhiWei objectWithKeyValues:dict];
                    
                    [tempArray addObject:zhiwei];
                    
                }
                [self.dataArray removeAllObjects];
                [self.dataArray addObjectsFromArray:tempArray];
                [self.SearchV reloadData];
                
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //
            NSLog(@"Btn6点击事件失败==》%@",error);
        }];
        
    }
    

}



//点击更多筛选按钮
-(void)GengDuoClick
{
    self.AlertV2.hidden = YES;
    self.AlertV1.hidden = YES;
    NSLog(@"点击了更多筛选");
    
    UIView *Alert3 = [UIView new];
    
    _AlertV3 = Alert3;
    
    UIImageView *backImage3 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"弹出框右"]];
    
    //创建性别Label
    UILabel *SexLabel = [UILabel new];
    SexLabel.text = @"性别";
    SexLabel.textColor = [UIColor colorWithRGB:0x4f4f4f];
    SexLabel.font = [UIFont systemFontOfSize:18];
    
    //创建推荐奖励Label
    UILabel *TJLabel = [UILabel new];
    TJLabel.text = @"推荐奖励";
    TJLabel.textColor = [UIColor colorWithRGB:0x4f4f4f];
    TJLabel.font = [UIFont systemFontOfSize:18];
    
    //创建分割线
    UIView *backV = [UIView new];
    backV.backgroundColor = [UIColor colorWithRGB:0xcfcfcf];
    
    UIButton *Btn7 = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *Btn8 = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *Btn9 = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *Btn10 = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *Btn11 = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *Btn12 = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *Btn13 = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *Btn14 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _Btn7 = Btn7;
    _Btn8 = Btn8;
    _Btn9 = Btn9;
    _Btn10 = Btn10;
    _Btn11 = Btn11;
    _Btn12 = Btn12;
    _Btn13 = Btn13;
    
    
    [Btn7 setTitle:@"男" forState:UIControlStateNormal];
    [Btn8 setTitle:@"女" forState:UIControlStateNormal];
    [Btn9 setTitle:@"1000-3000" forState:UIControlStateNormal];
    [Btn10 setTitle:@"3000-8000" forState:UIControlStateNormal];
    [Btn11 setTitle:@"8000-15000" forState:UIControlStateNormal];
    [Btn12 setTitle:@"15000-30000" forState:UIControlStateNormal];
    [Btn13 setTitle:@"30000以上" forState:UIControlStateNormal];
    [Btn14 setTitle:@"确认" forState:UIControlStateNormal];
    
    Btn7.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    Btn8.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    Btn9.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    Btn10.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    Btn11.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    Btn12.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    Btn13.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
 
    
    [Btn14 setBackgroundImage:[UIImage imageNamed:@"弹出框右按钮"] forState:UIControlStateNormal];
    
    
    [Btn7 setTitleColor:[UIColor colorWithRGB:0x4f4f4f] forState:UIControlStateNormal];
    [Btn8 setTitleColor:[UIColor colorWithRGB:0x4f4f4f] forState:UIControlStateNormal];
    [Btn9 setTitleColor:[UIColor colorWithRGB:0x4f4f4f] forState:UIControlStateNormal];
    [Btn10 setTitleColor:[UIColor colorWithRGB:0x4f4f4f] forState:UIControlStateNormal];
    [Btn11 setTitleColor:[UIColor colorWithRGB:0x4f4f4f] forState:UIControlStateNormal];
    [Btn12 setTitleColor:[UIColor colorWithRGB:0x4f4f4f] forState:UIControlStateNormal];
    [Btn13 setTitleColor:[UIColor colorWithRGB:0x4f4f4f] forState:UIControlStateNormal];

    
    Btn7.titleLabel.font = [UIFont systemFontOfSize:18];
    Btn8.titleLabel.font = [UIFont systemFontOfSize:18];
    Btn9.titleLabel.font = [UIFont systemFontOfSize:18];
    Btn10.titleLabel.font = [UIFont systemFontOfSize:18];
    Btn11.titleLabel.font = [UIFont systemFontOfSize:18];
    Btn12.titleLabel.font = [UIFont systemFontOfSize:18];
    Btn13.titleLabel.font = [UIFont systemFontOfSize:18];
    Btn14.titleLabel.font = [UIFont systemFontOfSize:18];
    
    
    
    [Alert3 addSubview:backImage3];
    
    [Alert3 addSubview:Btn7];
    [Alert3 addSubview:Btn8];
    [Alert3 addSubview:Btn9];
    [Alert3 addSubview:Btn10];
    [Alert3 addSubview:Btn11];
    [Alert3 addSubview:Btn12];
    [Alert3 addSubview:Btn13];
    [Alert3 addSubview:Btn14];
    [Alert3 addSubview:SexLabel];
    [Alert3 addSubview:TJLabel];
    [Alert3 addSubview:backV];
    
    [Btn7 addTarget:self action:@selector(Btn7Click) forControlEvents:UIControlEventTouchUpInside];
    
    [Btn8 addTarget:self action:@selector(Btn8Click) forControlEvents:UIControlEventTouchUpInside];
    
    [Btn9 addTarget:self action:@selector(Btn9Click) forControlEvents:UIControlEventTouchUpInside];
    
    
    [Btn10 addTarget:self action:@selector(Btn10Click) forControlEvents:UIControlEventTouchUpInside];
    
    
    [Btn11 addTarget:self action:@selector(Btn11Click) forControlEvents:UIControlEventTouchUpInside];
    
    
    [Btn12 addTarget:self action:@selector(Btn12Click) forControlEvents:UIControlEventTouchUpInside];
    
    
    [Btn13 addTarget:self action:@selector(Btn13Click) forControlEvents:UIControlEventTouchUpInside];
    
    
    [Btn14 addTarget:self action:@selector(Btn14Click) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.SearchV addSubview:Alert3];
    
    //给backImage3设置约束
    [backImage3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(Alert3);
    }];
    
    //给Alert3设置约束
    [Alert3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.top.equalTo(self.SearchV.mas_top).offset(46);
        make.height.mas_equalTo(223);
    }];
    
    //设置约束
    int padding1 = (self.view.bounds.size.width-240)/4;
    int padding2 = (self.view.bounds.size.width-200)/3-10;
    
    NSLog(@"padding1==>%d",padding1);
    NSLog(@"padding2==>%d",padding2);
    
    //性别
    [SexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(padding1);
        make.width.mas_equalTo(80);
        make.top.equalTo(Alert3.mas_top).offset(20);
    }];
    
    //男
    [Btn7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(80);
        make.left.equalTo(SexLabel.mas_right).offset(padding1);
        make.centerY.equalTo(SexLabel);
    }];
    
    //女
    [Btn8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(80);
        make.left.equalTo(Btn7.mas_right).offset(padding1);
        make.centerY.equalTo(SexLabel);
    }];
    
    //确定
    [Btn14 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(38);
        make.width.equalTo(Alert3);
        make.bottom.equalTo(Alert3);
        make.centerX.equalTo(Alert3);
    }];
    
    //分割线
    [backV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.left.equalTo(Alert3.mas_left).offset(20);
        make.right.equalTo(Alert3.mas_right).offset(-20);
        make.top.equalTo(SexLabel.mas_bottom).offset(10);
    }];
    
    //推荐奖励
    [TJLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(80);
        make.top.equalTo(backV).offset(10);
        make.left.equalTo(SexLabel.mas_left);
    }];
    
    //1000-3000
    [Btn9 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.left.equalTo(Alert3.mas_left).offset(padding2);
        make.top.equalTo(TJLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(20);
    }];
    
    //3000-8000
    [Btn10 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(120);
        make.right.equalTo(Alert3.mas_right).offset(-padding2);
        make.top.equalTo(TJLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(20);
    }];
    
    //8000-15000
    [Btn11 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.left.equalTo(Alert3.mas_left).offset(padding2);
        make.top.equalTo(Btn9.mas_bottom).offset(10);
        make.height.mas_equalTo(20);
    }];

    //15000-30000
    [Btn12 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(120);
        make.right.equalTo(Alert3.mas_right).offset(-padding2);
        make.top.equalTo(Btn10.mas_bottom).offset(10);
        make.height.mas_equalTo(20);
    }];
    
    //30000以上
    [Btn13 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.left.equalTo(Alert3.mas_left).offset(padding2);
        make.top.equalTo(Btn11.mas_bottom).offset(10);
        make.height.mas_equalTo(20);
    }];
    
    
    
    

}

//Btn7点击事件
-(void)Btn7Click
{

    NSLog(@"Btn7");
    
   
    if (_i1%2 == 1) {
        NSLog(@"管用1111");

        
        [self.Btn7 setTitleColor:[UIColor colorWithRGB:0x4f4f4f] forState:UIControlStateNormal];
        
        self.Btn8.userInteractionEnabled = YES;
        
        
        
    }else{
        NSLog(@"管用2222");

        [self.Btn7 setTitleColor:[UIColor colorWithRGB:0x228ED3] forState:UIControlStateNormal];
        
        self.Btn8.userInteractionEnabled = NO;
        
        _UserSex = @"1";
    }
    _i1++;
    
    
    
}
//Btn8点击事件
-(void)Btn8Click
{

    NSLog(@"Btn8");
   
    if (_i2%2 == 1) {
        NSLog(@"管用1111");
        
        
        [self.Btn8 setTitleColor:[UIColor colorWithRGB:0x4f4f4f] forState:UIControlStateNormal];
        
        self.Btn7.userInteractionEnabled = YES;
        
       
        
    }else{
        NSLog(@"管用2222");
        
        [self.Btn8 setTitleColor:[UIColor colorWithRGB:0x228ED3] forState:UIControlStateNormal];
        
        self.Btn7.userInteractionEnabled = NO;
        
        _UserSex = @"0";
    }
    _i2++;
    
}
//Btn9点击事件
-(void)Btn9Click
{

    NSLog(@"Btn9");
    
    if (_i3%2 == 1) {
        NSLog(@"管用1111");
        
        
        [self.Btn9 setTitleColor:[UIColor colorWithRGB:0x4f4f4f] forState:UIControlStateNormal];
        
        self.Btn10.userInteractionEnabled = YES;
        self.Btn11.userInteractionEnabled = YES;
        self.Btn12.userInteractionEnabled = YES;
        self.Btn13.userInteractionEnabled = YES;
        
        
        
        
    }else{
        NSLog(@"管用2222");
        
        [self.Btn9 setTitleColor:[UIColor colorWithRGB:0x228ED3] forState:UIControlStateNormal];
        
        self.Btn10.userInteractionEnabled = NO;
        self.Btn11.userInteractionEnabled = NO;
        self.Btn12.userInteractionEnabled = NO;
        self.Btn13.userInteractionEnabled = NO;
        
        _UserMany = @"1";
 
    }
    _i3++;
    
}
//Btn10点击事件
-(void)Btn10Click
{

    NSLog(@"Btn10");
    
    if (_i4%2 == 1) {
        NSLog(@"管用1111");
        
        
        [self.Btn10 setTitleColor:[UIColor colorWithRGB:0x4f4f4f] forState:UIControlStateNormal];
        
        self.Btn9.userInteractionEnabled = YES;
        self.Btn11.userInteractionEnabled = YES;
        self.Btn12.userInteractionEnabled = YES;
        self.Btn13.userInteractionEnabled = YES;
        
    }else{
        NSLog(@"管用2222");
        
        [self.Btn10 setTitleColor:[UIColor colorWithRGB:0x228ED3] forState:UIControlStateNormal];
        
        self.Btn9.userInteractionEnabled = NO;
        self.Btn11.userInteractionEnabled = NO;
        self.Btn12.userInteractionEnabled = NO;
        self.Btn13.userInteractionEnabled = NO;
        
        _UserMany = @"2";
    }
    _i4++;
}
//Btn11点击事件
-(void)Btn11Click
{

    NSLog(@"Btn11");
    
    if (_i5%2 == 1) {
        NSLog(@"管用1111");
        
        
        [self.Btn11 setTitleColor:[UIColor colorWithRGB:0x4f4f4f] forState:UIControlStateNormal];
        
        self.Btn9.userInteractionEnabled = YES;
        self.Btn10.userInteractionEnabled = YES;
        self.Btn12.userInteractionEnabled = YES;
        self.Btn13.userInteractionEnabled = YES;

        
    }else{
        NSLog(@"管用2222");
        
        [self.Btn11 setTitleColor:[UIColor colorWithRGB:0x228ED3] forState:UIControlStateNormal];
        
        self.Btn9.userInteractionEnabled = NO;
        self.Btn10.userInteractionEnabled = NO;
        self.Btn12.userInteractionEnabled = NO;
        self.Btn13.userInteractionEnabled = NO;
        
        _UserMany = @"3";
    }
    _i5++;
}
//Btn12点击事件
-(void)Btn12Click
{

    NSLog(@"Btn12");
    
    if (_i6%2 == 1) {
        NSLog(@"管用1111");
        
        
        [self.Btn12 setTitleColor:[UIColor colorWithRGB:0x4f4f4f] forState:UIControlStateNormal];
        
        self.Btn9.userInteractionEnabled = YES;
        self.Btn10.userInteractionEnabled = YES;
        self.Btn11.userInteractionEnabled = YES;
        self.Btn13.userInteractionEnabled = YES;
        
    }else{
        NSLog(@"管用2222");
        
        [self.Btn12 setTitleColor:[UIColor colorWithRGB:0x228ED3] forState:UIControlStateNormal];
        
        self.Btn9.userInteractionEnabled = NO;
        self.Btn10.userInteractionEnabled = NO;
        self.Btn11.userInteractionEnabled = NO;
        self.Btn13.userInteractionEnabled = NO;
        
        _UserMany = @"4";
    }
    _i6++;
}
//Btn13点击事件
-(void)Btn13Click
{

    NSLog(@"Btn13");
    
    if (_i7%2 == 1) {
        NSLog(@"管用1111");
        
        
        [self.Btn13 setTitleColor:[UIColor colorWithRGB:0x4f4f4f] forState:UIControlStateNormal];
        
        self.Btn9.userInteractionEnabled = YES;
        self.Btn10.userInteractionEnabled = YES;
        self.Btn11.userInteractionEnabled = YES;
        self.Btn12.userInteractionEnabled = YES;
        
    }else{
        NSLog(@"管用2222");
        
        [self.Btn13 setTitleColor:[UIColor colorWithRGB:0x228ED3] forState:UIControlStateNormal];
        
        self.Btn9.userInteractionEnabled = NO;
        self.Btn10.userInteractionEnabled = NO;
        self.Btn11.userInteractionEnabled = NO;
        self.Btn12.userInteractionEnabled = NO;
        
        _UserMany = @"5";
    }
    _i7++;
}
//Btn14点击事件
-(void)Btn14Click
{
    self.AlertV3.hidden = YES;
    self.AlertV2.hidden = YES;
    self.AlertV1.hidden = YES;
    NSLog(@"Btn14");
    
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    if (self.UserText == nil) {
        
        MBProgressHUD *hud =   [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        
        // Configure for text only and offset down
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"对不起，目前没有此职位";
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        
        [hud hide:YES afterDelay:1];
    }else if(self.UserMany == nil){
        
        MBProgressHUD *hud =   [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        
        // Configure for text only and offset down
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"请选择薪资范围";
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        
        [hud hide:YES afterDelay:1];
    
    }else if(self.UserSex == nil){
        
        MBProgressHUD *hud =   [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        
        // Configure for text only and offset down
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"请选择候选人性别";
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        
        [hud hide:YES afterDelay:1];
        
    }else{
        
        NSDictionary *pamas = @{@"keywords":self.UserText,
                                @"page":@"0",
                                @"rewards":_UserMany,
                                @"sex":_UserSex
                                };
        
        
        [mgr POST:UrlStrPositionSearch parameters:pamas success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //
            NSLog(@"Btn14点击事件==》%@",responseObject);
            
            NSArray *dictarray = [responseObject objectForKey:@"data"];
            
            int code = [[responseObject objectForKey:@"code"] intValue];
            
            if (code != 1000) {
                
                MBProgressHUD *hud =   [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
                
                // Configure for text only and offset down
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"对不起，目前没有此职位";
                hud.margin = 10.f;
                hud.removeFromSuperViewOnHide = YES;
                
                [hud hide:YES afterDelay:1];
                
                NSLog(@"搜索有误");
                
            }else{
                NSMutableArray *tempArray = [NSMutableArray array];
                
                for (NSDictionary *dict in dictarray) {
                    PXZhiWei *zhiwei = [PXZhiWei objectWithKeyValues:dict];
                    
                    [tempArray addObject:zhiwei];
                    
                }
                [self.dataArray removeAllObjects];
                [self.dataArray addObjectsFromArray:tempArray];
                [self.SearchV reloadData];
                
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //
            NSLog(@"Btn14点击事件失败==》%@",error);
        }];
        
    }
    

}


//屏幕滑动时隐藏Alert
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.AlertV1.hidden = YES;
    self.AlertV2.hidden = YES;
    self.AlertV3.hidden = YES;
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
    _UserText = textField.text;
    
    [self setupTextSearchWithText:textField.text];
    
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
