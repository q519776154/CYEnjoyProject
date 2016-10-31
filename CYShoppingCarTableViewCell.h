//
//  CYShoppingCarTableViewCell.h
//  CYEnjoyProject
//
//  Created by qianfeng on 16/9/30.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYShoppingCarGoods.h"

/**
 *  刷新tableView回调
 */
typedef void(^CYShoppingCarCellRefreshCallBack)(void);

@interface CYShoppingCarTableViewCell : UITableViewCell

/**
 *  商品
 */
@property (nonatomic, strong) CYShoppingCarGoods *shoppingCarGoods;

/**
 *  设置点击选择按钮的回调
 *
 *  @param callback <#callback description#>
 */
- (void)setCYShoppingCarCellRefreshCallBack:(CYShoppingCarCellRefreshCallBack)callback;

@end
