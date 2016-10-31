//
//  CYCity.h
//  CYEnjoyProject
//
//  Created by qianfeng on 16/9/26.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYCity : NSObject

@property (nonatomic, copy) NSString *name;

+ (instancetype)cityWithDic:(NSDictionary *)dic;

@end
