//
//  CYButtonTableViewCell.m
//  CYEnjoyProject
//
//  Created by qianfeng on 16/9/27.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "CYButtonTableViewCell.h"
#import "CYButtonCollectionViewCell.h"

@interface CYButtonTableViewCell () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation CYButtonTableViewCell

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        UICollectionView *collectView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:layout];
        collectView.delegate = self;
        collectView.dataSource = self;
        collectView.backgroundColor = [UIColor clearColor];
        [collectView registerNib:[UINib nibWithNibName:@"CYButtonCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CYButtonCollectionViewCell"];
        [self.contentView addSubview:collectView];
        _collectionView = collectView;
    }
    return _collectionView;
}

- (void)setOrganizedModelArr:(NSArray *)organizedModelArr
{
    _organizedModelArr = organizedModelArr;
    [self.collectionView reloadData];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    layout.itemSize = CGSizeMake((self.contentView.frame.size.width - 50)/ 4, (self.contentView.frame.size.width - 50) / 4);
    self.collectionView.frame = self.contentView.frame;
}

#pragma mark - delegate/datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.organizedModelArr.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView    cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CYButtonCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CYButtonCollectionViewCell" forIndexPath:indexPath];
    
    CYORGANIZEDModel *model = self.organizedModelArr[indexPath.item];
    
    cell.model = model;
    
    return cell;
    
}


@end
