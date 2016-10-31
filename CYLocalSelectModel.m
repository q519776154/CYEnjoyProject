//
//  CYLocalSelectModel.m
//  CYEnjoyProject
//
//  Created by qianfeng on 16/9/26.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "CYLocalSelectModel.h"
#import "CYConfig.h"
#import <UIKit/UIKit.h>

@implementation CYLocalSelectModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        _organizedModelArr = [NSMutableArray array];
        _img_info_list = [NSMutableArray array];
        _small_icon_list = [NSMutableArray array];
        _text = [NSMutableArray array];
    }
    return self;
}

- (void)setImg_info_list:(NSArray *)img_info_list
{
    _img_info_list = img_info_list;
    [self caculateCellHeight];
}

- (void)setSmall_icon_list:(NSArray *)small_icon_list
{
    _small_icon_list = small_icon_list;
    [self caculateCellHeight];
}

- (void)caculateCellHeight
{
    if (!(self.img_info_list || self.small_icon_list)) {
        return;
    }
    NSInteger Bcount = self.small_icon_list.count;
    NSInteger Icount = self.img_info_list.count;
    if (self.style.integerValue == 19 && Bcount > 0)  //19号cell
    {
        float titleHeight = 60;
        float space = 10;//collectionView 上边距0,下边距10
        float buttonW = (kScreenW - 20)/3;   //一排放三个
        float buttonH = ((Bcount - 1)/3 + 1) * buttonW;
        float imageW = kScreenW - 20;
        float imageH = imageW *720 /1080 * Icount;
        self.cellHeight = titleHeight + buttonH + imageH + (Icount+2)*space;
    }

}

+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary
{
    CYLocalSelectModel *model = [[self alloc] init];
    [model setValuesForKeysWithDictionary:dictionary];
    

    
    return model;
}


@end
