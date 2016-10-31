//
//  CYLocalSelectModel.h
//  CYEnjoyProject
//
//  Created by qianfeng on 16/9/26.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CYBaseModel.h"

//#import "CYORGANIZEDModel.h"
//#import "CYPERIODModel.h"
//#import "CYTAGModel.h"

@interface CYLocalSelectModel : CYBaseModel

@property (nonatomic, copy) NSString *begin_at;
@property (nonatomic, copy) NSString *city_id;
@property (nonatomic, copy) NSString *end_at;
@property (nonatomic, copy) NSString *_id;
@property (nonatomic, copy) NSString *item_type;
@property (nonatomic, copy) NSString *now;
@property (nonatomic, copy) NSString *position;
@property (nonatomic, copy) NSString *style;

//TAG类型需要
@property (nonatomic, copy) NSString *enjoy_url;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *img_url;
@property (nonatomic, copy) NSString *bottom;
@property (nonatomic, copy) NSString *reference;


@property (nonatomic, strong) NSMutableArray *organizedModelArr;

//今日推荐需要
@property (nonatomic, copy) NSMutableArray *text;
//18特别需要
@property (nonatomic, assign) float cellHeight;
@property (nonatomic, copy) NSString *img_title;
@property (nonatomic, copy) NSArray *img_info_list;
@property (nonatomic, copy) NSArray *small_icon_list;

@end
