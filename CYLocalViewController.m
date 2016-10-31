//
//  CYLocalViewController.m
//  CYEnjoyProject
//
//  Created by qianfeng on 16/9/25.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "CYLocalViewController.h"
#import "CYConfig.h"
#import "AFNetworking.h"
#import "CYLocalSelectModel.h"
#import "CYORGANIZEDModel.h"
#import "CYOrganizedTableViewCell.h"
#import "CYPERIODTableViewCell.h"
#import "CYTAGTableViewCell.h"
#import "CYLIMITTableViewCell.h"

@interface CYLocalViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *tbView;
@property (nonatomic, strong) NSMutableArray *sectionArr;

@end

@implementation CYLocalViewController

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
        [tb registerClass:[CYPERIODTableViewCell class] forCellReuseIdentifier:@"CYPERIODTableViewCell"];
        [tb registerClass:[CYTAGTableViewCell class] forCellReuseIdentifier:@"CYTAGTableViewCell"];
        [tb registerClass:[CYLIMITTableViewCell class] forCellReuseIdentifier:@"CYLIMITTableViewCell"];
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
    [manager GET:KShenzhenInterface parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
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
        
    if (model.style.integerValue == 3) {
                model.title = dic[@"data"][@"title"];
                model.enjoy_url = dic[@"data"][@"enjoy_url"];
//            NSLog(@"%ld----",model.style.integerValue);
                for (NSDictionary *dic3 in dic[@"data"][@"list"]) {
                    CYORGANIZEDModel *organizedModel = [CYORGANIZEDModel modelWithDictionary:dic3];
                    [model.organizedModelArr addObject:organizedModel];
                }
                [self.sectionArr addObject:model];
            }
        
        else
        {
//            NSLog(@"%ld",model.style.integerValue);
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


#pragma mark - tableViewDelegata/dataSource
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
    else if (model.style.integerValue == 3)
    {
        CYTAGTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYTAGTableViewCell"];
        cell.selectModel = model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if ([model.item_type isEqualToString:@"PERIOD"] || model.style.integerValue == 13)
    {
        CYPERIODTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYPERIODTableViewCell"];
        cell.organizedModelArr = model.organizedModelArr;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if (model.style.integerValue == 14) {
        CYLIMITTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYLIMITTableViewCell"];
        cell.organizedModelArr = model.organizedModelArr;
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
        return 200;
    }
    else if ([model.item_type isEqualToString:@"PERIOD"])
    {
        return 100;
    }
    else if (model.style.integerValue == 14)
    {
        return 130;
    }
    return 360;
}


@end
