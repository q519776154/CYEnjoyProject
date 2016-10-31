//
//  CYRoundButtonTableViewCell.m
//  CYEnjoyProject
//
//  Created by qianfeng on 16/9/28.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "CYRoundButtonTableViewCell.h"
#import "CYRoundButtonCollectionViewCell.h"

@interface CYRoundButtonTableViewCell () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation CYRoundButtonTableViewCell

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(0, 10, 10, 10);
        layout.minimumLineSpacing = 20;
        layout.scrollDirection =UICollectionViewScrollDirectionHorizontal;
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.backgroundColor = [UIColor clearColor];
        [collectionView registerNib:[UINib nibWithNibName:@"CYRoundButtonCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CYRoundButtonCollectionViewCell"];
        [self.contentView addSubview:collectionView];
        _collectionView = collectionView;
    }
    return _collectionView;
}

//- (TAPageControl *)pageCtrl
//{
//    if (!_pageCtrl) {
//        TAPageControl *page = [[TAPageControl alloc] init];
//        page.dotImage = [UIImage imageNamed:@"oval_icon_normal_5x5_"];
//        page.currentDotImage = [UIImage imageNamed:@"oval_icon_highlighted_5x5_"];
//        [self.contentView addSubview:page];
//        _pageCtrl =page;
//    }
//    return _pageCtrl;
//}


- (void)setSelectModel:(CYLocalSelectModel *)selectModel
{
    _selectModel = selectModel;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    float itemW = (self.contentView.frame.size.width-40)/3.5;
    layout.itemSize = CGSizeMake(itemW, itemW+30);
    self.collectionView.frame = self.contentView.frame;
    
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.selectModel.organizedModelArr.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView    cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CYRoundButtonCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CYRoundButtonCollectionViewCell" forIndexPath:indexPath];
    
    CYORGANIZEDModel *model = self.selectModel.organizedModelArr[indexPath.item];
    
    cell.model = model;
    
    return cell;
    
}


@end
