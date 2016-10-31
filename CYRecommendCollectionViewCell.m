//
//  CYRecommendCollectionViewCell.m
//  CYEnjoyProject
//
//  Created by qianfeng on 16/9/28.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "CYRecommendCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@interface CYRecommendCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *wineImageView;

@property (weak, nonatomic) IBOutlet UILabel *productLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UIButton *introduceButton;

@end

@implementation CYRecommendCollectionViewCell

-(void)setModel:(CYORGANIZEDModel *)model
{
    _model = model;
    [self.wineImageView sd_setImageWithURL:[NSURL URLWithString:model.product_image]];
    self.introduceButton.layer.cornerRadius = 5;
    self.introduceButton.clipsToBounds = YES;
    self.productLabel.text = model.product_name;
    self.descriptionLabel.text = model.product_description;
    int price = model.price.intValue;
    self.priceLabel.text = [NSString stringWithFormat:@"%d元/%@", price/100, model.show_entity_name];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
