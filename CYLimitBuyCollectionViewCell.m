//
//  CYLimitBuyCollectionViewCell.m
//  CYEnjoyProject
//
//  Created by qianfeng on 16/9/27.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "CYLimitBuyCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Resize.h"

@interface CYLimitBuyCollectionViewCell ()

{
    NSTimer *_timer;
}
@property (weak, nonatomic) IBOutlet UIImageView *bigImageView;
@property (weak, nonatomic) IBOutlet UILabel *limitLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *hourLabel;
@property (weak, nonatomic) IBOutlet UILabel *minuteLabel;
@property (weak, nonatomic) IBOutlet UILabel *secLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *sectionLabel;
@property (weak, nonatomic) IBOutlet UILabel *organizedPrice;

@end

@implementation CYLimitBuyCollectionViewCell

- (void)timerStart
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(calculateRestTimeFromModel) userInfo:nil repeats:YES];

}


- (void)setModel:(CYORGANIZEDModel *)model
{
    if (_timer) {
//        NSLog(@"销毁定时器");
        [_timer invalidate];
    }
    _model = model;
    [self.bigImageView sd_setImageWithURL:[NSURL URLWithString:model.product_image] placeholderImage:[[UIImage imageNamed:@"pass_placeolder_icon_65x41_"] resizableImage]];
    self.limitLabel.text = @"限时抢购";
    int price = model.price.intValue/100;
    self.priceLabel.text = [NSString stringWithFormat:@"%d", price];
    self.sectionLabel.text = [NSString stringWithFormat:@"元/%@", model.show_entity_name];
    
    int orgPrice = model.original_price.floatValue;
    NSString *text = [NSString stringWithFormat:@"¥ %d",orgPrice/100];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:text];
    //添加属性
    [attributeString addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlineStyleThick) range:NSMakeRange(0, text.length)];
    self.organizedPrice.attributedText = attributeString;
    [self calculateRestTimeFromModel];
    [self timerStart];
    
}

- (void)calculateRestTimeFromModel
{
    NSTimeInterval currentTime = [[NSDate dateWithTimeIntervalSinceNow:0] timeIntervalSince1970] *1000;
    NSTimeInterval beganTime = self.model.sell_begin_time.doubleValue;
    NSTimeInterval endTime = self.model.sell_end_time.doubleValue;
    if (currentTime < beganTime)
    {
        self.endTitleLabel.text = @"距离开始时间";
        NSArray *TimeArr = [self currentBetweenExpireFormatterWithExpireTime:(beganTime - currentTime)];
        self.hourLabel.text = TimeArr[0];
        self.minuteLabel.text = TimeArr[1];
        self.secLabel.text = TimeArr[2];
    }
    else if(currentTime > beganTime && currentTime < endTime)
    {
        self.endTitleLabel.text = @"距离结束时间";
        NSArray *TimeArr = [self currentBetweenExpireFormatterWithExpireTime:(endTime - currentTime)];
        self.hourLabel.text = TimeArr[0];
        self.minuteLabel.text = TimeArr[1];
        self.secLabel.text = TimeArr[2];
    }
    else
    {
        self.endTitleLabel.text = @"活动已经结束";
        self.hourLabel.text = @"00";
        self.minuteLabel.text = @"00";
        self.secLabel.text = @"00";
    }
    
}


#pragma mark - 计算当前时间和超时时间差
- (NSArray *)currentBetweenExpireFormatterWithExpireTime:(NSTimeInterval)time
{
    time = time/1000;
    NSString *h = [NSString stringWithFormat:@"%02d",(int)(time / 3600)];
    NSString *m = [NSString stringWithFormat:@"%02d",(int)((time - h.floatValue * 3600)/60)];
    NSString *s = [NSString stringWithFormat:@"%02d",(int)(time - h.floatValue*3600 - m.floatValue*60)];
    
    return @[h,m,s];
}

@end
