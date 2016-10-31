//
//  CYExploreCell4.m
//  CYEnjoyProject
//
//  Created by qianfeng on 16/9/27.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "CYExploreCell4.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"
#import "NSString+Size.h"

@interface CYExploreCell4 ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *iconView;


@end
@implementation CYExploreCell4

- (void)setCyeModel1:(CYExploreModel1 *)cyeModel1
{
    
    _cyeModel1 = cyeModel1;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:cyeModel1.icon]];
    self.titleLabel.text = cyeModel1.title;
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
        
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
