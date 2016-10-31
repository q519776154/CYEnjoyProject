//
//  CYRecommendXibCollectionViewCell.m
//  CYEnjoyProject
//
//  Created by qianfeng on 16/9/29.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "CYRecommendXibCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@interface CYRecommendXibCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *topImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *bottomButton;

@end

@implementation CYRecommendXibCollectionViewCell

- (void)setModel:(CYORGANIZEDModel *)model
{
    _model = model;
    [self.topImageView sd_setImageWithURL:[NSURL URLWithString:model.product_image]];
    self.bottomButton.layer.cornerRadius = 5;
    self.bottomButton.clipsToBounds = YES;
    self.nameLabel.text = model.product_name;
    self.detailLabel.text = model.product_description;
    
    
    int price = model.price.intValue;
    self.priceLabel.text = [NSString stringWithFormat:@"%d元/%@", price/100, model.show_entity_name];

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
