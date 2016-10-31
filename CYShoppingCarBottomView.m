//
//  CYShoppingCarBottomView.m
//  CYEnjoyProject
//
//  Created by qianfeng on 16/9/30.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "CYShoppingCarBottomView.h"

@interface CYShoppingCarBottomView ()
{
    CYShoppingCarBottomViewDidClickSelectAllButtonCallBack _shoppingCarBottomViewDidClickSelectAllButtonCallBack;
}

@property (weak, nonatomic, readwrite) IBOutlet UILabel *totalPriceLabel;



@end

@implementation CYShoppingCarBottomView

+ (instancetype)shoppingCarBottomViewWithFrame:(CGRect)frame
{
    CYShoppingCarBottomView *bottomView = [[NSBundle mainBundle] loadNibNamed:@"CYShoppingCarBottomView" owner:self options:nil][0];
    bottomView.frame = frame;
    return bottomView;
}

- (void)setCYShoppingCarBottomViewDidClickSelectAllButtonCallBack:(CYShoppingCarBottomViewDidClickSelectAllButtonCallBack)callback
{
    _shoppingCarBottomViewDidClickSelectAllButtonCallBack = callback;
}

- (void)setTotalPrice:(CGFloat)totalPrice
{
    _totalPrice = totalPrice;
    self.totalPriceLabel.text = [NSString stringWithFormat:@"%0.1f",totalPrice];
}
- (IBAction)selectAllButtonClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    
    if (_shoppingCarBottomViewDidClickSelectAllButtonCallBack) {
        _shoppingCarBottomViewDidClickSelectAllButtonCallBack(sender.selected);
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect frame = self.frame;
    frame.size.height = kBottomViewHeight;
    self.frame = frame;
}


@end
