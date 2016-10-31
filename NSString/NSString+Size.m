//
//  NSString+Size.m
//  01-聊天界面设计和实现
//
//  Created by vera on 16/8/22.
//  Copyright © 2016年 deli. All rights reserved.
//

#import "NSString+Size.h"

@implementation NSString (Size)

- (CGSize)sizeWithFontSize:(CGFloat)fontSize maxSize:(CGSize)maxSize
{
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]} context:nil].size;
}

@end
