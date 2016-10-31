//
//  CYManualCollectionViewCell.m
//  CYEnjoyProject
//
//  Created by qianfeng on 16/9/28.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "CYManualCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@interface CYManualCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *bigImageView;

@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation CYManualCollectionViewCell

- (void)setModel:(CYORGANIZEDModel *)model
{
    [self.bigImageView sd_setImageWithURL:[NSURL URLWithString:model.img_url]];
    [self.titleImageView sd_setImageWithURL:[NSURL URLWithString:model.img_title]];
    self.titleLabel.text = model.title;
    self.contentLabel.text = model.content;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
