//
//  CYShoppingCarTableViewCell.m
//  CYEnjoyProject
//
//  Created by qianfeng on 16/9/30.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "CYShoppingCarTableViewCell.h"
#import "UIImageView+WebCache.h"
@interface CYShoppingCarTableViewCell ()
{
    CYShoppingCarCellRefreshCallBack _cyshoppingCarCellRefreshCallBack;
}

@property (weak, nonatomic) IBOutlet UIButton *selectButton;

@property (weak, nonatomic) IBOutlet UIImageView *product_image;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UILabel *numberLabel;

@end

@implementation CYShoppingCarTableViewCell

- (void)setCYShoppingCarCellRefreshCallBack:(CYShoppingCarCellRefreshCallBack)callback
{
    _cyshoppingCarCellRefreshCallBack = callback;
}

- (void)setShoppingCarGoods:(CYShoppingCarGoods *)shoppingCarGoods
{
    _shoppingCarGoods = shoppingCarGoods;
    self.priceLabel.text = shoppingCarGoods.price;
    self.numberLabel.text = [NSString stringWithFormat:@"%ld",shoppingCarGoods.number];
    [self.product_image sd_setImageWithURL:[NSURL URLWithString:shoppingCarGoods.product_image]];
    self.nameLabel.text = shoppingCarGoods.name;
    self.selectButton.selected = shoppingCarGoods.isSelected;
}
#pragma mark - 事件处理

- (IBAction)selectButtonClick:(UIButton *)sender
{
    //1.修改模型状态
    _shoppingCarGoods.selected = !_shoppingCarGoods.isSelected;
    
    //2.刷新当前行
    if (_cyshoppingCarCellRefreshCallBack)
    {
        _cyshoppingCarCellRefreshCallBack();
    }

}

- (IBAction)minusButtonClick:(id)sender {
    if (_shoppingCarGoods.number <= 1)
    {
        return;
    }
    
    _shoppingCarGoods.number--;
    
    //刷新当前行
    if (_cyshoppingCarCellRefreshCallBack)
    {
        _cyshoppingCarCellRefreshCallBack();
    }

}
- (IBAction)plusButton:(id)sender {
    _shoppingCarGoods.number++;
    
    //刷新当前行
    if (_cyshoppingCarCellRefreshCallBack)
    {
        _cyshoppingCarCellRefreshCallBack();
    }

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
