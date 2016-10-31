//
//  CYOrganizedTableViewCell.m
//  CYEnjoyProject
//
//  Created by qianfeng on 16/9/26.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "CYORGANIZEDTableViewCell.h"
#import "CYORGANIZEDModel.h"
#import "SDCycleScrollView.h"
#import "UIImage+Resize.h"


@interface CYORGANIZEDTableViewCell () <SDCycleScrollViewDelegate>

@property (nonatomic, weak) SDCycleScrollView *scrollView;

@end

@implementation CYORGANIZEDTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        SDCycleScrollView *scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:[[UIImage imageNamed:@"pass_placeolder_icon"] resizableImage]];
        scrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
//        scrollView.currentPageDotColor = [UIColor redColor];// 自定义分页控件小圆标颜色
        scrollView.currentPageDotImage = [UIImage imageNamed:@"oval_icon_highlighted_5x5_"];
//        scrollView.pageDotColor = [UIColor whiteColor];
        scrollView.pageDotImage = [UIImage imageNamed:@"oval_icon_normal_5x5_"];
        //   block监听点击方式
        scrollView.clickItemOperationBlock = ^(NSInteger index) {
            CYORGANIZEDModel *model = self.organizedModelArr[index];
            NSLog(@"%@", model.enjoy_url);//点击事件,跳转TODO:::::::
        };
        [self.contentView addSubview:scrollView];
        _scrollView = scrollView;
    }
    return self;
}


- (void)setOrganizedModelArr:(NSArray *)organizedModelArr
{
    _organizedModelArr = organizedModelArr;
    NSMutableArray *arrM = [NSMutableArray array];
    for (CYORGANIZEDModel *model in organizedModelArr) {
        [arrM addObject:model.img_url];
    }
    self.scrollView.imageURLStringsGroup = arrM;
//    self.scrollView.frame = self.contentView.frame; //小小BUG...
//    NSLog(@"%@", self.scrollView.imageURLStringsGroup);
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    self.scrollView.frame = self.contentView.frame;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
