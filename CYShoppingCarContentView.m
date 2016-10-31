//
//  CYShoppingCarContentView.m
//  CYEnjoyProject
//
//  Created by qianfeng on 16/9/30.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "CYShoppingCarContentView.h"
#import "CYShoppingCarGoods.h"
#import "CYShoppingCarTableViewCell.h"

@interface CYShoppingCarContentView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,weak) UITableView *cyshoppingCarTableView;

@end

@implementation CYShoppingCarContentView

- (UITableView *)cyshoppingCarTableView
{
    if (!_cyshoppingCarTableView) {
        UITableView *tb = [[UITableView alloc] init];
        tb.delegate = self;
        tb.dataSource = self;
        tb.rowHeight = 90;
        [self addSubview:tb];
        [tb registerNib:[UINib nibWithNibName:@"CYShoppingCarTableViewCell" bundle:nil] forCellReuseIdentifier:@"CYShoppingCarTableViewCell"];
        _cyshoppingCarTableView = tb;
        
    }
    return _cyshoppingCarTableView;
}

- (void)setShoppingCarArray:(NSArray *)shoppingCarArray
{
    _shoppingCarArray = shoppingCarArray;
    [self.cyshoppingCarTableView reloadData];
}
- (void)reloadData
{
    [self.cyshoppingCarTableView reloadData];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.cyshoppingCarTableView.frame = self.bounds;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.shoppingCarArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CYShoppingCarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYShoppingCarTableViewCell"];
    
    //设置点击选择按钮的回调
    [cell setCYShoppingCarCellRefreshCallBack:^{
        //刷新指定行
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }];
    
    //赋值
    CYShoppingCarGoods *goods = self.shoppingCarArray[indexPath.row];
    cell.shoppingCarGoods = goods;
    
    
    return cell;
}



@end











