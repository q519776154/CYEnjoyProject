//
//  CYExploreCell2.m
//  CYEnjoyProject
//
//  Created by qianfeng on 16/9/27.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "CYExploreCell2.h"
#import "UIImageView+WebCache.h"
@interface CYExploreCell2 ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UIImageView *iconView2;


@end

@implementation CYExploreCell2

#pragma mark - 懒加载
- (void)setCyModel:(CYExploreModel *)cyModel
{
    _cyModel = cyModel;
    
    CYExploreModel1 *model1 = cyModel.cyModel1Arr[0];
    CYExploreModel1 *model2 = cyModel.cyModel1Arr[1];
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:model1.img]];
    [self.iconView2 sd_setImageWithURL:[NSURL URLWithString:model2.img]];
  
}

- (void)layoutSubviews
{
    [super layoutSubviews];
        self.iconView.frame = CGRectMake(10, 10, (self.contentView.frame.size.width - 30)/2, 100);
    self.iconView2.frame = CGRectMake(CGRectGetMaxX(self.iconView.frame) + 10, 10, (self.contentView.frame.size.width - 30)/2, 100);
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
