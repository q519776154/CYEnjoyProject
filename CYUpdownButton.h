//
//  CYUpdownButton.h
//  CYEnjoyProject
//
//  Created by qianfeng on 16/9/26.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ButtonClickCallBack)(void);

@interface CYUpdownButton : UIView

@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, copy) ButtonClickCallBack clickCallBack;

- (void)setClickCallBack:(ButtonClickCallBack)clickCallBack;

@end
