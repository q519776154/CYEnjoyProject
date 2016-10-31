//
//  CYMyViewController.m
//  CYEnjoyProject
//
//  Created by qianfeng on 16/9/24.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "CYMyViewController.h"
#import "CYMyFirstTableViewCell.h"
#import "CYMySecondTableViewCell.h"
#import "CYConfig.h"
#import "CYMessageCenterViewController.h"
#import "CYACCOUNTSetViewController.h"
#import "CYAccountTableViewCell.h"
#import "CYMoreSetViewController.h"
#import "CYShareTicketViewController.h"
#import "CYMyTicketViewController.h"

@interface CYMyViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_textArr;
}
@property (nonatomic,weak) UIImageView *iconImageView;

@property (nonatomic,weak)UITableView *tableView;

@property (nonatomic) UIView *headerView;

@end

@implementation CYMyViewController
#pragma mark - 懒加载

- (UITableView *)tableView
{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.contentInset = UIEdgeInsetsMake(-5, 0, 0, 0);
        
        tableView.tableHeaderView = self.headerView;
        [self.view addSubview:tableView];
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        
        [tableView registerNib:[UINib nibWithNibName:@"CYMyFirstTableViewCell" bundle:nil] forCellReuseIdentifier:@"first"];
        [tableView registerNib:[UINib nibWithNibName:@"CYMySecondTableViewCell" bundle:nil] forCellReuseIdentifier:@"second"];
        _tableView =tableView;
        [self.tableView reloadData];
    }
    return _tableView;
}

- (UIView *)headerView
{
    if (!_headerView) {
        
        CGFloat headViewWidth = self.view.frame.size.width;
        CGFloat headViewHeight = 200;
        CGFloat backViewWith = 60;
        CGFloat backViewHeight = backViewWith;
        CGFloat labelWidth = 120;
        CGFloat labelHeight = 20;

        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, headViewWidth, headViewHeight)];
        UIImageView *backGroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"share_weibo_comment_avartar_100x100_@1x"]];
        
        backGroundView.clipsToBounds =YES;
        _iconImageView = backGroundView;
        
        UIButton *sendBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 50, 10, 40, 40)];
        [sendBtn setImage:[UIImage imageNamed:@"ic_profile_notification_b_25x18_"] forState:UIControlStateNormal];
        
        [sendBtn addTarget:self action:@selector(enterMessageCenter) forControlEvents:UIControlEventTouchUpInside];
        
        backGroundView.frame = CGRectMake(headViewWidth / 2 - backViewWith / 2 , headViewHeight / 2 - backViewWith / 2, backViewWith, backViewHeight);
        
        backGroundView.layer.cornerRadius = backViewWith / 2;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.view.frame)/2 - labelWidth/2, CGRectGetMaxY(backGroundView.frame) + 10, labelWidth, labelHeight)];
        label.text = @"请设置个性签名";
        label.font = [UIFont systemFontOfSize:14];
        label.alpha = 0.5;
        label.layer.cornerRadius = 5;
        label.layer.borderColor = [UIColor grayColor].CGColor;
        label.layer.borderWidth = 1;
        label.textAlignment = NSTextAlignmentCenter;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(enterAccountSetController)];
        [_headerView addGestureRecognizer:tap];
        [_headerView addSubview:sendBtn];
        [_headerView addSubview:backGroundView];
        [_headerView addSubview:label];
        
        backGroundView.userInteractionEnabled = YES;
        
        
    }
    return _headerView;
}
- (void)enterAccountSetController
{
    CYACCOUNTSetViewController *accountController = [[CYACCOUNTSetViewController alloc] init];
    
    [accountController setHeadImageCallBack:^(UIImage *image) {
        self.iconImageView.image = image;
    }];
    
    [self.navigationController pushViewController:accountController animated:NO];
}

- (void)enterMessageCenter
{
    CYMessageCenterViewController *messageCenterController = [[CYMessageCenterViewController alloc] init];
    [self.navigationController pushViewController:messageCenterController animated:NO];
}

- (void)enterMoreSetController
{
    CYMoreSetViewController *moreSetController = [[CYMoreSetViewController alloc] init];
    [self.navigationController pushViewController:moreSetController animated:NO];
}

- (void)enterShareController
{
    CYShareTicketViewController *shareController = [[CYShareTicketViewController alloc] init];
    [self.navigationController pushViewController:shareController animated:NO];
}
- (void)enterMyTicketController
{
    CYMyTicketViewController *myTicketController = [[CYMyTicketViewController alloc] init];
    [self.navigationController pushViewController:myTicketController animated:NO];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:YES];
    self.view.backgroundColor = kColor(217, 217, 217);
    [self tableView];
    
    _textArr = @[@"分享赢礼券",@"我的礼券",@"我喜欢的礼遇",@"设置",@"用户协议",@"联系我们"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0 || section == 1) {
        return 1;
    }
    else
    {
        return 6;
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        CYMyFirstTableViewCell *firstCell = [tableView dequeueReusableCellWithIdentifier:@"first"];
        if (!firstCell) {
            firstCell = [[CYMyFirstTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"first"];
            
        }
        firstCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return firstCell;

    }
    else if (indexPath.section == 1)
    {
        CYMySecondTableViewCell *secondCell = [tableView dequeueReusableCellWithIdentifier:@"second"];
        if (!secondCell) {
            secondCell = [[CYMySecondTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"second"];
           
        }
         secondCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return secondCell;
}
    else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = _textArr[indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        if (indexPath.row == 5) {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        else{
            cell.accessoryType = 1;
        }
        return cell;
    }
    
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    if(indexPath.section == 0)
    {
        return 210;
    }
    else if (indexPath.section == 1)
    {
        return 130;
    }
    else
    {
        return 44;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2 && indexPath.row == 0) {
        [self enterShareController];
    }
    else if (indexPath.section == 2 && indexPath.row == 1) {
        [self enterMyTicketController];
    }
    else if (indexPath.section == 2 && indexPath.row == 3) {
        [self enterMoreSetController];
    }
}



@end
