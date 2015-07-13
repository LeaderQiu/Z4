//
//  PXAlerayViewController.m
//  ZhonglieApp
//
//  Created by 邱思雨 on 15/5/25.
//  Copyright (c) 2015年 PX. All rights reserved.
//

#import "PXAlerayViewController.h"
#import "PXHistoryCell.h"
#import "Masonry.h"
#import "AFNetworking.h"
#import "PXOrderCell.h"
#import "MJExtension.h"
#import "UIColor+SYExtension.h"
#import "MBProgressHUD.h"
#import "MJRefresh.h"

@interface PXAlerayViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UIButton *ShiJian;
@property(nonatomic,strong) UIButton *ZhuangTai;
@property(nonatomic,strong) UIButton *DaiYu;

@property(nonatomic,strong) UIView *AlertV1;
@property(nonatomic,strong) UIView *AlertV2;
@property(nonatomic,strong) UIView *AlertV3;

@property(nonatomic,strong) UIView *headerV;

@property(nonatomic,assign) NSInteger pageNumber;



/**存放的模型数组*/
@property(nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation PXAlerayViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image: [UIImage imageNamed:@"已推荐"]selectedImage:[UIImage imageNamed:@"已推荐-hover"]];
    self.navigationController.tabBarItem.title = @"已推荐";

    self.navigationItem.title = @"推荐记录";
    
    self.tableView.rowHeight = 101;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    [self.tableView.header beginRefreshing];
    
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];

    
//    //加载网络数据
//    [self setupOrderList];

}
- (NSMutableArray *)dataArray {
    
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}


//下拉刷新控件loadNewData
-(void)loadNewData
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *pamas = @{@"uid":@"2"};
    
    [mgr POST:UrlStrOrderList parameters:pamas success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //成功的回调
        NSLog(@"已推荐列表成功==>%@",responseObject);
        
        [self.tableView.header endRefreshing];
        
        NSArray *dictArray = [responseObject objectForKey:@"data"];
        NSMutableArray *tempArray = [NSMutableArray array];
        
        for (NSDictionary *dict in dictArray) {
            PXOrderCell *order = [PXOrderCell objectWithKeyValues:dict];
            
            [tempArray addObject:order];
        }
        
        [self.dataArray addObjectsFromArray:tempArray];
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //失败的回调
        NSLog(@"已推荐列表失败==》%@",error);
        
        [self.tableView.header endRefreshing];
        
    }];

}

//上拉刷新控件loadMoreData
-(void)loadMoreData
{
    self.pageNumber += 1;
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *pamas = @{@"uid":@"2",@"page":[NSString stringWithFormat:@"%zd",self.pageNumber]};
    
    [mgr POST:UrlStrOrderList parameters:pamas success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //成功的回调
        NSLog(@"已推荐列表成功==>%@",responseObject);
        
        [self.tableView.footer endRefreshing];
        
        int code = [[responseObject objectForKey:@"code"] intValue];
        
        if (code == 1000) {
            
            NSArray *dictArray = [responseObject objectForKey:@"data"];
            NSMutableArray *tempArray = [NSMutableArray array];
            
            for (NSDictionary *dict in dictArray) {
                PXOrderCell *order = [PXOrderCell objectWithKeyValues:dict];
                
                [tempArray addObject:order];
            }
            
            [self.dataArray addObjectsFromArray:tempArray];
            [self.tableView reloadData];

        }else{
            self.pageNumber -= 1;
            
            [self.tableView.footer noticeNoMoreData];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //失败的回调
        NSLog(@"已推荐列表失败==》%@",error);
        
        [self.tableView.footer noticeNoMoreData];
        
    }];

}


//加载网络数据
-(void)setupOrderList
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *pamas = @{@"uid":@"2"};
    
    [mgr POST:UrlStrOrderList parameters:pamas success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //成功的回调
        NSLog(@"已推荐列表成功==>%@",responseObject);
        
        NSArray *dictArray = [responseObject objectForKey:@"data"];
        NSMutableArray *tempArray = [NSMutableArray array];
        
        for (NSDictionary *dict in dictArray) {
            PXOrderCell *order = [PXOrderCell objectWithKeyValues:dict];
            
            [tempArray addObject:order];
        }
        
        [self.dataArray addObjectsFromArray:tempArray];
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //失败的回调
        NSLog(@"已推荐列表失败==》%@",error);
        
    }];
}


//设置headerView的属性
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
  
    UIView *headerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
    
    _headerV = headerV;
    
    UIImageView *backImageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"头部背景"]];

    [headerV addSubview:backImageV];
    
    [self.view addSubview:headerV];
    

    
    //backImageV约束
    [backImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(headerV);
    }];
    
    //创建三个筛选按钮
//    UIButton *ShiJian = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 107,44)];
    UIButton *ShiJian = [UIButton new];
    _ShiJian = ShiJian;
    
    [ShiJian setImage:[UIImage imageNamed:@"推荐时间"] forState:UIControlStateNormal];
    
    [ShiJian addTarget:self action:@selector(ShiJianClick) forControlEvents:UIControlEventTouchUpInside];
    
    [headerV addSubview:ShiJian];
    
