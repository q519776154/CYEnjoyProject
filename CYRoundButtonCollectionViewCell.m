//
//  CYRoundButtonCollectionViewCell.m
//  CYEnjoyProject
//
//  Created by qianfeng on 16/9/28.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "CYRoundButtonCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@interface CYRoundButtonCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *buttonImageView;
@property (weak, nonatomic) IBOutlet UILabel *buttonLabel;

@end

@implementation CYRoundButtonCollectionViewCell

- (void)setModel:(CYORGANIZEDModel *)model
{
    _model = model;
    self.buttonLabel.text = model.title;
    [self.buttonImageView sd_setImageWithURL:[NSURL URLWithString:model.img_url]];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
