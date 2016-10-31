//
//  CYManualTableViewCell.m
//  CYEnjoyProject
//
//  Created by qianfeng on 16/9/28.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "CYManualTableViewCell.h"
#import "CYORGANIZEDModel.h"
#import "TAPageControl.h"
#import "CYManualCollectionViewCell.h"
#import "CYConfig.h"

@interface CYManualTableViewCell () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, weak) TAPageControl *pageCtrl;

@end

@implementation CYManualTableViewCell

- (UICollectionView *)collectionView
{
    if(!_collectionView)
    {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 0;
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 0, 10);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        UICollectionView *collectView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:layout];
        collectView.delegate = self;
        collectView.dataSource = self;
        collectView.pagingEnabled = YES;
        collectView.bounces = NO;
        collectView.backgroundColor = [UIColor clearColor];
        collectView.showsHorizontalScrollIndicator = NO;
        [collectView registerNib:[UINib nibWithNibName:@"CYManualCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CYManualCollectionViewCell"];
        [self.contentView addSubview:collectView];
        _collectionView = collectView;
        
    }
    return _collectionView;
}

- (TAPageControl *)pageCtrl
{
    if (!_pageCtrl) {
        TAPageControl *page = [[TAPageControl alloc] initWithFrame:CGRectMake(0, 200, kScreenW, 20)];
        page.dotImage = [UIImage imageNamed:@"oval_icon_normal_5x5_"];
        page.currentDotImage = [UIImage imageNamed:@"oval_icon_highlighted_5x5_"];
        [self.contentView addSubview:page];
        _pageCtrl =page;
    }
    return _pageCtrl;
}

- (void)setOrganizedModelArr:(NSArray *)organizedModelArr
{
    _organizedModelArr = organizedModelArr;
    if (organizedModelArr.count <=1) {
        self.pageCtrl.hidden = YES;
    }
    else{
        self.pageCtrl.hidden = NO;
        self.pageCtrl.numberOfPages = organizedModelArr.count;
        self.pageCtrl.currentPage = 0;
    }

    [self.collectionView reloadData];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    layout.itemSize = CGSizeMake(self.contentView.frame.size.width - 20, 160);
    self.collectionView.frame = CGRectMake(0, 0, self.contentView.frame.size.width, 200);
    
}

#pragma mark - delegate/datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.organizedModelArr.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView    cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CYManualCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CYManualCollectionViewCell" forIndexPath:indexPath];
    CYORGANIZEDModel *model = self.organizedModelArr[indexPath.item];
    cell.model = model;
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float w = self.collectionView.frame.size.width;
    self.pageCtrl.currentPage = (self.collectionView.contentOffset.x + w/2) / w;
}

@end
