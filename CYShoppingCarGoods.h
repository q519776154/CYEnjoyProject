//
//  CYShoppingCarGoods.h
//  CYEnjoyProject
//
//  Created by qianfeng on 16/9/30.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "CYExploreModel1.h"

@interface CYShoppingCarGoods : CYExploreModel1

/**
 *  商品数量
 */
@property (nonatomic, assign) NSInteger number;

/**
 *  判断购物车的商品是否选中
 */
@property (nonatomic, assign, getter=isSelected) BOOL selected;


@end
