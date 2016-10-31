//
//  CYTAGPlusTableViewCell.m
//  CYEnjoyProject
//
//  Created by qianfeng on 16/9/27.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "CYTAGPlusTableViewCell.h"
#import "CYTAGPlusCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "CYORGANIZEDModel.h"
#import "UIImage+Resize.h"
#import "Masonry.h"
#import "NSString+Size.h"

@interface CYTAGPlusTableViewCell () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, weak) UIImageView *arrowImageView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIImageView *bigImageView;
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, weak) UIImageView *triangleView;

@end

@implementation CYTAGPlusTableViewCell

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
        UIImageView *imageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"triangle_forward_black_5x5_"]];
        [self.contentView addSubview:imageview];
        _arrowImageView = imageview;
        
        UIImageView *big = [[UIImageView alloc] init];
        [self.contentView addSubview:big];
        _bigImageView = big;
        
        UIImageView *triangle = [[UIImageView alloc] init];
        triangle.image = [UIImage imageNamed:@"noti_triangle_26x12_"];
        [self.bigImageView addSubview:triangle];
        _triangleView = triangle;
        
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:17];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor blackColor];
        [self.contentView addSubview:label];
        _titleLabel = label;
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        layout.scrollDirection =UICollectionViewScrollDirectionHorizontal;
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.backgroundColor = [UIColor clearColor];
        [collectionView registerNib:[UINib nibWithNibName:@"CYTAGPlusCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CYTAGPlusCollectionViewCell"];
        [self.contentView addSubview:collectionView];
        _collectionView = collectionView;
    }
    return self;
}


- (void)setSelectModel:(CYLocalSelectModel *)selectModel
{
    _selectModel = selectModel;
    self.titleLabel.text = selectModel.title;
    [self.bigImageView sd_setImageWithURL:[NSURL URLWithString:selectModel.img_url] placeholderImage:[[UIImage imageNamed:@"home_image_placehold"] resizableImage]];
    self.dataSource = nil;
    [selectModel.organizedModelArr enumerateObjectsUsingBlock:^(CYORGANIZEDModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.dataSource addObject:obj];
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
    
    float bigImgH = self.contentView.frame.size.width *334.0/600.0;
    
    self.bigImageView.frame = CGRectMake(0, 60, self.contentView.frame.size.width, bigImgH);
    self.triangleView.bounds = CGRectMake(0, 0, 26, 12);
    self.triangleView.center = CGPointMake(CGRectGetMaxX(self.bigImageView.frame)/2, bigImgH - 6);
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    layout.itemSize = CGSizeMake(135, 135);
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView.mas_leading);
        make.right.equalTo(self.contentView.mas_right);
        make.height.equalTo(@155);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    self.collectionView.contentOffset = CGPointMake(0, 0);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView    cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CYTAGPlusCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CYTAGPlusCollectionViewCell" forIndexPath:indexPath];
    
    CYORGANIZEDModel *model = self.dataSource[indexPath.item];
    
    cell.model = model;
    
    return cell;
    
}

@end
