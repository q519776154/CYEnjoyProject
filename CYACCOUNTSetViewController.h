//
//  CYACCOUNTSetViewController.h
//  CYEnjoyProject
//
//  Created by qianfeng on 16/9/28.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^headViewImageCallBack)(UIImage *image);

@interface CYACCOUNTSetViewController : UIViewController

@property (nonatomic,copy) headViewImageCallBack headImageCallBack;

- (void)setHeadImageCallBack:(headViewImageCallBack)headImageCallBack;

@end
