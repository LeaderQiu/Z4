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
#import "PXMainViewController.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
#import "PXRuname.h"
#import "MJExtension.h"



@interface PXRuname2ViewController ()<UITextFieldDelegate,UITableViewDataSource,UITabBarDelegate>

@property(nonatomic,strong) UITextField *TextField;

@property(nonatomic,assign) NSInteger pageNumber;

/**存放的职位列表模型数组*/
@property(nonatomic,strong) NSMutableArray *dataArray;

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

//点击返回键
-(void)BackClickBtn
{
    PXDetailViewController *MainVC = [[PXDetailViewController alloc]init];

    [self.navigationController pushViewController:MainVC animated:YES];

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
    
    //加入MJRefresh
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    [self.tableView.header beginRefreshing];
    
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    
}

//下拉刷新loadNewData
-(void)loadNewData
{
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *pamas = @{@"page":@"0",@"uid":@"2"};
    
    [mgr POST:@"http://123.57.147.235/index.php/home/resume/resumeList" parameters:pamas success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //成功的回调
        
        NSArray *dict = [responseObject objectForKey:@"data"];
        NSMutableArray *tempArray = [NSMutableArray array];
        
        for (NSDictionary *dictArray in dict) {
            
            PXRuname *Runame = [PXRuname objectWithKeyValues:dictArray];
            
            [tempArray addObject:Runame];
        }
        
        [self.dataArray addObjectsFromArray:tempArray];
        
        [self.tableView reloadData];
        
        NSLog(@"简历列表成功==>%@",responseObject);
        
        [self.tableView.header endRefreshing];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //失败的回调
        
        NSLog(@"简历列表失败==>%@",error);
        
        [self.tableView.header endRefreshing];
    }];
    
    
}

//上拉刷新loadMoreData
-(void)loadMoreData
{

    self.pageNumber +=1;
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *pamas = @{@"page":[NSString stringWithFormat:@"%zd",self.pageNumber],@"uid":@"2"};
    
    [mgr POST:@"http://123.57.147.235/index.php/home/resume/resumeList" parameters:pamas success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //成功的回调
        
        int code = [[responseObject objectForKey:@"code"] intValue];
        
        if (code == 1000) {
            NSArray *dict = [responseObject objectForKey:@"data"];
            NSMutableArray *tempArray = [NSMutableArray array];
            
            for (NSDictionary *dictArray in dict) {
                
                PXRuname *Runame = [PXRuname objectWithKeyValues:dictArray];
                
                [tempArray addObject:Runame];
            }
            
            [self.dataArray addObjectsFromArray:tempArray];
            
            [self.tableView reloadData];
            
            NSLog(@"简历列表成功==>%@",responseObject);
            
            [self.tableView.footer endRefreshing];
        }else {
            
            self.pageNumber -= 1;
            
            [self.tableView.footer noticeNoMoreData];
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //失败的回调
        
        NSLog(@"简历列表失败==>%@",error);
        
        self.pageNumber -= 1;
        
        [self.tableView.footer noticeNoMoreData];
    }];
    
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
