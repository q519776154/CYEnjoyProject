//
//  CYExploreCell1.m
//  CYEnjoyProject
//
//  Created by qianfeng on 16/9/26.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "CYExploreCell1.h"
#import "UIImageView+WebCache.h"

@interface CYExploreCell1 ()

@property (weak, nonatomic) IBOutlet UIImageView *product_image;

@property (weak, nonatomic) IBOutlet UIImageView *first_pre_icon;

@property (weak, nonatomic) IBOutlet UILabel *short_name;

@property (weak, nonatomic) IBOutlet UILabel *price;

@property (weak, nonatomic) IBOutlet UILabel *topLabel;


@end

@implementation CYExploreCell1

- (void)setCyModel1:(CYExploreModel1 *)cyModel1
{
    _cyModel1 = cyModel1;
    [self.first_pre_icon sd_setImageWithURL:[NSURL URLWithString:cyModel1.topImage]];
    [self.product_image sd_setImageWithURL:[NSURL URLWithString:cyModel1.product_image]];
    NSString *s = [NSString stringWithFormat:@"%@", cyModel1.price];
    NSInteger price = [s integerValue];
    self.price.text = [NSString stringWithFormat:@"%ld元/%@",price/100,cyModel1.entity_name];
    self.short_name.text = cyModel1.name;

    
}

- (void)setIndex:(NSInteger)index
{
    _index = index;
    self.topLabel.text = [NSString stringWithFormat:@"%ld", index];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
