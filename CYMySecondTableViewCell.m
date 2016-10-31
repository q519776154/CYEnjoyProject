//
//  CYMySecondTableViewCell.m
//  CYEnjoyProject
//
//  Created by qianfeng on 16/9/27.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "CYMySecondTableViewCell.h"

@implementation CYMySecondTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.contentView layoutIfNeeded];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
