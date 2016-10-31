//
//  CYCYExploreCell3.m
//  CYEnjoyProject
//
//  Created by qianfeng on 16/9/27.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "CYExploreCell3.h"
#import "NSString+Size.h"
#import "CYExploreCell4.h"

@interface CYExploreCell3 ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic,weak) UICollectionView *collectionView;

@property (nonatomic,strong) NSMutableArray *collectArr;

@end

@implementation CYExploreCell3

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:layout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:collectionView];
        
        [collectionView registerNib:[UINib nibWithNibName:@"CYExploreCell4" bundle:nil] forCellWithReuseIdentifier:@"CYExploreCell4"];
        _collectionView = collectionView;
    }
    return _collectionView;

}

- (NSMutableArray *)collectArr
{
    if (!_collectArr) {
        _collectArr = [NSMutableArray array];
    }
    return _collectArr;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    flowLayout.itemSize = CGSizeMake(100, 120);
    self.collectionView.frame = CGRectMake(0, 20, self.contentView.frame.size.width , 150);

    
    self.titleLabel.frame = CGRectMake(self.contentView.center.x , 10, 60, 20);
    [self.collectionView reloadData];
}

- (void)setCyeModel:(CYExploreModel *)cyeModel
{
    _cyeModel = cyeModel;
    self.titleLabel.text = cyeModel.title;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.cyeModel.cyModel1Arr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CYExploreCell4 *cyExCell4 = [collectionView dequeueReusableCellWithReuseIdentifier:@"CYExploreCell4" forIndexPath:indexPath];
    
    CYExploreModel1 *cyModel = self.cyeModel.cyModel1Arr[indexPath.item];

    cyExCell4.cyeModel1 = cyModel;
    
    return cyExCell4;
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
