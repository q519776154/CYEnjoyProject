//
//  CYNationViewController.m
//  CYEnjoyProject
//
//  Created by qianfeng on 16/9/25.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "CYNationViewController.h"
#import "CYLocalViewController.h"
#import "CYConfig.h"
#import "AFNetworking.h"
#import "CYLocalSelectModel.h"
#import "CYORGANIZEDModel.h"
#import "CYButtonTableViewCell.h"
#import "CYTAGPlusTableViewCell.h"
#import "CYTAGTableViewCell.h"
#import "CYORGANIZEDTableViewCell.h"
#import "CYLimitBuyTableViewCell.h"


@interface CYNationViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *tbView;
@property (nonatomic, strong) NSMutableArray *sectionArr;

@end

@implementation CYNationViewController

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
        [tb registerClass:[CYTAGPlusTableViewCell class] forCellReuseIdentifier:@"CYTAGPlusTableViewCell"];
        [tb registerClass:[CYButtonTableViewCell class] forCellReuseIdentifier:@"CYButtonTableViewCell"];
        [tb registerClass:[CYLimitBuyTableViewCell class] forCellReuseIdentifier:@"CYLimitBuyTableViewCell"];
        [tb registerClass:[CYTAGTableViewCell class] forCellReuseIdentifier:@"CYTAGTableViewCell"];
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
    [manager GET:KQuanguogouInterface parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
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
        if (model.style.integerValue == 7 || model.style.intValue == 3) {
            model.title = dic[@"data"][@"title"];
            model.enjoy_url = dic[@"data"][@"enjoy_url"];
            model.bottom = dic[@"data"][@"bottom"];
            model.img_url = dic[@"data"][@"img_url"];
            model.reference = dic[@"data"][@"bottom"];
            for (NSDictionary *dic3 in dic[@"data"][@"list"])
            {
                CYORGANIZEDModel *organizedModel = [CYORGANIZEDModel modelWithDictionary:dic3];
                [model.organizedModelArr addObject:organizedModel];
            }
            [self.sectionArr addObject:model];
        }
        else
        {
            for (NSDictionary *dic1 in dic[@"data"][@"list"])
            {
                CYORGANIZEDModel *organizedModel = [CYORGANIZEDModel modelWithDictionary:dic1];
                
                if (model.style.intValue == 9 && ![self productIsOnSaleWith:organizedModel])
                {
                    //当售卖时间超出时, 不加入数据源
                }
                else
                {
                    [model.organizedModelArr addObject:organizedModel];
                }
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
    if (model.style.integerValue == 1) {
        CYORGANIZEDTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYORGANIZEDTableViewCell"];
        cell.organizedModelArr = model.organizedModelArr;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if (model.style.integerValue == 7)
    {
        CYTAGPlusTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYTAGPlusTableViewCell"];
        cell.selectModel = model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if (model.style.integerValue == 9)
    {
        CYLimitBuyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYLimitBuyTableViewCell"];
        cell.organizedModelArr = model.organizedModelArr;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if (model.style.integerValue == 10) {
        CYButtonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYButtonTableViewCell"];
        cell.organizedModelArr = model.organizedModelArr;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if (model.style.integerValue == 3)
    {
        CYTAGTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYTAGTableViewCell"];
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

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
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
    else if (model.style.integerValue == 7)
    {
        return 155 + 60 + kScreenW*334/600;
    }
    else if (model.style.integerValue == 3)
    {
        return 360;
    }
    return 220;
}


@end
