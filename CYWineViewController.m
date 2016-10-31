//
//  CYWineViewController.m
//  CYEnjoyProject
//
//  Created by qianfeng on 16/9/25.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "CYWineViewController.h"
#import "CYConfig.h"
#import "AFNetworking.h"
#import "CYLocalSelectModel.h"
#import "CYORGANIZEDModel.h"
#import "CYButtonTableViewCell.h"
#import "CYButtonCollectionViewCell.h"
#import "CYORGANIZEDTableViewCell.h"
#import "CYRoundButtonTableViewCell.h"
#import "CYManualTableViewCell.h"
#import "CYSelectTableViewCell.h"
#import "CYRecommendTableViewCell.h"

@interface CYWineViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *tbView;
@property (nonatomic, strong) NSMutableArray *sectionArr;

@end

@implementation CYWineViewController

#pragma mark - 懒加载

- (NSMutableArray *)sectionArr
{
    if (!_sectionArr) {
        _sectionArr = [NSMutableArray array];
    }
    return _sectionArr;
}
- (UITableView *)tbView
{
    if (!_tbView) {
        UITableView *tb = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        tb.delegate = self;
        tb.dataSource = self;
        tb.backgroundColor = kColor(246,246,246);
        
        [tb registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [self.view addSubview:tb];
        [tb registerClass:[CYORGANIZEDTableViewCell class] forCellReuseIdentifier:@"CYORGANIZEDTableViewCell"];
        [tb registerClass:[CYRoundButtonTableViewCell class] forCellReuseIdentifier:@"CYRoundButtonTableViewCell"];
        [tb registerClass:[CYButtonTableViewCell class] forCellReuseIdentifier:@"CYButtonTableViewCell"];
        [tb registerClass:[CYManualTableViewCell class] forCellReuseIdentifier:@"CYManualTableViewCell"];
        [tb registerClass:[CYSelectTableViewCell class] forCellReuseIdentifier:@"CYSelectTableViewCell"];
        [tb registerClass:[CYRecommendTableViewCell class] forCellReuseIdentifier:@"CYRecommendTableViewCell"];
        
        _tbView = tb;
    }
    return _tbView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.translucent = NO;
    
    //判断有无网络TODO::::
    [self requestDataFromNetworking];
    
}


#pragma mark - 请求网络数据
- (void)requestDataFromNetworking
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"https://open.seriousapps.cn/4/tab/home_page.json?city_id=299&lat=22.58001141142362&lng=113.9617132768605&page=0&tab_id=1001" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        //页面刷新进度TODO::::
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleDataObjectWithReponseObject:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败");
        //失败的页面显示 TODO:::::
    }];
}

#pragma mark - 封装网络数据
- (void)handleDataObjectWithReponseObject:(id)responseObject
{
    NSArray *responseArr = responseObject;
    for (NSDictionary *dic in responseArr)
    {
        CYLocalSelectModel *model = [CYLocalSelectModel modelWithDictionary:dic];
        if (model.style.integerValue == 19) {
            model.title = dic[@"data"][@"title"];
            model.img_title = dic[@"data"][@"img_title"];
            model.img_info_list = dic[@"data"][@"img_info_list"];
            model.small_icon_list = dic[@"data"][@"small_icon_list"];
            for (NSDictionary *dic3 in dic[@"data"][@"small_icon_list"])
            {
                CYORGANIZEDModel *organizedModel = [CYORGANIZEDModel modelWithDictionary:dic3];
                [model.organizedModelArr addObject:organizedModel];
            }
            for (NSDictionary *dic4 in dic[@"data"][@"img_info_list"])
            {
                CYORGANIZEDModel *organizedModel = [CYORGANIZEDModel modelWithDictionary:dic4];
                [model.organizedModelArr addObject:organizedModel];
            }
            [self.sectionArr addObject:model];
        }

        else
        {
            if (model.style.integerValue == 15)
            {
                for (NSString *str in dic[@"data"][@"text"])
                {
                    [model.text addObject:str];
                }
            }
            for (NSDictionary *dic1 in dic[@"data"][@"list"])
            {
                CYORGANIZEDModel *organizedModel = [CYORGANIZEDModel modelWithDictionary:dic1];
                [model.organizedModelArr addObject:organizedModel];
            }
            [self.sectionArr addObject:model];
        }
        
    }
    [self.tbView reloadData];
}

- (BOOL)productIsOnSaleWith:(CYORGANIZEDModel *)organizedModel
{
    NSTimeInterval currentTime = [[NSDate dateWithTimeIntervalSinceNow:0] timeIntervalSince1970] *1000;
    NSTimeInterval endTime = organizedModel.sell_end_time.doubleValue;
    
    return currentTime < endTime;
}

#pragma mark - CYORGANIZEDModel *organizedModel/dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sectionArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CYLocalSelectModel *model = self.sectionArr[indexPath.section];
    if (model.style.integerValue == 1)
    {
        CYORGANIZEDTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYORGANIZEDTableViewCell"];
        cell.organizedModelArr = model.organizedModelArr;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if (model.style.integerValue == 17)
    {
        CYRoundButtonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYRoundButtonTableViewCell"];
        cell.selectModel = model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if (model.style.integerValue == 18)
    {
        CYManualTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYManualTableViewCell"];
        cell.organizedModelArr = model.organizedModelArr;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if (model.style.integerValue == 19)
    {
        CYSelectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYSelectTableViewCell"];
        cell.selectModel = model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if (model.style.integerValue == 10)
    {
        CYButtonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYButtonTableViewCell"];
        cell.organizedModelArr = model.organizedModelArr;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if (model.style.integerValue == 15)
    {
        CYRecommendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYRecommendTableViewCell"];
        cell.selectModel = model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        cell.textLabel.text = [NSString stringWithFormat:@"%d", arc4random()%50];
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 5)];
        view.backgroundColor = [UIColor whiteColor];
        return view;
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 5)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CYLocalSelectModel *model = self.sectionArr[indexPath.section];
    if (model.style.integerValue == 1) {
        return kScreenW*334/600;
    }
    else if (model.style.integerValue == 10)
    {
        return kScreenW/2 + 10;
    }
    else if (model.style.integerValue == 17)
    {
        return (kScreenW - 40)/3.5 + 50;
    }
    else if (model.style.integerValue == 15)
    {
        return 380;
    }
    else if (model.style.integerValue == 19)
    {
//        NSLog(@"%f", model.cellHeight);
        return model.cellHeight;
        
    }

    return 220;
}


@end
