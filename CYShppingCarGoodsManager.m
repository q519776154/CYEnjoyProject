//
//  CYShppingCarGoodsManager.m
//  CYEnjoyProject
//
//  Created by qianfeng on 16/9/30.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "CYShppingCarGoodsManager.h"
#import "CYShoppingCarGoods.h"
@interface CYShppingCarGoodsManager ()

@property (nonatomic,strong) NSMutableArray *shoppingCarGoodsArray;

@end

@implementation CYShppingCarGoodsManager

- (NSMutableArray *)shoppingCarGoodsArray
{
    if (!_shoppingCarGoodsArray) {
        _shoppingCarGoodsArray = [NSMutableArray array];
    }
    return _shoppingCarGoodsArray;
}

+ (instancetype)shareManager
{
    static CYShppingCarGoodsManager *manager = nil;
    if (!manager) {
        manager = [[self alloc]  init];
        
    }
    return manager;
}
#pragma mark - 获取所有的购物车数据

- (NSMutableArray *)queryAllShoppingGoodsInShoppingCar
{
    return self.shoppingCarGoodsArray;
}


@end
