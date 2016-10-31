//
//  CYExploreModel.h
//  CYEnjoyProject
//
//  Created by qianfeng on 16/9/26.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CYExploreModel1.h"

@interface CYExploreModel: CYBaseModel

@property (nonatomic,copy) NSString *title;

@property (nonatomic,copy) NSString *icon;

@property (nonatomic,copy) NSString *image;

@property (nonatomic,copy) NSString *first_pre_icon;

@property (nonatomic, retain) NSMutableArray *cyModel1Arr;


@end
