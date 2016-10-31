//
//  StrikeDeleteLineLabel.m
//  02-爱限免首页
//
//  Created by vera on 16/9/1.
//  Copyright © 2016年 deli. All rights reserved.
//

#import "StrikeDeleteLineLabel.h"

@interface StrikeDeleteLineLabel ()
{
    NSString *_text;
}

@end

@implementation StrikeDeleteLineLabel

- (void)setText:(NSString *)text
{
    _text = text;
    
    //属性字符串
    //NSStrikethroughStyleAttributeName：删除线
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:text];
    //添加属性
    [attributeString addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlineStyleThick) range:NSMakeRange(0, text.length)];
    
    self.attributedText = attributeString;
}

- (NSString *)text
{
    return _text;
}

@end
