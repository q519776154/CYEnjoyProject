//
//  CYTAGTableViewCell.m
//  CYEnjoyProject
//
//  Created by qianfeng on 16/9/26.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "CYTAGTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "CYORGANIZEDModel.h"
#import "CYTAGCollectionViewCell.h"
#import "NSString+Size.h"
#import "Masonry.h"

@interface CYTAGTableViewCell () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, weak) UIImageView *arrowImageView;
@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation CYTAGTableViewCell

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *imageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_arrow_right_5x5_"]];
        [self.contentView addSubview:imageview];
        _arrowImageView = imageview;
        
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:17];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor blackColor];
        [self.contentView addSubview:label];
        _titleLabel = label;
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.backgroundColor = [UIColor clearColor];
        [collectionView registerNib:[UINib nibWithNibName:@"CYTAGCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CYTAGCollectionViewCell"];
        [self.contentView addSubview:collectionView];
        _collectionView = collectionView;
    }
    return self;
}

- (void)setSelectModel:(CYLocalSelectModel *)selectModel
{
    _selectModel = selectModel;
    self.titleLabel.text = selectModel.title;
    self.dataSource = nil;
    [selectModel.organizedModelArr enumerateObjectsUsingBlock:^(CYORGANIZEDModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.dataSource addObject:obj];
//        NSLog(@"idx ---- %ld", idx);
    }];
    
    [self.collectionView reloadData];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGSize size = [self.titleLabel.text sizeWithFontSize:17 maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    self.titleLabel.bounds = CGRectMake(0, 0, size.width, size.height);
    self.titleLabel.center = CGPointMake(self.contentView.frame.size.width/2, 30);
    self.arrowImageView.bounds = CGRectMake(0, 0, 5, 5);
    self.arrowImageView.center = CGPointMake(CGRectGetMaxX(self.titleLabel.frame) + 5, 30);
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    layout.itemSize = CGSizeMake(300, 290);
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView.mas_leading);
        make.right.equalTo(self.contentView.mas_right);
        make.height.equalTo(self.contentView.mas_height).with.offset(-60);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];

    self.collectionView.contentOffset = CGPointMake(0, 0);
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView    cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CYTAGCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CYTAGCollectionViewCell" forIndexPath:indexPath];
    
    CYORGANIZEDModel *model = self.dataSource[indexPath.item];
    
    cell.model = model;
    
    return cell;
    
}



@end
