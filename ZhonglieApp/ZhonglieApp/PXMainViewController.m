//
//  PXMainViewController.m
//  ZhonglieApp
//
//  Created by 邱思雨 on 15/5/25.
//  Copyright (c) 2015年 PX. All rights reserved.
//

#import "PXMainViewController.h"
#import "PXMainCell.h"
#import "PXSearchViewController.h"
#import "PXCityViewController.h"
#import "PXSearchHistoryCell.h"
#import "PXSearchCell.h"
#import "PXDetailViewController.h"
#import "AFNetworking.h"
#import "PXZhiWei.h"
#import "MJExtension.h"
#import "Masonry.h"
#import "UIColor+SYExtension.h"
#import "PXSearchLabel.h"
#import "PXSearchHistoryCell.h"

#import <CoreLocation/CoreLocation.h>


@interface PXMainViewController () <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,CLLocationManagerDelegate>
@property(nonatomic,strong) UIImageView *LogoImageV;
@property(nonatomic,strong) UIImage *LogoImage;

@property(nonatomic,strong) UITableViewCell *MainTableViewCell;
@property(nonatomic,strong) UISearchBar *searchBar;
@property(nonatomic,strong) UITextField *TextField;
@property(nonatomic,strong) UIImageView *Searchimage;

@property(nonatomic,strong) UIImageView *headerV;

@property(nonatomic,strong) UITableView *SearchHistory;
@property(nonatomic,strong) UITableView *MainTableV;

@property(nonatomic,strong) NSArray *SearchText2;


/**存放的职位列表模型数组*/
@property(nonatomic,strong) NSMutableArray *dataArray;

/**存放的热搜title模型数组*/
@property(nonatomic,strong) NSMutableArray *dataArray1;

//定位相关
@property(nonatomic,strong) CLLocationManager *mgr;

@property(nonatomic,strong) NSString *myLatitude;
@property(nonatomic,strong) NSString *myLongitude;
@end

@implementation PXMainViewController

//在页面出现前进行地理定位
-(void)viewWillAppear:(BOOL)animated
{
    [self setupDingWei];
    
    self.navigationController.navigationBarHidden = YES;

}
//地理定位
-(void)setupDingWei
{
    //0,请求用户的许可
    if ([self.mgr respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.mgr requestAlwaysAuthorization];
    }
    
    //1,开始定位
    [self.mgr startUpdatingLocation];
}
#pragma mark - 懒加载mgr
-(CLLocationManager *)mgr
{
    if (_mgr == nil) {
        
        //1,创建CLLocationManager
        self.mgr = [[CLLocationManager alloc]init];
        
        //2,设置代理
        self.mgr.delegate = self;
        
        //3，设置精确度
        self.mgr.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
        
        //4,设置用户走了多少米之后重新获取位置
        //        self.mgr.distanceFilter = 20;
    }
    return _mgr;
}


#pragma mark - 代理方法

