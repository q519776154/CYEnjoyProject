//
//  CYLIMITTableViewCell.m
//  CYEnjoyProject
//
//  Created by qianfeng on 16/9/27.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "CYLIMITTableViewCell.h"
#import "CYLIMITCollectionViewCell.h"
#import "CYConfig.h"

@interface CYLIMITTableViewCell () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation CYLIMITTableViewCell

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.backgroundColor = kColor(245, 245, 245);
        
        [collectionView registerNib:[UINib nibWithNibName:@"CYLIMITCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CYLIMITCollectionViewCell"];
        [self.contentView addSubview:collectionView];
        _collectionView = collectionView;

    }
    return _collectionView;
}

- (void)setOrganizedModelArr:(NSArray *)organizedModelArr
{
    _organizedModelArr = organizedModelArr;
    self.dataSource = [NSMutableArray arrayWithArray:organizedModelArr];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView    cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CYLIMITCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CYLIMITCollectionViewCell" forIndexPath:indexPath];
    
    CYORGANIZEDModel *model = self.dataSource[indexPath.item];
    
    cell.model = model;
    
    return cell;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    layout.itemSize = CGSizeMake(300, 129);
    
    self.collectionView.frame = self.contentView.bounds;
    
    self.collectionView.contentOffset = CGPointMake(0, 0);
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
