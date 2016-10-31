//
//  CYBaseModel.m
//  CYEnjoyProject
//
//  Created by qianfeng on 16/9/24.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "CYBaseModel.h"

@implementation CYBaseModel

+ (id)modelWithDictionary:(NSDictionary *)dictionary
{
    CYBaseModel *model = [[self alloc] init];
    [model setValuesForKeysWithDictionary:dictionary];
    
    return model;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (id)valueForUndefinedKey:(NSString *)key
{
    return nil;
}


@end
