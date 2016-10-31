//
//  CYLocationManager.m
//  CYEnjoyProject
//
//  Created by qianfeng on 16/9/24.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "CYLocationManager.h"
#import "UIDevice+Version.h"

@interface CYLocationManager ()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

@property (nonatomic, copy) LocationSuccessCallback locationSuccessCallback;


@end

@implementation CYLocationManager


- (CLLocationManager *)locationManager
    {
    if (!_locationManager)
    {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.delegate = self;
            
        if ([UIDevice systemVersion] >= 8.0)
        {
                //使用的时候授权
            [_locationManager requestWhenInUseAuthorization];
        }
            
    }
        
    return _locationManager;
}
+ (instancetype)sharedLocationManager
{
    static CYLocationManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    
    return manager;
}

/**
 *  判断定位服务是否可用
 *
 *  @return <#return value description#>
 */
- (BOOL)locationServicesEnabled
{
    return [CLLocationManager locationServicesEnabled];
}

/**
 *  启动定位服务
 */
- (void)startLocationService:(LocationSuccessCallback)callback;
{
    _locationSuccessCallback = callback;
    
    if (![self locationServicesEnabled])
    {
        return;
    }
    
    //启动定位服务
    [self.locationManager startUpdatingLocation];
    
}

#pragma mark - CLLocationManagerDelegate
/**
 *  定位成功
 *
 *  @param manager   <#manager description#>
 *  @param locations <#locations description#>
 */
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    
    if (locations.count == 0)
    {
        return;
    }
    
    //停止定位服务，因为定位需要消耗更多的电量、流量
    [manager stopUpdatingLocation];
    
    
    CLLocation *location = locations.firstObject;
    
    //地理反编码
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //地理反编码
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if (placemarks.count == 0)
        {
            return;
        }
        
        //地理详细信息
        CLPlacemark *placemark = placemarks.firstObject;
        
        if (_locationSuccessCallback)
        {
            _locationSuccessCallback(placemark);
        }
        
    }];
    
}






@end
