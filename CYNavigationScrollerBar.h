//
//  CYNavigationScrollerBar.h
//  Enjoy
//
//  Created by qianfeng on 16/9/24.
//  Copyright © 2016年 cz. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickTitleButtonCallBack)(NSInteger index);

@interface CYNavigationScrollerBar : UIScrollView

@property (nonatomic) CGFloat bottomLineHeight;
@property (nonatomic) CGFloat bottomLineWidth;
@property (nonatomic) CGFloat titleFont;
@property (nonatomic) CGFloat buttonSpace;
@property (nonatomic) UIColor* bottomLineColor;
@property (nonatomic) UIColor* titleNormalColor;
@property (nonatomic) UIColor* titleSelectedColor;

@property (nonatomic, copy) ClickTitleButtonCallBack callBack;

//点击的回调 用来切换子控制器
+ (instancetype)NavigationScrollerBarWithTitles:(NSArray *)titles completeWithCallBack:(ClickTitleButtonCallBack)callBack;

- (void)clickNavigationButtonFromIndex:(NSInteger)index;

@end
