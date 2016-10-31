//
//  CYCity.m
//  CYEnjoyProject
//
//  Created by qianfeng on 16/9/26.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "CYCity.h"

@implementation CYCity

+ (instancetype)cityWithDic:(NSDictionary *)dic
{
    CYCity *city = [[self alloc] init];
    [city setValuesForKeysWithDictionary:dic];
    
    return city;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (id)valueForUndefinedKey:(NSString *)key
{
    return nil;
}

@end
