//
//  CYCenterTitleCollectionViewCell.m
//  CYEnjoyProject
//
//  Created by qianfeng on 16/9/29.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "CYCenterTitleCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@interface CYCenterTitleCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UILabel *centerTitle;

@end

@implementation CYCenterTitleCollectionViewCell

- (void)setModel:(CYORGANIZEDModel *)model
{
    _model = model;
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:model.img_url]];
    self.centerTitle.text = model.title;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
