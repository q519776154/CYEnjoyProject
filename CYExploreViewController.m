//
//  CYExploreViewController.m
//  CYEnjoyProject
//
//  Created by qianfeng on 16/9/24.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "CYExploreViewController.h"
#import "CYExploreCell.h"
#import "CYExploreModel.h"
#import "AFNetworking.h"
#import "HttpRequest.h"
#import "CYConfig.h"
#import "CYExploreCell2.h"
#import "CYExploreCell3.h"

@interface CYExploreViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,weak) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataSource;

@property (nonatomic,strong) NSMutableArray *modelArr;


@end

@implementation CYExploreViewController

#pragma mark - 懒加载
- (UITableView *)tableView
{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        
        tableView.backgroundColor = kColor(246,246,246);
    
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [tableView registerNib:[UINib nibWithNibName:@"CYExploreCell3" bundle:nil] forCellReuseIdentifier:@"CYExploreCell3"];
        [tableView registerNib:[UINib nibWithNibName:@"CYExploreCell2" bundle:nil] forCellReuseIdentifier:@"CYExploreCell2"];
        [tableView registerNib:[UINib nibWithNibName:@"CYExploreCell" bundle:nil] forCellReuseIdentifier:@"CYExploreCell"];
        
        [self.view addSubview:tableView];
        
        _tableView = tableView;
    }
    return _tableView;
}

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

#pragma mark - 初始化initSearchBar

- (void)initSearchBar
{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 60, 30)];
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, titleView.frame.size.width - 30, 30)];
    searchBar.center = titleView.center;
    
    searchBar.layer.borderWidth = 0.5;
    searchBar.layer.cornerRadius = 5;
    searchBar.clipsToBounds = YES;
    searchBar.layer.borderColor = [UIColor lightGrayColor].CGColor;
    searchBar.placeholder = @"请输入商品名、商家、商圈、分类";
    [titleView addSubview:searchBar];
    self.navigationItem.titleView = titleView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
     [self initSearchBar];
    
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusReachableViaWWAN) {
            [self requestDataFromNetworking];
        }
        else
        {
            [self requestDataFromNetworking];
        }
    }];
    [manager startMonitoring];
  
}

- (void)requestDataFromNetworking
{
    [HttpRequest GET:[NSString stringWithFormat:@"https://open.seriousapps.cn/hub/tab/content_list.json?city_id=1&module_id=2&page=0"] paramters:nil success:^(id responseObject) {
        
        [self handleDataObjectWithResponseObject:responseObject];
        
    } failure:^(NSError *error) {
        
        
    }];

}

- (void)handleDataObjectWithResponseObject:(id)responseObject
{
    NSArray *arr = responseObject;
    [arr enumerateObjectsUsingBlock:^(NSDictionary* dic, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == 0)
        {
            CYExploreModel *cyeModel =[CYExploreModel modelWithDictionary:dic];
            cyeModel.title = dic[@"data"][@"title"];
            for (NSDictionary *dic2 in dic[@"data"][@"list"])
            {
                CYExploreModel1 *cyeModel1 = [CYExploreModel1 modelWithDictionary:dic2];
                [cyeModel.cyModel1Arr addObject:cyeModel1];
                
            }
            
            [self.dataSource addObject:cyeModel];

        }
        
        else if (idx == 1)
        {
            CYExploreModel *cyeModel =[CYExploreModel modelWithDictionary:dic];
            
            for (NSDictionary *dic1 in dic[@"data"][@"list"])
            {
                CYExploreModel1 *cyeModel1 = [CYExploreModel1 modelWithDictionary:dic1];
                [cyeModel.cyModel1Arr addObject:cyeModel1];
            }
            
            [self.dataSource addObject:cyeModel];
        }
        else{
            CYExploreModel *cyeModel = [CYExploreModel modelWithDictionary:dic];
            cyeModel.first_pre_icon = dic[@"data"][@"first_pre_icon"];
            cyeModel.icon = dic[@"data"][@"icon"];
            cyeModel.image = dic[@"data"][@"image"];
            cyeModel.title = dic[@"data"][@"title"];

            for (NSDictionary *dic2 in dic[@"data"][@"list"]) {
                CYExploreModel1 *cyeModel1 = [CYExploreModel1 modelWithDictionary:dic2];
                cyeModel1.topImage = cyeModel.first_pre_icon;
                [cyeModel.cyModel1Arr addObject:cyeModel1];
               
                }
             [self.dataSource addObject:cyeModel];
            }
    }];
    
    [self.tableView reloadData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
   
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count ;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 0) {
        CYExploreCell3 *cell3 = [tableView dequeueReusableCellWithIdentifier:@"CYExploreCell3"];
        cell3.selectionStyle = UITableViewCellSelectionStyleNone;
        CYExploreModel *cyModel = self.dataSource[indexPath.section];
        cell3.cyeModel = cyModel;
        return cell3;
    }
    else if (indexPath.section == 1) {
        
        CYExploreCell2 *cell2 = [tableView dequeueReusableCellWithIdentifier:@"CYExploreCell2"];
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;
        CYExploreModel *cyModel = self.dataSource[indexPath.section];
        cell2.cyModel = cyModel;
        return cell2;
        
    }
    else
    {
        CYExploreCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYExploreCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        CYExploreModel *cyModel = self.dataSource[indexPath.section];
        cell.cyModel = cyModel;
        return cell;

    }
    

}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 170;
    }
    else if (indexPath.section == 1)
    {
        return 120;
    }
    else{
        return 520;

    }
}



@end
