//
//  CYTAGPlusCollectionViewCell.m
//  CYEnjoyProject
//
//  Created by qianfeng on 16/9/27.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "CYTAGPlusCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Resize.h"

@interface CYTAGPlusCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *bigImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;


@end

@implementation CYTAGPlusCollectionViewCell

-(void)setModel:(CYORGANIZEDModel *)model
{
    _model = model;
    [self.bigImageView sd_setImageWithURL:[NSURL URLWithString:model.product_image] placeholderImage:[[UIImage imageNamed:@"pass_placeolder_icon_65x41_"] resizableImage]];
    self.nameLabel.text = model.short_name;
    int price = model.price.intValue/100;
    self.priceLabel.text = [NSString stringWithFormat:@"%d 元/%@", price, model.show_entity_name];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
