//
//  CYShppingCarGoodsManager.h
//  CYEnjoyProject
//
//  Created by qianfeng on 16/9/30.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CYShoppingCarGoods.h"

@interface CYShppingCarGoodsManager : NSObject

+ (instancetype)shareManager;

/**
 *添加数据
 */
//- (void)insertGoodsInShoppingCarWithShoppingCar:(CYShoppingCarGoods *)shoppingCar;

/**
 * 获取购物车数据
 */
- (NSMutableArray *)queryAllShoppingGoodsInShoppingCar;

/*
 购物车商品总价格
 */
//- (float)totalPriceInShoppingCar;
/**
 *  全选
 */
//- (void)selectAllShoppingCarGoods;

/**
 *  取消全选
 */
//- (void)unSelectAllShoppingCarGoods;




@end