//    UIButton *ZhuangTai = [[UIButton alloc]initWithFrame:CGRectMake(107, 0, 107,44)];
    UIButton *ZhuangTai = [UIButton new];
    _ZhuangTai = ZhuangTai;
    
    [ZhuangTai setImage:[UIImage imageNamed:@"入职状态"] forState:UIControlStateNormal];
    
    [ZhuangTai addTarget:self action:@selector(ZhuangTaiClick) forControlEvents:UIControlEventTouchUpInside];
    
    [headerV addSubview:ZhuangTai];
    
//    UIButton *DaiYu = [[UIButton alloc]initWithFrame:CGRectMake(214, 0, 107,44)];
    UIButton *DaiYu = [UIButton new];
    _DaiYu = DaiYu;
    
    [DaiYu setImage:[UIImage imageNamed:@"薪资待遇"] forState:UIControlStateNormal];
    
    [DaiYu addTarget:self action:@selector(DaiYuClick) forControlEvents:UIControlEventTouchUpInside];
    
    [headerV addSubview:DaiYu];
    
    //ShiJian约束
    
    int padding1 = ([UIScreen mainScreen].bounds.size.width/3);
    
    [ShiJian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(padding1);
        make.height.equalTo(headerV);
        make.top.equalTo(headerV);
        make.left.equalTo(headerV);
    }];
    
    //ZhuangTai约束
    [ZhuangTai mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(padding1);
        make.height.equalTo(headerV);
        make.left.equalTo(ShiJian.mas_right);
        make.top.equalTo(headerV);
    }];
    
    //DaiYu约束
    [DaiYu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(padding1);
        make.height.equalTo(headerV);
        make.right.equalTo(headerV);
        make.top.equalTo(headerV);
    }];
    
    
    return headerV;
    
}

