//
//  CYCenterTitleTableViewCell.m
//  CYEnjoyProject
//
//  Created by qianfeng on 16/9/29.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "CYCenterTitleTableViewCell.h"
#import "CYCenterTitleCollectionViewCell.h"

@interface CYCenterTitleTableViewCell () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation CYCenterTitleTableViewCell

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
    layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView *collectView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:layout];
    collectView.delegate = self;
    collectView.dataSource = self;
    collectView.pagingEnabled = YES;
    collectView.backgroundColor = [UIColor clearColor];
    collectView.showsHorizontalScrollIndicator = NO;
    [collectView registerNib:[UINib nibWithNibName:@"CYCenterTitleCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CYCenterTitleCollectionViewCell"];
    [self.contentView addSubview:collectView];
    _collectionView = collectView;
}

- (void)setSelectModel:(CYLocalSelectModel *)selectModel
{
    _selectModel = selectModel;
    
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    layout.itemSize = CGSizeMake(self.contentView.frame.size.width/3+10, self.contentView.frame.size.width/3+10);
    self.collectionView.frame = self.contentView.frame;
}

#pragma mark - delegate/datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.selectModel.organizedModelArr.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView    cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CYCenterTitleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CYCenterTitleCollectionViewCell" forIndexPath:indexPath];
    CYORGANIZEDModel *model = self.selectModel.organizedModelArr[indexPath.item];
    cell.model = model;
    return cell;
}

@end
