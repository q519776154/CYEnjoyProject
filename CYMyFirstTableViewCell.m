//
//  CYMyFirstTableViewCell.m
//  CYEnjoyProject
//
//  Created by qianfeng on 16/9/27.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "CYMyFirstTableViewCell.h"

@implementation CYMyFirstTableViewCell

- (IBAction)codeClick:(UIButton *)sender
{
    
}
- (IBAction)passClick:(id)sender
{
   
}

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