//点击推荐时间
-(void)ShiJianClick
{
    self.AlertV2.hidden = YES;
    self.AlertV3.hidden = YES;
    NSLog(@"点击了发布时间");
    
    UIView *Alert1 = [UIView new];
    
    _AlertV1 = Alert1;
    
    UIImageView *backImage1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"弹出框1"]];
    
    UIButton *Btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *Btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *Btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    [Btn1 setTitle:@"近一个月" forState:UIControlStateNormal];
    [Btn2 setTitle:@"近三个月" forState:UIControlStateNormal];
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
    
    [self.view addSubview:Alert1];
    
    //给backImage1设置约束
    [backImage1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(Alert1);
    }];
    
    //AlertV1约束
    [Alert1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(10);
        make.top.equalTo(self.view.mas_top).offset(44);
        make.right.equalTo(self.DaiYu.mas_right).offset(-10);
        make.height.mas_equalTo(59);
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
    

        NSDictionary *pamas = @{@"uid":@"2",
                                @"page":@"0",
                                @"order_time":@"1"};
        
        [mgr POST:UrlStrOrderList parameters:pamas success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //
            NSLog(@"Btn1点击事件==》%@",responseObject);
            
            NSArray *dictarray = [responseObject objectForKey:@"data"];
            
            int code = [[responseObject objectForKey:@"code"] intValue];
            
            if (code != 1000) {
                
                MBProgressHUD *hud =   [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
                
                // Configure for text only and offset down
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"对不起，目前没有此简历";
                hud.margin = 10.f;
                hud.removeFromSuperViewOnHide = YES;
                
                [hud hide:YES afterDelay:1];
                
                NSLog(@"搜索有误");
                
            }else{
                NSMutableArray *tempArray = [NSMutableArray array];
                
                for (NSDictionary *dict in dictarray) {
                    PXOrderCell *order = [PXOrderCell objectWithKeyValues:dict];
                    
                    [tempArray addObject:order];
                    
                }
                [self.dataArray removeAllObjects];
                [self.dataArray addObjectsFromArray:tempArray];
                [self.tableView reloadData];
                
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //
            NSLog(@"Btn1点击事件失败==》%@",error);
        }];

}

//Btn2点击事件
-(void)Btn2Click
{
    self.AlertV3.hidden = YES;
    self.AlertV2.hidden = YES;
    self.AlertV1.hidden = YES;
    NSLog(@"Btn2");
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    
    NSDictionary *pamas = @{@"uid":@"2",
                            @"page":@"0",
                            @"order_time":@"2"};
    
    [mgr POST:UrlStrOrderList parameters:pamas success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
        NSLog(@"Btn2点击事件==》%@",responseObject);
        
        NSArray *dictarray = [responseObject objectForKey:@"data"];
        
        int code = [[responseObject objectForKey:@"code"] intValue];
        
        if (code != 1000) {
            
            MBProgressHUD *hud =   [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            
            // Configure for text only and offset down
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"对不起，目前没有此简历";
            hud.margin = 10.f;
            hud.removeFromSuperViewOnHide = YES;
            
            [hud hide:YES afterDelay:1];
            
            NSLog(@"搜索有误");
            
        }else{
            NSMutableArray *tempArray = [NSMutableArray array];
            
            for (NSDictionary *dict in dictarray) {
                PXOrderCell *order = [PXOrderCell objectWithKeyValues:dict];
                
                [tempArray addObject:order];
                
            }
            [self.dataArray removeAllObjects];
            [self.dataArray addObjectsFromArray:tempArray];
            [self.tableView reloadData];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        NSLog(@"Btn2点击事件失败==》%@",error);
    }];
    
    
}

//Btn3点击事件
-(void)Btn3Click
{
    self.AlertV3.hidden = YES;
    self.AlertV2.hidden = YES;
    self.AlertV1.hidden = YES;
    NSLog(@"Btn3");
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    
    NSDictionary *pamas = @{@"uid":@"2",
                            @"page":@"0",
                            @"order_time":@"0"};
    
    [mgr POST:UrlStrOrderList parameters:pamas success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
        NSLog(@"Btn3点击事件==》%@",responseObject);
        
        NSArray *dictarray = [responseObject objectForKey:@"data"];
        
        int code = [[responseObject objectForKey:@"code"] intValue];
        
        if (code != 1000) {
            
            MBProgressHUD *hud =   [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            
            // Configure for text only and offset down
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"对不起，目前没有此简历";
            hud.margin = 10.f;
            hud.removeFromSuperViewOnHide = YES;
            
            [hud hide:YES afterDelay:1];
            
            NSLog(@"搜索有误");
            
        }else{
            NSMutableArray *tempArray = [NSMutableArray array];
            
            for (NSDictionary *dict in dictarray) {
                PXOrderCell *order = [PXOrderCell objectWithKeyValues:dict];
                
                [tempArray addObject:order];
                
            }
            [self.dataArray removeAllObjects];
            [self.dataArray addObjectsFromArray:tempArray];
            [self.tableView reloadData];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        NSLog(@"Btn3点击事件失败==》%@",error);
    }];
    
    
}

//点击入职状态
-(void)ZhuangTaiClick
{
    
    self.AlertV3.hidden = YES;
    self.AlertV1.hidden = YES;
    NSLog(@"点击了薪资待遇");
    
    UIView *Alert2 = [UIView new];
    
    _AlertV2 = Alert2;
    
    UIImageView *backImage1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"弹出框2"]];
    
    UIButton *Btn7 = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *Btn8 = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *Btn9 = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *Btn10 = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *Btn11 = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *Btn12 = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *Btn13 = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *Btn14 = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *Btn15 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    [Btn7 setTitle:@"面试中" forState:UIControlStateNormal];
    [Btn8 setTitle:@"面试未通过" forState:UIControlStateNormal];
    [Btn9 setTitle:@"未查看" forState:UIControlStateNormal];
    [Btn10 setTitle:@"已查看" forState:UIControlStateNormal];
    [Btn11 setTitle:@"未入职" forState:UIControlStateNormal];
    [Btn12 setTitle:@"已入职" forState:UIControlStateNormal];
    [Btn13 setTitle:@"未结款" forState:UIControlStateNormal];
    [Btn14 setTitle:@"已结算" forState:UIControlStateNormal];
    [Btn15 setTitle:@"终止" forState:UIControlStateNormal];
    
    
    [Btn7 setTitleColor:[UIColor colorWithRGB:0x4f4f4f] forState:UIControlStateNormal];
    [Btn8 setTitleColor:[UIColor colorWithRGB:0x4f4f4f] forState:UIControlStateNormal];
    [Btn9 setTitleColor:[UIColor colorWithRGB:0x4f4f4f] forState:UIControlStateNormal];
    [Btn10 setTitleColor:[UIColor colorWithRGB:0x4f4f4f] forState:UIControlStateNormal];
    [Btn11 setTitleColor:[UIColor colorWithRGB:0x4f4f4f] forState:UIControlStateNormal];
    [Btn12 setTitleColor:[UIColor colorWithRGB:0x4f4f4f] forState:UIControlStateNormal];
    [Btn13 setTitleColor:[UIColor colorWithRGB:0x4f4f4f] forState:UIControlStateNormal];
    [Btn14 setTitleColor:[UIColor colorWithRGB:0x4f4f4f] forState:UIControlStateNormal];
    [Btn15 setTitleColor:[UIColor colorWithRGB:0x4f4f4f] forState:UIControlStateNormal];
    
    Btn7.titleLabel.font = [UIFont systemFontOfSize:18];
    Btn8.titleLabel.font = [UIFont systemFontOfSize:18];
    Btn9.titleLabel.font = [UIFont systemFontOfSize:18];
    Btn10.titleLabel.font = [UIFont systemFontOfSize:18];
    Btn11.titleLabel.font = [UIFont systemFontOfSize:18];
    Btn12.titleLabel.font = [UIFont systemFontOfSize:18];
    Btn13.titleLabel.font = [UIFont systemFontOfSize:18];
    Btn14.titleLabel.font = [UIFont systemFontOfSize:18];
    Btn15.titleLabel.font = [UIFont systemFontOfSize:18];
    
    
    
    [Alert2 addSubview:backImage1];
    
    [Alert2 addSubview:Btn7];
    [Alert2 addSubview:Btn8];
    [Alert2 addSubview:Btn9];
    [Alert2 addSubview:Btn10];
    [Alert2 addSubview:Btn11];
    [Alert2 addSubview:Btn12];
    [Alert2 addSubview:Btn13];
    [Alert2 addSubview:Btn14];
    [Alert2 addSubview:Btn15];
    
    [Btn7 addTarget:self action:@selector(Btn7Click) forControlEvents:UIControlEventTouchUpInside];
    
    [Btn8 addTarget:self action:@selector(Btn8Click) forControlEvents:UIControlEventTouchUpInside];
    
    [Btn9 addTarget:self action:@selector(Btn9Click) forControlEvents:UIControlEventTouchUpInside];
    [Btn10 addTarget:self action:@selector(Btn10Click) forControlEvents:UIControlEventTouchUpInside];
    
    [Btn11 addTarget:self action:@selector(Btn11Click) forControlEvents:UIControlEventTouchUpInside];
    
    [Btn12 addTarget:self action:@selector(Btn12Click) forControlEvents:UIControlEventTouchUpInside];
    [Btn13 addTarget:self action:@selector(Btn13Click) forControlEvents:UIControlEventTouchUpInside];
    
    [Btn14 addTarget:self action:@selector(Btn14Click) forControlEvents:UIControlEventTouchUpInside];
    
    [Btn15 addTarget:self action:@selector(Btn15Click) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:Alert2];
    
    //给backImage1设置约束
    [backImage1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(Alert2);
    }];
    
    //AlertV2约束
    [Alert2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(10);
        make.top.equalTo(self.view.mas_top).offset(44);
        make.right.equalTo(self.DaiYu.mas_right).offset(-10);
        make.height.mas_equalTo(127);
    }];
    
    //给Btn设置约束
    int padding1 = (self.view.bounds.size.width-300)/4;
    int padding2 = (127-60)/4;
    
    NSLog(@"padding==>%d",padding1);
    
    [Btn7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
        make.left.equalTo(Alert2.mas_left).offset(padding1);
        make.top.equalTo(Alert2.mas_top).offset(padding2);
        
    }];
    
    [Btn8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
        make.left.equalTo(Btn7.mas_right).offset(padding1-10);
        make.top.equalTo(Alert2.mas_top).offset(padding2);
    }];

    [Btn9 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
        make.right.equalTo(Alert2.mas_right).offset(-padding1);
        make.top.equalTo(Alert2.mas_top).offset(padding2);
        

    }];

    [Btn10 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
        make.left.equalTo(Alert2.mas_left).offset(padding1);
        make.top.equalTo(Btn7.mas_bottom).offset(padding2);
        
    }];
    
    [Btn11 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
        make.left.equalTo(Btn10.mas_right).offset(padding1-10);
        make.top.equalTo(Btn7.mas_bottom).offset(padding2);
        
    }];
    
    [Btn12 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
        make.right.equalTo(Alert2.mas_right).offset(-padding1);
        make.top.equalTo(Btn7.mas_bottom).offset(padding2);
        

    }];
    
    
    [Btn13 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
        make.left.equalTo(Alert2.mas_left).offset(padding1);
        make.top.equalTo(Btn12.mas_bottom).offset(padding2);
        
    }];
    
    [Btn14 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
        make.left.equalTo(Btn13.mas_right).offset(padding1-10);
        make.top.equalTo(Btn12.mas_bottom).offset(padding2);
        
    }];
    
    [Btn15 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
        make.right.equalTo(Alert2.mas_right).offset(-padding1);
        make.top.equalTo(Btn12.mas_bottom).offset(padding2);
        
        
    }];

    
}
//Btn7点击事件
-(void)Btn7Click
{
    self.AlertV3.hidden = YES;
    self.AlertV2.hidden = YES;
    self.AlertV1.hidden = YES;
    NSLog(@"Btn7");
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    
    NSDictionary *pamas = @{@"uid":@"2",
                            @"page":@"0",
                            @"order_status":@"2"};
    
    [mgr POST:UrlStrOrderList parameters:pamas success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
        NSLog(@"Btn7点击事件==》%@",responseObject);
        
        NSArray *dictarray = [responseObject objectForKey:@"data"];
        
        int code = [[responseObject objectForKey:@"code"] intValue];
        
        if (code != 1000) {
            
            MBProgressHUD *hud =   [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            
            // Configure for text only and offset down
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"对不起，目前没有此简历";
            hud.margin = 10.f;
            hud.removeFromSuperViewOnHide = YES;
            
            [hud hide:YES afterDelay:1];
            
            NSLog(@"搜索有误");
            
        }else{
            NSMutableArray *tempArray = [NSMutableArray array];
            
            for (NSDictionary *dict in dictarray) {
                PXOrderCell *order = [PXOrderCell objectWithKeyValues:dict];
                
                [tempArray addObject:order];
                
            }
            [self.dataArray removeAllObjects];
            [self.dataArray addObjectsFromArray:tempArray];
            [self.tableView reloadData];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        NSLog(@"Btn7点击事件失败==》%@",error);
    }];
    
}

//Btn8点击事件
-(void)Btn8Click
{
    self.AlertV3.hidden = YES;
    self.AlertV2.hidden = YES;
    self.AlertV1.hidden = YES;
    NSLog(@"Btn8");
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    
    NSDictionary *pamas = @{@"uid":@"2",
                            @"page":@"0",
                            @"order_status":@"3"};
    
    [mgr POST:UrlStrOrderList parameters:pamas success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
        NSLog(@"Btn8点击事件==》%@",responseObject);
        
        NSArray *dictarray = [responseObject objectForKey:@"data"];
        
        int code = [[responseObject objectForKey:@"code"] intValue];
        
        if (code != 1000) {
            
            MBProgressHUD *hud =   [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            
            // Configure for text only and offset down
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"对不起，目前没有此简历";
            hud.margin = 10.f;
            hud.removeFromSuperViewOnHide = YES;
            
            [hud hide:YES afterDelay:1];
            
            NSLog(@"搜索有误");
            
        }else{
            NSMutableArray *tempArray = [NSMutableArray array];
            
            for (NSDictionary *dict in dictarray) {
                PXOrderCell *order = [PXOrderCell objectWithKeyValues:dict];
                
                [tempArray addObject:order];
                
            }
            [self.dataArray removeAllObjects];
            [self.dataArray addObjectsFromArray:tempArray];
            [self.tableView reloadData];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        NSLog(@"Btn8点击事件失败==》%@",error);
    }];
    
    
}

//Btn9点击事件
-(void)Btn9Click
{
    self.AlertV3.hidden = YES;
    self.AlertV2.hidden = YES;
    self.AlertV1.hidden = YES;
    NSLog(@"Btn9");
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    
    NSDictionary *pamas = @{@"uid":@"2",
                            @"page":@"0",
                            @"order_status":@"0"};
    
    [mgr POST:UrlStrOrderList parameters:pamas success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
        NSLog(@"Btn9点击事件==》%@",responseObject);
        
        NSArray *dictarray = [responseObject objectForKey:@"data"];
        
        int code = [[responseObject objectForKey:@"code"] intValue];
        
        if (code != 1000) {
            
            MBProgressHUD *hud =   [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            
            // Configure for text only and offset down
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"对不起，目前没有此简历";
            hud.margin = 10.f;
            hud.removeFromSuperViewOnHide = YES;
            
            [hud hide:YES afterDelay:1];
            
            NSLog(@"搜索有误");
            
        }else{
            NSMutableArray *tempArray = [NSMutableArray array];
            
            for (NSDictionary *dict in dictarray) {
                PXOrderCell *order = [PXOrderCell objectWithKeyValues:dict];
                
                [tempArray addObject:order];
                
            }
            [self.dataArray removeAllObjects];
            [self.dataArray addObjectsFromArray:tempArray];
            [self.tableView reloadData];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        NSLog(@"Btn9点击事件失败==》%@",error);
    }];
    
    
}
//Btn10点击事件
-(void)Btn10Click
{
    self.AlertV3.hidden = YES;
    self.AlertV2.hidden = YES;
    self.AlertV1.hidden = YES;
    NSLog(@"Btn10");
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    
    NSDictionary *pamas = @{@"uid":@"2",
                            @"page":@"0",
                            @"order_status":@"1"};
    
    [mgr POST:UrlStrOrderList parameters:pamas success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
        NSLog(@"Btn10点击事件==》%@",responseObject);
        
        NSArray *dictarray = [responseObject objectForKey:@"data"];
        
        int code = [[responseObject objectForKey:@"code"] intValue];
        
        if (code != 1000) {
            
            MBProgressHUD *hud =   [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            
            // Configure for text only and offset down
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"对不起，目前没有此简历";
            hud.margin = 10.f;
            hud.removeFromSuperViewOnHide = YES;
            
            [hud hide:YES afterDelay:1];
            
            NSLog(@"搜索有误");
            
        }else{
            NSMutableArray *tempArray = [NSMutableArray array];
            
            for (NSDictionary *dict in dictarray) {
                PXOrderCell *order = [PXOrderCell objectWithKeyValues:dict];
                
                [tempArray addObject:order];
                
            }
            [self.dataArray removeAllObjects];
            [self.dataArray addObjectsFromArray:tempArray];
            [self.tableView reloadData];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        NSLog(@"Btn10点击事件失败==》%@",error);
    }];
    
}

//Btn11点击事件
-(void)Btn11Click
{
    self.AlertV3.hidden = YES;
    self.AlertV2.hidden = YES;
    self.AlertV1.hidden = YES;
    NSLog(@"Btn11");
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    
    NSDictionary *pamas = @{@"uid":@"2",
                            @"page":@"0",
                            @"order_status":@"4"};
    
    [mgr POST:UrlStrOrderList parameters:pamas success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
        NSLog(@"Btn11点击事件==》%@",responseObject);
        
        NSArray *dictarray = [responseObject objectForKey:@"data"];
        
        int code = [[responseObject objectForKey:@"code"] intValue];
        
        if (code != 1000) {
            
            MBProgressHUD *hud =   [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            
            // Configure for text only and offset down
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"对不起，目前没有此简历";
            hud.margin = 10.f;
            hud.removeFromSuperViewOnHide = YES;
            
            [hud hide:YES afterDelay:1];
            
            NSLog(@"搜索有误");
            
        }else{
            NSMutableArray *tempArray = [NSMutableArray array];
            
            for (NSDictionary *dict in dictarray) {
                PXOrderCell *order = [PXOrderCell objectWithKeyValues:dict];
                
                [tempArray addObject:order];
                
            }
            [self.dataArray removeAllObjects];
            [self.dataArray addObjectsFromArray:tempArray];
            [self.tableView reloadData];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        NSLog(@"Btn11点击事件失败==》%@",error);
    }];
    
    
}

//Btn12点击事件
-(void)Btn12Click
{
    self.AlertV3.hidden = YES;
    self.AlertV2.hidden = YES;
    self.AlertV1.hidden = YES;
    NSLog(@"Btn12");
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    
    NSDictionary *pamas = @{@"uid":@"2",
                            @"page":@"0",
                            @"order_status":@"5"};
    
    [mgr POST:UrlStrOrderList parameters:pamas success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
        NSLog(@"Btn12点击事件==》%@",responseObject);
        
        NSArray *dictarray = [responseObject objectForKey:@"data"];
        
        int code = [[responseObject objectForKey:@"code"] intValue];
        
        if (code != 1000) {
            
            MBProgressHUD *hud =   [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            
            // Configure for text only and offset down
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"对不起，目前没有此简历";
            hud.margin = 10.f;
            hud.removeFromSuperViewOnHide = YES;
            
            [hud hide:YES afterDelay:1];
            
            NSLog(@"搜索有误");
            
        }else{
            NSMutableArray *tempArray = [NSMutableArray array];
            
            for (NSDictionary *dict in dictarray) {
                PXOrderCell *order = [PXOrderCell objectWithKeyValues:dict];
                
                [tempArray addObject:order];
                
            }
            [self.dataArray removeAllObjects];
            [self.dataArray addObjectsFromArray:tempArray];
            [self.tableView reloadData];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        NSLog(@"Btn12点击事件失败==》%@",error);
    }];
    
    
}
//Btn13点击事件
-(void)Btn13Click
{
    self.AlertV3.hidden = YES;
    self.AlertV2.hidden = YES;
    self.AlertV1.hidden = YES;
    NSLog(@"Btn13");
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    
    NSDictionary *pamas = @{@"uid":@"2",
                            @"page":@"0",
                            @"order_status":@"6"};
    
    [mgr POST:UrlStrOrderList parameters:pamas success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
        NSLog(@"Btn13点击事件==》%@",responseObject);
        
        NSArray *dictarray = [responseObject objectForKey:@"data"];
        
        int code = [[responseObject objectForKey:@"code"] intValue];
        
        if (code != 1000) {
            
            MBProgressHUD *hud =   [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            
            // Configure for text only and offset down
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"对不起，目前没有此简历";
            hud.margin = 10.f;
            hud.removeFromSuperViewOnHide = YES;
            
            [hud hide:YES afterDelay:1];
            
            NSLog(@"搜索有误");
            
        }else{
            NSMutableArray *tempArray = [NSMutableArray array];
            
            for (NSDictionary *dict in dictarray) {
                PXOrderCell *order = [PXOrderCell objectWithKeyValues:dict];
                
                [tempArray addObject:order];
                
            }
            [self.dataArray removeAllObjects];
            [self.dataArray addObjectsFromArray:tempArray];
            [self.tableView reloadData];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        NSLog(@"Btn13点击事件失败==》%@",error);
    }];
    
}

//Btn14点击事件
-(void)Btn14Click
{
    self.AlertV3.hidden = YES;
    self.AlertV2.hidden = YES;
    self.AlertV1.hidden = YES;
    NSLog(@"Btn14");
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    
    NSDictionary *pamas = @{@"uid":@"2",
                            @"page":@"0",
                            @"order_status":@"7"};
    
    [mgr POST:UrlStrOrderList parameters:pamas success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
        NSLog(@"Btn14点击事件==》%@",responseObject);
        
        NSArray *dictarray = [responseObject objectForKey:@"data"];
        
        int code = [[responseObject objectForKey:@"code"] intValue];
        
        if (code != 1000) {
            
            MBProgressHUD *hud =   [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            
            // Configure for text only and offset down
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"对不起，目前没有此简历";
            hud.margin = 10.f;
            hud.removeFromSuperViewOnHide = YES;
            
            [hud hide:YES afterDelay:1];
            
            NSLog(@"搜索有误");
            
        }else{
            NSMutableArray *tempArray = [NSMutableArray array];
            
            for (NSDictionary *dict in dictarray) {
                PXOrderCell *order = [PXOrderCell objectWithKeyValues:dict];
                
                [tempArray addObject:order];
                
            }
            [self.dataArray removeAllObjects];
            [self.dataArray addObjectsFromArray:tempArray];
            [self.tableView reloadData];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        NSLog(@"Btn14点击事件失败==》%@",error);
    }];
    
    
}

//Btn15点击事件
-(void)Btn15Click
{
    self.AlertV3.hidden = YES;
    self.AlertV2.hidden = YES;
    self.AlertV1.hidden = YES;
    NSLog(@"Btn15");
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    
    NSDictionary *pamas = @{@"uid":@"2",
                            @"page":@"0",
                            @"order_status":@"8"};
    
    [mgr POST:UrlStrOrderList parameters:pamas success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
        NSLog(@"Btn15点击事件==》%@",responseObject);
        
        NSArray *dictarray = [responseObject objectForKey:@"data"];
        
        int code = [[responseObject objectForKey:@"code"] intValue];
        
        if (code != 1000) {
            
            MBProgressHUD *hud =   [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            
            // Configure for text only and offset down
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"对不起，目前没有此简历";
            hud.margin = 10.f;
            hud.removeFromSuperViewOnHide = YES;
            
            [hud hide:YES afterDelay:1];
            
            NSLog(@"搜索有误");
            
        }else{
            NSMutableArray *tempArray = [NSMutableArray array];
            
            for (NSDictionary *dict in dictarray) {
                PXOrderCell *order = [PXOrderCell objectWithKeyValues:dict];
                
                [tempArray addObject:order];
                
            }
            [self.dataArray removeAllObjects];
            [self.dataArray addObjectsFromArray:tempArray];
            [self.tableView reloadData];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        NSLog(@"Btn15点击事件失败==》%@",error);
    }];
    
    
}

//点击薪资待遇
-(void)DaiYuClick
{
    
    self.AlertV2.hidden = YES;
    self.AlertV1.hidden = YES;
    NSLog(@"点击了薪资待遇");
    
    UIView *Alert3 = [UIView new];
    
    _AlertV3 = Alert3;
    
    UIImageView *backImage1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"弹出框3"]];
    
    UIButton *Btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *Btn5 = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *Btn6 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    [Btn4 setTitle:@"由低到高" forState:UIControlStateNormal];
    [Btn5 setTitle:@"由高到低" forState:UIControlStateNormal];
    [Btn6 setTitle:@"全部" forState:UIControlStateNormal];
    
    
    [Btn4 setTitleColor:[UIColor colorWithRGB:0x4f4f4f] forState:UIControlStateNormal];
    [Btn5 setTitleColor:[UIColor colorWithRGB:0x4f4f4f] forState:UIControlStateNormal];
    [Btn6 setTitleColor:[UIColor colorWithRGB:0x4f4f4f] forState:UIControlStateNormal];
    
    Btn4.titleLabel.font = [UIFont systemFontOfSize:18];
    Btn5.titleLabel.font = [UIFont systemFontOfSize:18];
    Btn6.titleLabel.font = [UIFont systemFontOfSize:18];
    
    
    
    [Alert3 addSubview:backImage1];
    
    [Alert3 addSubview:Btn4];
    [Alert3 addSubview:Btn5];
    [Alert3 addSubview:Btn6];
    
    [Btn4 addTarget:self action:@selector(Btn4Click) forControlEvents:UIControlEventTouchUpInside];
    
    [Btn5 addTarget:self action:@selector(Btn5Click) forControlEvents:UIControlEventTouchUpInside];
    
    [Btn6 addTarget:self action:@selector(Btn6Click) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:Alert3];
    
    //给backImage1设置约束
    [backImage1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(Alert3);
    }];
    
    //AlertV3约束
    [Alert3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(10);
        make.top.equalTo(self.view.mas_top).offset(44);
        make.right.equalTo(self.DaiYu.mas_right).offset(-10);
        make.height.mas_equalTo(59);
    }];
    
    //给Btn设置约束
    int padding1 = (self.view.bounds.size.width-240)/4;
    
    NSLog(@"padding==>%d",padding1);
    
    [Btn4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(80);
        make.left.equalTo(Alert3.mas_left).offset(padding1);
        make.centerY.equalTo(Alert3.mas_centerY).offset(5);
    }];
    
    [Btn5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(80);
        make.left.equalTo(Btn4.mas_right).offset(padding1);
        make.centerY.equalTo(Alert3.mas_centerY).offset(5);
    }];
    
    [Btn6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(80);
        make.left.equalTo(Btn5.mas_right).offset(padding1);
        make.centerY.equalTo(Alert3.mas_centerY).offset(5);
    }];
    
}

//Btn4点击事件
-(void)Btn4Click
{
    self.AlertV3.hidden = YES;
    self.AlertV2.hidden = YES;
    self.AlertV1.hidden = YES;
    NSLog(@"Btn4");
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    
    NSDictionary *pamas = @{@"uid":@"2",
                            @"page":@"0",
                            @"order_reward":@"1"};
    
    [mgr POST:UrlStrOrderList parameters:pamas success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
        NSLog(@"Btn4点击事件==》%@",responseObject);
        
        NSArray *dictarray = [responseObject objectForKey:@"data"];
        
        int code = [[responseObject objectForKey:@"code"] intValue];
        
        if (code != 1000) {
            
            MBProgressHUD *hud =   [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            
            // Configure for text only and offset down
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"对不起，目前没有此简历";
            hud.margin = 10.f;
            hud.removeFromSuperViewOnHide = YES;
            
            [hud hide:YES afterDelay:1];
            
            NSLog(@"搜索有误");
            
        }else{
            NSMutableArray *tempArray = [NSMutableArray array];
            
            for (NSDictionary *dict in dictarray) {
                PXOrderCell *order = [PXOrderCell objectWithKeyValues:dict];
                
                [tempArray addObject:order];
                
            }
            [self.dataArray removeAllObjects];
            [self.dataArray addObjectsFromArray:tempArray];
            [self.tableView reloadData];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        NSLog(@"Btn4点击事件失败==》%@",error);
    }];
    
}

//Btn5点击事件
-(void)Btn5Click
{
    self.AlertV3.hidden = YES;
    self.AlertV2.hidden = YES;
    self.AlertV1.hidden = YES;
    NSLog(@"Btn5");
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    
    NSDictionary *pamas = @{@"uid":@"2",
                            @"page":@"0",
                            @"order_reward":@"2"};
    
    [mgr POST:UrlStrOrderList parameters:pamas success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
        NSLog(@"Btn5点击事件==》%@",responseObject);
        
        NSArray *dictarray = [responseObject objectForKey:@"data"];
        
        int code = [[responseObject objectForKey:@"code"] intValue];
        
        if (code != 1000) {
            
            MBProgressHUD *hud =   [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            
            // Configure for text only and offset down
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"对不起，目前没有此简历";
            hud.margin = 10.f;
            hud.removeFromSuperViewOnHide = YES;
            
            [hud hide:YES afterDelay:1];
            
            NSLog(@"搜索有误");
            
        }else{
            NSMutableArray *tempArray = [NSMutableArray array];
            
            for (NSDictionary *dict in dictarray) {
                PXOrderCell *order = [PXOrderCell objectWithKeyValues:dict];
                
                [tempArray addObject:order];
                
            }
            [self.dataArray removeAllObjects];
            [self.dataArray addObjectsFromArray:tempArray];
            [self.tableView reloadData];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        NSLog(@"Btn5点击事件失败==》%@",error);
    }];
    
    
}

//Btn6点击事件
-(void)Btn6Click
{
    self.AlertV3.hidden = YES;
    self.AlertV2.hidden = YES;
    self.AlertV1.hidden = YES;
    NSLog(@"Btn6");
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    
    NSDictionary *pamas = @{@"uid":@"2",
                            @"page":@"0",
                            @"order_reward":@"0"};
    
    [mgr POST:UrlStrOrderList parameters:pamas success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
        NSLog(@"Btn6点击事件==》%@",responseObject);
        
        NSArray *dictarray = [responseObject objectForKey:@"data"];
        
        int code = [[responseObject objectForKey:@"code"] intValue];
        
        if (code != 1000) {
            
            MBProgressHUD *hud =   [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            
            // Configure for text only and offset down
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"对不起，目前没有此简历";
            hud.margin = 10.f;
            hud.removeFromSuperViewOnHide = YES;
            
            [hud hide:YES afterDelay:1];
            
            NSLog(@"搜索有误");
            
        }else{
            NSMutableArray *tempArray = [NSMutableArray array];
            
            for (NSDictionary *dict in dictarray) {
                PXOrderCell *order = [PXOrderCell objectWithKeyValues:dict];
                
                [tempArray addObject:order];
                
            }
            [self.dataArray removeAllObjects];
            [self.dataArray addObjectsFromArray:tempArray];
            [self.tableView reloadData];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        NSLog(@"Btn6点击事件失败==》%@",error);
    }];
    
    
}

//点击空白 隐藏AlertV  （没什么用）
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
   
    self.AlertV1.hidden = YES;
}



#pragma mark - TableView Delegate DetaSource

//header的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

//自定义cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *HistoryID = @"HistoryCell";
    
    PXHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:HistoryID];
    
    PXOrderCell *orderList = self.dataArray[indexPath.row];

    
    if (cell == nil) {
        cell = [[PXHistoryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HistoryID];
    }
    
    cell.OrderList = orderList;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

//点击cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.AlertV1.hidden = YES;
    self.AlertV2.hidden = YES;
    self.AlertV3.hidden = YES;
   
}

//监听滑动 隐藏Alert
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y > 0) {
        
        self.AlertV1.hidden = YES;
        self.AlertV2.hidden = YES;
        self.AlertV3.hidden = YES;
        
    }else if(scrollView.contentOffset.y < 0){
       
        
        self.AlertV1.hidden = YES;
        self.AlertV2.hidden = YES;
        self.AlertV3.hidden = YES;
    }
}
@end
