//
//  NSString+Size.h
//  01-聊天界面设计和实现
//
//  Created by vera on 16/8/22.
//  Copyright © 2016年 deli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Size)

/**
 *  根据文字来计算宽和高
 *
 *  @param fontSize 字体大小
 *  @param maxSize  最大size
 *
 *  @return 计算好的宽度和高度
 */
- (CGSize)sizeWithFontSize:(CGFloat)fontSize maxSize:(CGSize)maxSize;

@end
