//
//  CYCityListViewController.h
//  CYEnjoyProject
//
//  Created by qianfeng on 16/9/26.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CYCity;

typedef void(^CityListViewControllerDidSelectCityCallback)(CYCity *city);

@interface CYCityListViewController : UIViewController

@property (nonatomic, copy) CityListViewControllerDidSelectCityCallback cityListViewControllerDidSelectCityCallback;

- (void)setCityListViewControllerDidSelectCityCallback:(CityListViewControllerDidSelectCityCallback)callback;

@end
