//
//  CYShoppingCarCollectionViewCell.m
//  CYEnjoyProject
//
//  Created by qianfeng on 16/9/29.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "CYShoppingCarCollectionViewCell.h"
#import "UIImageView+WebCache.h"


@interface CYShoppingCarCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end

@implementation CYShoppingCarCollectionViewCell

- (void)setCyeModel1:(CYExploreModel1 *)cyeModel1
{
    _cyeModel1 = cyeModel1;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:cyeModel1.product_image]];
    self.nameLabel.text = cyeModel1.name;
    self.nameLabel.font = [UIFont systemFontOfSize:15];
    NSString *s = [NSString stringWithFormat:@"%@",cyeModel1.price];
    NSInteger newPrice = [s integerValue];
    self.priceLabel.text = [NSString stringWithFormat:@"%ld元/%@",newPrice/100,cyeModel1.show_entity_name];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
