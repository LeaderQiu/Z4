//
//  PXCityViewController.m
//  ZhonglieApp
//
//  Created by 邱思雨 on 15/6/3.
//  Copyright (c) 2015年 PX. All rights reserved.
//

#import "PXCityViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "UIColor+SYExtension.h"
#import "PXDataTools.h"
#import "PXCityGroup.h"

@interface PXCityViewController ()<UITableViewDataSource,UITableViewDelegate>



@end

@implementation PXCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏
    self.navigationController.navigationBarHidden = NO;
    
    self.navigationItem.title = @"选择城市";
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"返回键" highImage:@"返回键" target:self action:@selector(BackClickBtn)];
    

    //创建城市TableView列表
//    self.view.backgroundColor = [UIColor colorWithRGB:0xe3e3e3];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.tableView.rowHeight = 44;
    
    self.tableView.sectionFooterHeight = 0.0;
    
    
    
    
}

//导航栏返回键
-(void)BackClickBtn
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}



#pragma mark - Tableiew数据源
//设置有几组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return [PXDataTools cityGroups].count;
}

//每组有几个cell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    PXCityGroup *group = [PXDataTools cityGroups][section];
    
    return group.cities.count;
}
//
//每个cell的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    static NSString *ID = @"city";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    // 设置城市名称
    PXCityGroup *cityGroup = [PXDataTools cityGroups][indexPath.section];
    cell.textLabel.text = cityGroup.cities[indexPath.row];
    
    return cell;
    
    
    
    
}

#pragma mark - TableView代理

//每个组组名
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    PXCityGroup *cityGroup = [PXDataTools cityGroups][section];
    
    return cityGroup.title;
}


//检索栏
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSArray *titles = [[PXDataTools cityGroups] valueForKeyPath:@"title"];
    
    
    
    return titles;
}



//设置组底部
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    if (section == 0) {
        UIView* view = [[UIView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, 640.0f, 0.0f)];
        view.backgroundColor = [UIColor colorWithRGB:0xe3e3e3];
        
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(18.0,
                                 15.0,
                                 284.0,
                                 24.0);
        label.text = @"所有地区";
        label.font = [UIFont systemFontOfSize:16.0];
        
        [view addSubview:label];
        
        return view;
    }else{
      
  

       
         return nil;
    }

}


//设置底部高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    if (section == 0) {
        return 44;
    }
    return 0;
}


//自定义标头视图
-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    PXCityGroup *cityGroup = [PXDataTools cityGroups][section];
    
    
    NSString *sectionTitle = cityGroup.title;
    
    if (section == 0) {
        UIView* view = [[UIView alloc] initWithFrame: CGRectMake(0.0f, 10.0f, 640.0f, 0.0f)];
        view.backgroundColor = [UIColor colorWithRGB:0xe3e3e3];
        
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(18.0,
                                 15.0,
                                 284.0,
                                 24.0);
        label.text = @"推荐地区";
        label.font = [UIFont systemFontOfSize:18.0];
        
        [view addSubview:label];
        
        return view;
    }
    
    
    
    // Create header view and add label as a subview
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10.0,
                                                            0.0,
                                                            320.0,
                                                            100.0)];
    view.backgroundColor = [UIColor whiteColor];
    
    
    // Create label with section title
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(20.0,
                             12.0,
                             284.0,
                             24.0);
    label.textColor = [UIColor blueColor];
    label.font = [UIFont systemFontOfSize:16.0];
    label.text = sectionTitle;
//    label.backgroundColor = [UIColor colorWithRGB:0xe3e3e3];
    
    [view addSubview:label];
    
    return view;
    
}


@end
