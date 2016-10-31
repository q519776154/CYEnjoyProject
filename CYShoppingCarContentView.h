//
//  CYShoppingCarContentView.h
//  CYEnjoyProject
//
//  Created by qianfeng on 16/9/30.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYShoppingCarContentView : UIView

//购物车数据
@property (nonatomic,strong)NSArray *shoppingCarArray;

- (void)reloadData;

@end
