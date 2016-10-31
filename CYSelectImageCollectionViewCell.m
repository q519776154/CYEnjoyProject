//
//  CYSelectImageCollectionViewCell.m
//  CYEnjoyProject
//
//  Created by qianfeng on 16/9/28.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "CYSelectImageCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "NSString+Size.h"
#import "CYConfig.h"
#import "Masonry.h"

@interface CYSelectImageCollectionViewCell ()

@property (weak, nonatomic)  UIImageView *bgImageView;
@property (weak, nonatomic)  UILabel *titleLabel;
@property (weak, nonatomic)  UILabel *detailLabel;

@end

@implementation CYSelectImageCollectionViewCell

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    UIImageView *imageview = [[UIImageView alloc] init];
    [self.contentView addSubview:imageview];
    _bgImageView = imageview;
    
    UILabel *detaillabel = [[UILabel alloc] init];
    detaillabel.backgroundColor = [UIColor blackColor];
    detaillabel.textColor = [UIColor whiteColor];
    detaillabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:detaillabel];
    _detailLabel = detaillabel;
    
    UILabel *titlelabel = [[UILabel alloc] init];
    titlelabel.font = [UIFont systemFontOfSize:16];
    titlelabel.textColor = [UIColor whiteColor];
    titlelabel.backgroundColor = [UIColor blackColor];
    [self.contentView addSubview:titlelabel];
    _titleLabel = titlelabel;
    

    

    
}

- (void)setModel:(CYORGANIZEDModel *)model
{
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:model.img_url]];
    self.titleLabel.text = model.title;
    self.detailLabel.text = model.text;
    self.detailLabel.font = [UIFont systemFontOfSize:14];
}

- (void)layoutSubviews
{
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.contentView);
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    float detailW = 0;
    CGSize detailSize = [self.detailLabel.text sizeWithFontSize:14 maxSize:CGSizeMake(MAXFLOAT, 15)];
    if (detailSize.width > self.contentView.frame.size.width-40)
    {
        detailW = self.contentView.frame.size.width - 40;
    }
    else{
        detailW = detailSize.width;
    }
    
    self.detailLabel.frame = CGRectMake(20, self.contentView.frame.size.height - 25, detailW, 15);
    CGSize titleSize = [self.titleLabel.text sizeWithFontSize:16 maxSize:CGSizeMake(MAXFLOAT, 20)];
    
    self.titleLabel.frame = CGRectMake(20, self.contentView.frame.size.height - 25 - 2 - 20, titleSize.width, titleSize.height);
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