/**
 *  当获取到用户的位置时会来到该代理方法
 *
 *  @param manager   <#manager description#>
 *  @param locations 这个数组里存放这用户的位置信息
 */
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    //1，从数组中取出用户的位置信息
    CLLocation *location = [locations lastObject];
    
    //2,拿到用户的经纬度
    CLLocationCoordinate2D coordinate = location.coordinate;
    
    //    self.myLatitude = coordinate.latitude;
    //    self.myLongitude = &(coordinate.longitude);
    
    //    NSLog(@"用户当前位置：%f  %f",self.myLatitude,self.myLongitude);
    
    NSLog(@"用户当前位置：%f  %f",coordinate.latitude,coordinate.longitude);
    
    //3,停止获取
    [self.mgr stopUpdatingLocation];
    
    //4,反地理编码
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    
    CLLocation *location1 = [[CLLocation alloc]initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    
    [geocoder reverseGeocodeLocation:location1 completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (placemarks.count == 0 || error ) return ;
        
        for (CLPlacemark *pm in placemarks) {
            
            NSLog(@"%@",pm.locality);
        }
        
    }];
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationController.navigationBarHidden = YES;

    self.navigationController.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image: [UIImage imageNamed:@"众猎"]selectedImage:[UIImage imageNamed:@"众猎-hover"]];
    
    self.navigationController.tabBarItem.title= @"众猎";
  
    [self setupHeaderView];
    
    //创建首页岗位列表tableView
    UITableView *MainTableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 170, [UIScreen mainScreen].bounds.size.width, 550)];
    
    //设置tableView数据源代理
    MainTableV.dataSource = self;
    MainTableV.delegate = self;
     _MainTableV = MainTableV;
    
    [self.view addSubview:MainTableV];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回键"] style:UIBarButtonItemStyleDone target:nil action:nil];
    
    UITableView *SearchHistory = [[UITableView alloc]initWithFrame:CGRectMake(0,170 ,self.view.bounds.size.width, 10)];
    _SearchHistory = SearchHistory;

    //网络请求职位数据
    [self setupHTTPData];
    
    //网络请求热搜数据
    [self setupNetText];
    
    //网络请求文字搜索
    [self setupSearch];
    
    //网络请求-职位详情
    [self setuppositionContent];
    
    //网络接口测试
    [self setupText];
    
    //网络测试简历Add
    [self setupAdd];
    
    //网络测试order接口
    [self setupOrder];
    
    //网络测试orderList
    [self setupOrderList];
    
    
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

- (NSMutableArray *)dataArray1 {
    
    if (_dataArray1 == nil) {
        _dataArray1 = [[NSMutableArray alloc] init];
    }
    return _dataArray1;
}

//网络测试-职位详情
-(void)setuppositionContent
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *pamas = @{@"pid":@"1"};
    
    [mgr POST:@"http://123.57.147.235/index.php/home/position/positionContent" parameters:pamas success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
        
        NSLog(@"职位详情成功==》%@",responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        NSLog(@"职位详情失败==>%@",error);
    }];
}



//网络测试orderAdd接口
-(void)setupOrder
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *pamas = @{@"order_data":@{@"uid":@"1",
                                            @"hid":@"1",
                                            @"position_id":@"1",
                                            @"resume_id":@"31",
                                            @"position_created_time":@"2015.07.07",
                                            @"position_reward":@"15000",
                                            @"position_title":@"12",
                                            @"position_salary":@"2000",
                                            @"resume_name":@"Add小明",
                                            @"resume_title":@"Add产品",
                                    },
                            
                            
                            };
    
    
    [mgr POST:@"http://123.57.147.235/index.php/home/order/orderAdd" parameters:pamas success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
        
        NSLog(@"order测试成功==》%@",responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        NSLog(@"order测试失败==>%@",error);
    }];
}

//网络请求orderList
-(void)setupOrderList
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *pamas = @{@"uid":@"2",
                            @"order_time":@"0",
                            @"order_status":@"0",
                            @"order_reward":@"0",
                            @"page":@"0"
                            };
    
    [mgr POST:@"http://123.57.147.235/index.php/home/order/orderList" parameters:pamas success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
        
        NSLog(@"已推荐筛选成功==》%@",responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        NSLog(@"已推荐筛选失败==>%@",error);
    }];
}
//网络接口测试Add
-(void)setupAdd
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *pamas = @{
                            @"resume_data":@{@"title":@"Add产品",
                                             @"name":@"Add小明",
                                             @"sex":@"1",
                                             @"age":@"18",
                                             @"mobile":@"120",
                                             @"school":@"北大",
                                             @"professional":@"软件工程",
                                             @"edu":@"2",
                                             @"uid":@"1"
                                             
                                             },
                            @"company1":@{@"company_name":@"普信科技",
                                          @"duty":@"技术总监",
                                          @"time":@"2年",
                                          @"assess":@"哈哈哈哈哈哈哈"
                                          
                                          }
                            };
    
    
    [mgr POST:@"http://123.57.147.235/index.php/home/resume/resumeAdd" parameters:pamas success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
        
        NSLog(@"add测试成功==》%@",responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        NSLog(@"add测试失败==>%@",error);
    }];
}


