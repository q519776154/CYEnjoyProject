//
//  CYORGANIZEDModel.h
//  CYEnjoyProject
//
//  Created by qianfeng on 16/9/26.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CYBaseModel.h"

@interface CYORGANIZEDModel : CYBaseModel

@property (nonatomic, copy) NSString *begin_at;
@property (nonatomic, copy) NSString *end_at;

@property (nonatomic, copy) NSString *enjoy_url;
@property (nonatomic, copy) NSString *img_url;
@property (nonatomic, copy) NSString *reference;
@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *original_price;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *product_image;
@property (nonatomic, copy) NSString *product_name;
@property (nonatomic, copy) NSString *show_entity_name;
@property (nonatomic, copy) NSString *short_description;

//@property (nonatomic, getter=isFavorite) BOOL is_favorite;
@property (nonatomic, copy) NSString *sell_begin_time;
@property (nonatomic, copy) NSString *sell_end_time;
@property (nonatomic, copy) NSString *short_name;
@property (nonatomic, copy) NSString *product_id;
@property (nonatomic, copy) NSString *sub_product_id;
@property (nonatomic, copy) NSString *bg_img_url;//背景图,限时
@property (nonatomic, copy) NSString *icon_img_url;//右下小图标,限时
@property (nonatomic, copy) NSString *sell_state;
@property (nonatomic, copy) NSString *sub_title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *img_title;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *target_id;
@property (nonatomic, copy) NSString *product_description;

@end
