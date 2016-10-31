//
//  CYShoppingCarBottomView.h
//  CYEnjoyProject
//
//  Created by qianfeng on 16/9/30.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
//点击全选回调
typedef void(^CYShoppingCarBottomViewDidClickSelectAllButtonCallBack)(BOOL selectAll);

#define kBottomViewHeight 60;

@interface CYShoppingCarBottomView : UIView

//总价格
@property (nonatomic,assign) CGFloat totalPrice;

//初始化
+ (instancetype)shoppingCarBottomViewWithFrame:(CGRect)frame;

//设置全选回调
- (void)setCYShoppingCarBottomViewDidClickSelectAllButtonCallBack:(CYShoppingCarBottomViewDidClickSelectAllButtonCallBack)callback;




@end
