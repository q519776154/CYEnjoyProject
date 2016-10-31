//
//  CYTAGCollectionViewCell.m
//  CYEnjoyProject
//
//  Created by qianfeng on 16/9/26.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "CYTAGCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Resize.h"

@interface CYTAGCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *IconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *organizedPrice;
@property (weak, nonatomic) IBOutlet UIButton *heartImageView;

@end

@implementation CYTAGCollectionViewCell

- (void)setModel:(CYORGANIZEDModel *)model
{
    _model = model;
    [self.IconImageView sd_setImageWithURL:[NSURL URLWithString:model.product_image] placeholderImage:[[UIImage imageNamed:@"pass_placeolder_icon_65x41_"] resizableImage]];
    self.titleLabel.text = model.name;
    self.detailLabel.text = model.short_description;
    CGFloat price1 = model.price.floatValue;
    self.priceLabel.text = [NSString stringWithFormat:@"%.1f元/%@",price1/100,model.show_entity_name];
    if (model.original_price.intValue) {
        CGFloat price2 = model.original_price.floatValue;
        NSString *text = [NSString stringWithFormat:@"¥ %.1f",price2/100];
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:text];
        //添加属性
        [attributeString addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlineStyleThick) range:NSMakeRange(0, text.length)];
        self.organizedPrice.attributedText = attributeString;
    }
    else
    {
        self.organizedPrice.attributedText = nil;
    }
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


/*@property (nonatomic, copy) NSString *original_price;
 @property (nonatomic, copy) NSString *price;
 @property (nonatomic, copy) NSString *product_image;
 @property (nonatomic, copy) NSString *show_entity_name;
 @property (nonatomic, copy) NSString *short_description;
*/


@end
