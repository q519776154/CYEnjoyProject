//
//  UIImage+Resize.m
//  01-聊天界面设计和实现
//
//  Created by vera on 16/8/22.
//  Copyright © 2016年 deli. All rights reserved.
//

#import "UIImage+Resize.h"

@implementation UIImage (Resize)

/**
 *  拉伸图片
 *
 *  @return <#return value description#>
 */
- (UIImage *)resizableImage
{
    //UIEdgeInsetsMake这个范围不拉伸，其余的部分都拉伸
    //只拉伸一个点（中心点）
    return [self resizableImageWithCapInsets:UIEdgeInsetsMake(self.size.height/2, self.size.width/2, self.size.height/2, self.size.width/2)];
}

@end
