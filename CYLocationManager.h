//
//  CYLocationManager.h
//  CYEnjoyProject
//
//  Created by qianfeng on 16/9/24.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef void(^LocationSuccessCallback)(CLPlacemark *placemark);

@interface CYLocationManager : NSObject

+ (instancetype)sharedLocationManager;

/**
 *  判断定位服务是否可用
 *
 *  @return <#return value description#>
 */
- (BOOL)locationServicesEnabled;

/**
 *  启动定位服务
 */
- (void)startLocationService:(LocationSuccessCallback)callback;


@end
