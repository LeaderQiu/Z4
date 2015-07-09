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

@interface PXAlerayViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UIButton *ShiJian;
@property(nonatomic,strong) UIButton *ZhuangTai;
@property(nonatomic,strong) UIButton *DaiYu;

@property(nonatomic,strong) UIView *AlertV1;
@property(nonatomic,strong) UIView *AlertV2;
@property(nonatomic,strong) UIView *AlertV3;

@property(nonatomic,strong) UIView *headerV;

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
    
    //加载网络数据
    [self setupOrderList];

}
- (NSMutableArray *)dataArray {
    
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
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
    
    UIView *AlertV1 = [UIView new];
    
    _AlertV1 = AlertV1;
        
    UIImageView *backImage1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"弹出框1"]];
    
    [AlertV1 addSubview:backImage1];
  
    [self.view addSubview:AlertV1];
    
    //backImage约束
    [backImage1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(AlertV1);
    }];
    
    //AlertV1约束
    [AlertV1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(10);
        make.top.equalTo(self.view.mas_top).offset(44);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.height.mas_equalTo(59);
    }];
}

//点击入职状态
-(void)ZhuangTaiClick
{
    self.AlertV1.hidden = YES;
    self.AlertV3.hidden = YES;
    
    UIView *AlertV2 = [UIView new];
    
    _AlertV2 = AlertV2;
    
    UIImageView *backImage2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"弹出框2"]];
    
    
    [self.view addSubview:AlertV2];
    [AlertV2 addSubview:backImage2];
    
    //backImage约束
    [backImage2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(AlertV2);
    }];
    
    //AlertV约束
    
    [AlertV2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.top.equalTo(self.view.mas_top).offset(44);
        make.right.equalTo(self.view).offset(-10);
        make.height.mas_equalTo(59);
    }];
    
 
}

//点击薪资待遇
-(void)DaiYuClick
{
    
    self.AlertV1.hidden = YES;
    self.AlertV2.hidden = YES;

    UIView *AlertV3 = [UIView new];
    _AlertV3 = AlertV3;
   
    UIImageView *backImage1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"弹出框3"]];
    
    [AlertV3 addSubview:backImage1];
    [self.view addSubview:AlertV3];
    
    //给backImage1设置约束
    [backImage1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(AlertV3);
    }];
    
    //给Alert3设置约束
    [AlertV3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.top.equalTo(self.tableView.mas_top).offset(44);
        make.height.mas_equalTo(51);
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
