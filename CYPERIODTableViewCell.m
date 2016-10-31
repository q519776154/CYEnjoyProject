//
//  CYPERIODTableViewCell.m
//  CYEnjoyProject
//
//  Created by qianfeng on 16/9/26.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "CYPERIODTableViewCell.h"
#import "CYUpdownButton.h"
#import "CYORGANIZEDModel.h"
#import "UIImage+Resize.h"
#import "UIImageView+WebCache.h"

@interface CYPERIODTableViewCell ()

@property (nonatomic, weak) CYUpdownButton *btn1;
@property (nonatomic, weak) CYUpdownButton *btn2;
@property (nonatomic, weak) CYUpdownButton *btn3;
@property (nonatomic, weak) CYUpdownButton *btn4;


@end

@implementation CYPERIODTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        CYUpdownButton *btn1 = [[CYUpdownButton alloc] init];
        btn1.tag = 1;
        [self.contentView addSubview:btn1];
        _btn1 = btn1;
        
        CYUpdownButton *btn2 = [[CYUpdownButton alloc] init];
        btn2.tag = 2;
        [self.contentView addSubview:btn2];
        _btn2 = btn2;
        
        CYUpdownButton *btn3 = [[CYUpdownButton alloc] init];
        btn3.tag = 3;
        [self.contentView addSubview:btn3];
        _btn3 = btn3;
        
        CYUpdownButton *btn4 = [[CYUpdownButton alloc] init];
        btn4.tag = 4;
        [self.contentView addSubview:btn4];
        _btn4 = btn4;
    }
    return self;
}

- (void)setOrganizedModelArr:(NSArray *)organizedModelArr
{
    if (organizedModelArr.count == 0) {
        return;
    }
    _organizedModelArr = organizedModelArr;
    [organizedModelArr enumerateObjectsUsingBlock:^(CYORGANIZEDModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        CYUpdownButton *btn = [self viewWithTag:idx+1];
        [btn.imageView sd_setImageWithURL:[NSURL URLWithString:model.img_url] placeholderImage:[[UIImage imageNamed:@"pass_placeolder_icon"] resizableImage]];
        btn.titleLabel.text = model.title;
        [btn setClickCallBack:^{
            NSLog(@"%@", model.enjoy_url);
        }];
    }];
    for (NSInteger i = 0; i < self.organizedModelArr.count; i++) {
        CYUpdownButton *btn = [self viewWithTag:i+1];
        btn.frame = CGRectMake(i * self.contentView.frame.size.width/self.organizedModelArr.count, 0, self.contentView.frame.size.width/self.organizedModelArr.count, self.contentView.frame.size.height);
    }
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    for (NSInteger i = 0; i < self.organizedModelArr.count; i++) {
        CYUpdownButton *btn = [self viewWithTag:i+1];
        btn.frame = CGRectMake(i * self.contentView.frame.size.width/self.organizedModelArr.count, 0, self.contentView.frame.size.width/self.organizedModelArr.count, self.contentView.frame.size.height);
    }
//    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        NSLog(@"%@", NSStringFromCGRect(obj.frame));
//    }];
    
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
