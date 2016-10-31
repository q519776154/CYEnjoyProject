//
//  CYButtonCollectionViewCell.m
//  CYEnjoyProject
//
//  Created by qianfeng on 16/9/27.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "CYButtonCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@interface CYButtonCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *buttonImageView;

@property (weak, nonatomic) IBOutlet UILabel *buttonTitleLabel;


@end

@implementation CYButtonCollectionViewCell

-(void)setModel:(CYORGANIZEDModel *)model
{
    _model = model;
    self.buttonTitleLabel.text = model.title;
    [self.buttonImageView sd_setImageWithURL:[NSURL URLWithString:model.img_url]];

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
