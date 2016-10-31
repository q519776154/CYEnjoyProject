//
//  CYAccountTableViewCell.m
//  CYEnjoyProject
//
//  Created by qianfeng on 16/9/28.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "CYAccountTableViewCell.h"

@implementation CYAccountTableViewCell



- (void)layoutSubviews
{
    self.headImageButton.layer.cornerRadius = 45.0/2;
    self.headImageButton.clipsToBounds = YES;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




@end