//网络接口测试
-(void)setupText
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *pamas = @{@"uid":@"1",
                            @"resume_id":@"13",
                            @"resume_data":@{@"title":@"产品",
                                             @"name":@"小明明",
                                             @"sex":@"1",
                                             @"age":@"18",
                                             @"mobile":@"120",
                                             @"school":@"北大",
                                             @"professional":@"软件工程",
                                             @"edu":@"2"
                                    
                                              },
                            @"company1":@{@"company_name":@"普信科技",
                                          @"duty":@"技术总监",
                                          @"time":@"2年",
                                          @"assess":@"哈哈哈哈哈哈哈"
                                    
                                    }
                            };
    
    
    [mgr POST:@"http://123.57.147.235/index.php/home/resume/resumeEditDo" parameters:pamas success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
        
        NSLog(@"接口测试成功==》%@",responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        NSLog(@"接口测试失败==>%@",error);
    }];
}


//网络请求简历列表
-(void)setupSearch
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *pamas = @{@"page":@"0",@"uid":@"1"};
    
    [mgr POST:@"http://123.57.147.235/index.php/home/resume/resumeList" parameters:pamas success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
        
        NSLog(@"简历列表成功==》%@",responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        NSLog(@"简历列表失败==>%@",error);
    }];
    
    
}




//网络请求热搜数据
-(void)setupNetText
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *parameters = @{@"label":@"产品"};
    
    [manager POST:UrlStrPositionSearchLabel parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //成功的回调
        NSLog(@"Label成功的回调==>%@",responseObject);
        
        NSArray *dictArray = [responseObject objectForKey:@"data"];
        NSMutableArray *tempArray = [NSMutableArray array];
        
        for (NSDictionary *dict in dictArray) {
            PXSearchLabel *Label = [PXSearchLabel objectWithKeyValues:dict];
            
            [tempArray addObject:Label];
        }
        
        [self.dataArray1 addObjectsFromArray:tempArray];
        [_SearchHistory reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //失败的回调
        NSLog(@"失败的回调==>%@",error);
        
    }];

}

//网络请求-职位列表
-(void)setupHTTPData
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *parameters = @{@"page":@"0"};
    
    [manager POST:UrlStrPosition parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //成功的回调
        NSLog(@"成功的回调==>%@",responseObject);
        
        NSArray *dictArray = [responseObject objectForKey:@"data"];
        NSMutableArray *tempArray = [NSMutableArray array];
        
        for (NSDictionary *dict in dictArray) {
            
            PXZhiWei *ZhiWei = [PXZhiWei objectWithKeyValues:dict];
            
            [tempArray addObject:ZhiWei];
        }
        
        [self.dataArray addObjectsFromArray:tempArray];
        
        [_MainTableV reloadData];
        
        NSLog(@"<dataArray在这里==>%@",self.dataArray);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //失败的回调
        NSLog(@"失败的回调==>%@",error);
        
    }];
    
    
  
    
    
}
//点击空白收起键盘、收起SearchHistoryView
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.TextField resignFirstResponder];
    
    self.SearchHistory.hidden = YES;
}


#pragma mark - 加载头部

