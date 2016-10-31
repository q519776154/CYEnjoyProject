//
//  CYLIMITCollectionViewCell.m
//  CYEnjoyProject
//
//  Created by qianfeng on 16/9/27.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "CYLIMITCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Resize.h"
#import "CYConfig.h"

@interface CYLIMITCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *bg_imageView;

@property (weak, nonatomic) IBOutlet UIImageView *icon_imageView;
@property (weak, nonatomic) IBOutlet UIImageView *clock_imageView;
@property (weak, nonatomic) IBOutlet UILabel *clock_label;
@property (weak, nonatomic) IBOutlet UIView *clock_bgView;
@property (weak, nonatomic) IBOutlet UILabel *bigTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end

@implementation CYLIMITCollectionViewCell

- (void)setModel:(CYORGANIZEDModel *)model
{
    _model = model;
    
    
    [self.bg_imageView sd_setImageWithURL:[NSURL URLWithString:model.bg_img_url] placeholderImage:[[UIImage imageNamed:@"pass_placeolder_icon_65x41_"] resizableImage]];
    [self.icon_imageView sd_setImageWithURL:[NSURL URLWithString:model.icon_img_url]];
    self.bigTitleLabel.text = model.title;
    
    //TODO::::::::判断时间!!
    NSTimeInterval currentSec = [[NSDate dateWithTimeIntervalSinceNow:0] timeIntervalSince1970] * 1000;
    NSTimeInterval beganSec = model.begin_at.doubleValue;
    NSTimeInterval endSec = model.end_at.doubleValue;
//    NSLog(@"%f===%f===%f",currentSec,beganSec,endSec);
    
    if (currentSec < beganSec) {
        self.clock_imageView.image = [UIImage imageNamed:@"home_icon_black_clock_10x11_"];
        self.clock_bgView.backgroundColor = kColor(246, 246, 246);
        self.clock_label.text = @"未开始";
        self.clock_label.textColor = [UIColor blackColor];
        self.detailLabel.text = [NSString stringWithFormat:@"%@ 开始时间 %@",model.sub_title, [self beganOrEndTimeFromSec:(beganSec)]];
    }
    else if (currentSec > beganSec && currentSec < endSec)
    {
        self.clock_imageView.image = [UIImage imageNamed:@"home_icon_white_clock_10x11_"];
        self.clock_bgView.backgroundColor = kColor(246, 0, 0);
        self.clock_label.text = @"进行中";
        self.clock_label.textColor = [UIColor whiteColor];
        self.detailLabel.text = [NSString stringWithFormat:@"%@ 结束时间 %@",model.sub_title, [self beganOrEndTimeFromSec:(endSec)]];
    }
    else
    {
        self.clock_imageView.image = [UIImage imageNamed:@"home_icon_black_clock_10x11_"];
        self.clock_bgView.backgroundColor = kColor(246, 246, 246);
        self.clock_label.text = @"已结束";
        self.clock_label.textColor = [UIColor blackColor];
        self.detailLabel.text = [NSString stringWithFormat:@"%@ 结束时间 %@",model.sub_title, [self beganOrEndTimeFromSec:(endSec)]];
    }
    
}

- (NSString *)beganOrEndTimeFromSec:(NSTimeInterval)time
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"HH:mm";
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time/1000];
//    NSLog(@"%@",[format stringFromDate:date]);
    return [format stringFromDate:date];
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
