//
//  CYRecommendTableViewCell.m
//  CYEnjoyProject
//
//  Created by qianfeng on 16/9/28.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "CYRecommendTableViewCell.h"
#import "TAPageControl.h"
#import "CYRecommendCollectionViewCell.h"
#import "CYConfig.h"
#import "Masonry.h"

@interface CYRecommendTableViewCell () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic)  UIView *redBgView;
@property (weak, nonatomic)  UILabel *topLabel;
@property (weak, nonatomic)  UILabel *bottomLabel;
@property (nonatomic, weak) TAPageControl *pageCtrl;
@property (nonatomic, weak) UICollectionView *collectionView;
@end

@implementation CYRecommendTableViewCell

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initialize];
    }
    return self;
}



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 20, 0);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView *collectView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:layout];
    collectView.delegate = self;
    collectView.dataSource = self;
    collectView.pagingEnabled = YES;
    collectView.backgroundColor = [UIColor clearColor];
    collectView.showsHorizontalScrollIndicator = NO;
    [collectView registerNib:[UINib nibWithNibName:@"CYRecommendCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CYRecommendCollectionViewCell"];
    [self.contentView addSubview:collectView];
    _collectionView = collectView;
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor redColor];
    view.layer.cornerRadius = 40;
    view.clipsToBounds = YES;
    [self.contentView addSubview:view];
    _redBgView = view;
    
    UILabel *topL = [[UILabel alloc] init];
    topL.textAlignment = NSTextAlignmentCenter;
    topL.font = [UIFont systemFontOfSize:16];
    topL.textColor = [UIColor whiteColor];
    [self.redBgView addSubview:topL];
    _topLabel = topL;
    
    UILabel *bottomL = [[UILabel alloc] init];
    bottomL.textAlignment = NSTextAlignmentCenter;
    bottomL.font = [UIFont systemFontOfSize:14];
    bottomL.textColor = [UIColor whiteColor];
    [self.redBgView addSubview:bottomL];
    _bottomLabel = bottomL;
}

- (void)setSelectModel:(CYLocalSelectModel *)selectModel
{
    _selectModel = selectModel;
    
    [self.collectionView reloadData];
    self.topLabel.text = selectModel.text.firstObject;
    self.bottomLabel.text = selectModel.text.lastObject;
    if (selectModel.organizedModelArr.count <=1) {
        self.pageCtrl.hidden = YES;
    }
    else{
        self.pageCtrl.hidden = NO;
        self.pageCtrl.numberOfPages = selectModel.organizedModelArr.count;
        self.pageCtrl.currentPage = 0;
    }

}

- (TAPageControl *)pageCtrl
{
    if (!_pageCtrl) {
        TAPageControl *page = [[TAPageControl alloc] initWithFrame:CGRectMake(0, 360, kScreenW, 20)];
        page.dotImage = [UIImage imageNamed:@"oval_icon_normal_5x5_"];
        page.currentDotImage = [UIImage imageNamed:@"oval_icon_highlighted_5x5_"];
        [self.contentView addSubview:page];
        _pageCtrl =page;
    }
    return _pageCtrl;
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    layout.itemSize = CGSizeMake(self.contentView.frame.size.width, 353);
    //从item 140高度开始添加灰色背景
    self.collectionView.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);
    
    [self.redBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(20);
        make.top.equalTo(self.contentView.mas_top).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    
    [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.redBgView.mas_centerY).with.offset(-10);
        make.centerX.equalTo(self.redBgView.mas_centerX);
    }];
    
    [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.redBgView.mas_centerY).with.offset(10);
        make.centerX.equalTo(self.redBgView.mas_centerX);
    }];

}

#pragma mark - delegate/datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.selectModel.organizedModelArr.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView    cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CYRecommendCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CYRecommendCollectionViewCell" forIndexPath:indexPath];
    CYORGANIZEDModel *model = self.selectModel.organizedModelArr[indexPath.item];
    cell.model = model;
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float w = self.collectionView.frame.size.width;
    self.pageCtrl.currentPage = (self.collectionView.contentOffset.x + w/2) / w;
}



@end