-(void)setupHeaderView
{
    //创建头部招牌View
    UIView *headerV = [UIView new];
    
    headerV.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:headerV];
 

    
    //设置头部招牌背景图
    UIImageView *headerImageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"首页背景图"]];
    
    [headerV addSubview:headerImageV];
    

    
    //添加Logo
    UIImageView *LogoImageV = [UIImageView new];
    
    LogoImageV.image =[UIImage imageNamed:@"Logo"];
    
    [headerImageV addSubview:LogoImageV];
  
    
    //添加标语
    UIImageView *TextImageV = [UIImageView new];
    
    TextImageV.image = [UIImage imageNamed:@"标语"];
    
    [headerImageV addSubview:TextImageV];
  

     //添加TextFiel
    UITextField *TextField = [UITextField new];
    
    _TextField = TextField;
    
    [self setupTextFiel];
    
    [headerV addSubview:TextField];
  
    //创建地区按钮
    UIButton *CityButton = [UIButton new];

    
    [CityButton addTarget:self action:@selector(btnClickAction) forControlEvents:UIControlEventTouchUpInside];
    
    [headerV addSubview:CityButton];
    
    
    UILabel *CityLabel = [UILabel new];
    
    CityLabel.text = @"北京";
    
    CityLabel.textColor = [UIColor whiteColor];
    
    [CityButton addSubview:CityLabel];
    
    [CityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CityButton);
        make.top.equalTo(CityButton.mas_top).offset(10);
    }];
    
    UIImageView *ImageV = [UIImageView new];
    
    [ImageV setImage:[UIImage imageNamed:@"下三角白"]];
    
    [CityButton addSubview:ImageV];
    
    [ImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(CityButton);
        make.centerY.equalTo(CityLabel);
        
    }];
    
    
    
    //约束的参数
    int padding1 = 10;
    int padding2 = 15;
    int padding3 = ([UIScreen mainScreen].bounds.size.width-222)/3;
    int padding4 = ([UIScreen mainScreen].bounds.size.height *(172/568));
#warning TODO -高度
    //headerView约束
    [headerV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.height.mas_equalTo(172);
        make.left.equalTo(self.view);
        make.top.equalTo(self.view);
    }];
    
    //HeaderImage约束
    [headerImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(headerV.mas_width);
        
        
    }];
 
    
    
    //CityButton约束
    [CityButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerV.mas_left).offset(10);
        make.bottom.equalTo(TextField);
        make.size.mas_equalTo(CGSizeMake(50, 32));
        make.centerY.equalTo(TextField).offset(-2);
        
    }];
    
    //TextField约束
    [TextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@32);
        make.left.equalTo(CityButton.mas_right).offset(20);
        make.right.equalTo(headerV.mas_right).offset(-padding1);
        make.bottom.equalTo(headerV.mas_bottom).offset(-padding2);
    }];
    
    //标语约束
    [TextImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(158, 45));
        make.bottom.equalTo(TextField.mas_top).offset(-20);
        make.right.equalTo(headerV).offset(-padding3);
    }];
    
    
    //Logo约束
    [LogoImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(64, 63));
        make.bottom.equalTo(TextField.mas_top).offset(-20);
        make.left.equalTo(headerV).offset(padding3);
    }];
   
}

//城市选择
-(void)btnClickAction
{
    PXCityViewController *CityVC = [[PXCityViewController alloc]initWithStyle:UITableViewStyleGrouped];
    
    [self.navigationController pushViewController:CityVC animated:YES];
}

//隐藏状态栏
-(BOOL)prefersStatusBarHidden
{
    return YES;
}

////跳转回来的页面再次隐藏状态栏
//-(void)viewWillAppear:(BOOL)animated
//{
//    self.navigationController.navigationBarHidden = YES;
//}


//设置TextField细节
-(void)setupTextFiel
{
   
    self.TextField.borderStyle = UITextBorderStyleNone;
    self.TextField.keyboardType = UIKeyboardTypeDefault;
    self.TextField.delegate = self;
    
    self.TextField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.TextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.TextField.returnKeyType = UIReturnKeySearch;
    
    self.TextField.background = [UIImage imageNamed:@"searchBarBack"];
    
    
    UIImageView *Searchimage=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"查找职位白"]];
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
    
    [self setupSearchHistory];
    
}

