//
//  CYButton.m
//  CYEnjoyProject
//
//  Created by qianfeng on 16/9/26.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "CYCenterButton.h"
#import "NSString+Size.h"

#define kDefaultFontSize 13

@implementation CYCenterButton



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    self.titleLabel.font = [UIFont systemFontOfSize:kDefaultFontSize];
    //根据字体大小自动调整宽度。注意该属性只支持文字是一行
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSString *title = self.titleLabel.text;
    CGFloat width = [title sizeWithFontSize:kDefaultFontSize maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)].width;
//    
//    int imageWidth = 10;
//    int imageHegith = 7;
    
    //重新修改title的宽度
    self.titleLabel.frame = CGRectMake(0, 0, width, self.frame.size.height);
//    //修改图片的坐标
//    self.imageView.frame = CGRectMake(CGRectGetMaxX(self.titleLabel.frame) + 2, self.frame.size.height/2 - imageHegith/2, imageWidth, imageHegith);
    
    
    //修改按钮的宽度
//    CGRect frame = self.frame;
//    frame.size.width = CGRectGetMaxX(self.imageView.frame) + 5;
//    self.frame = frame;
}

@end
