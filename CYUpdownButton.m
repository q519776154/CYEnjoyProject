//
//  CYUpdownButton.m
//  CYEnjoyProject
//
//  Created by qianfeng on 16/9/26.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "CYUpdownButton.h"

@interface CYUpdownButton ()

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy) NSString *title;

@end

@implementation CYUpdownButton

- (void)setClickCallBack:(ButtonClickCallBack)clickCallBack
{
    _clickCallBack = clickCallBack;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [self addSubview:imageView];
        _imageView = imageView;
        
        UILabel *label = [[UILabel alloc] init];
        label.numberOfLines = 1;
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor blackColor];
        [self addSubview:label];
        _titleLabel = label;
        
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        [tap addTarget:self action:@selector(click)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)click
{
    if(_clickCallBack)
    {
        _clickCallBack();
    }
}

- (void)layoutSubviews
{
    // Center image
    CGPoint center = self.imageView.center;
    self.imageView.bounds = CGRectMake(0, 0, 40, 40);
    center.x = self.frame.size.width/2;
    center.y = 30;
    self.imageView.center = center;
    
    
    //Center text
    self.titleLabel.bounds = CGRectMake(0, 0, self.frame.size.width, 30);
    self.titleLabel.center = CGPointMake(self.frame.size.width/2, self.frame.size.height - 30);

}

@end