//点击键盘搜索键，收回键盘.***跳转页面****
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    //获取用户输入的内容
    
    NSString *SearchText = [textField text];
    
    
    _SearchText =SearchText;

    
    NSLog(@"用户输入******%@",SearchText);
    
    [[NSUserDefaults standardUserDefaults]setObject:SearchText forKey:@"textFieldKey"];
    

  
    
    
    
    
    
    //隐藏搜索历史
    self.SearchHistory.hidden = YES;
    

    
    [textField resignFirstResponder];
    
    textField.text = @" ";
    
    PXSearchViewController *SearchVC = [[PXSearchViewController alloc] init] ;
    
//    [self presentViewController:SearchVC animated:YES completion:nil];
    
    [self.navigationController pushViewController:SearchVC animated:YES];
    
    
   
    
    return YES;
    
}

//加载搜索历史
-(void)setupSearchHistory
{
    UITableView *SearchHistory = [[UITableView alloc]initWithFrame:CGRectMake(0,170 ,self.view.bounds.size.width, 250)];
    _SearchHistory = SearchHistory;
    
    SearchHistory.delegate = self;
    SearchHistory.dataSource = self;
    
    
    SearchHistory.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:SearchHistory];
    
    self.SearchHistory.hidden = NO;
}



//结束编辑时显示查找职位图片
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.SearchHistory.hidden = YES;
    self.TextField.leftViewMode = UITextFieldViewModeUnlessEditing;
    
    
    
}

#pragma mark - TableView数据源

//cell个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ([tableView isEqual:_MainTableV]) {
        return _dataArray.count;
    }else if ([tableView isEqual:self.SearchHistory]){
        return 5;
    }
    return 10;
}

//自定义Cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([tableView isEqual:_SearchHistory]) {
        
        if (indexPath.row == 1) {
     
            static NSString *searchHistoryID = @"searchHistoryCell";
            
            PXSearchHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:searchHistoryID];
            
            if (cell == nil) {
                
                cell = [[PXSearchHistoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:searchHistoryID];
            }
            
            cell.searchLabels = self.dataArray1;
            
            return cell;
        } else {
            if (indexPath.row == 0) {
                static NSString *searchID = @"searchCell";
                
                PXSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:searchID];
                
                if (cell == nil) {
                    
                    cell = [[PXSearchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:searchID];
                }
                
                cell.model = @"热门搜索";
                
                return cell;
            }
            if (indexPath.row == 2) {
                static NSString *searchID = @"searchCell";
                
                PXSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:searchID];
                
                if (cell == nil) {
                    
                    cell = [[PXSearchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:searchID];
                }
                
                cell.model = @"搜索历史";
                
                return cell;
            }
            if (indexPath.row == 3) {
                static NSString *searchID = @"searchCell";
                
                PXSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:searchID];
                
                if (cell == nil) {
                    
                    cell = [[PXSearchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:searchID];
                }
                
                
                cell.model = [[NSUserDefaults standardUserDefaults] objectForKey:@"textFieldKey"];
                
                return cell;
            }

            
            static NSString *searchID = @"searchCell";
            
            PXSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:searchID];
            
            if (cell == nil) {
                
                cell = [[PXSearchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:searchID];
            }
            
            cell.model = @" ";
            
            return cell;
        }
        
    } else {
        
        static NSString *mainID = @"PXMainCell";
        
        PXMainCell *cell = [tableView dequeueReusableCellWithIdentifier:mainID];
        
        PXZhiWei *zhiWei = self.dataArray[indexPath.row];
        
        if (cell == nil) {
            cell = [[PXMainCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mainID];
        }
        
        cell.zhiWei = zhiWei;
        
        return cell;
    }
    
    
    

    
}

    
    
    



#pragma mark - TableView代理方法

//点击cell事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:_MainTableV]) {
        PXDetailViewController *DetailVC = [[PXDetailViewController alloc]initWithStyle:UITableViewStyleGrouped];
        
        [self.navigationController pushViewController:DetailVC animated:YES];
        
        NSLog(@"%zd", indexPath.row);

    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 96.0;
}

//cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([tableView isEqual:self.SearchHistory]) {
        if(indexPath.row == 1){
            return 100;
        }else{
            return 48.0;
        }
        
    }
    
    return 96.0;
}



@end
