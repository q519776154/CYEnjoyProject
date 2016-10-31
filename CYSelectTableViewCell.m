//
//  CYSelectTableViewCell.m
//  CYEnjoyProject
//
//  Created by qianfeng on 16/9/28.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "CYSelectTableViewCell.h"
#import "CYSelectImageCollectionViewCell.h"
#import "CYButtonCollectionViewCell.h"
#import "NSString+Size.h"
#import "UIImageView+WebCache.h"
#import "CYORGANIZEDModel.h"
#import "CYButtonCollectionViewCell.h"
#import "CYConfig.h"

@interface CYSelectTableViewCell () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *titleImageView;

@end

@implementation CYSelectTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 0;
        layout.sectionInset = UIEdgeInsetsMake(0, 10, 10, 10);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollEnabled = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsVerticalScrollIndicator = NO;
        [_collectionView registerClass:[CYSelectImageCollectionViewCell class] forCellWithReuseIdentifier:@"CYSelectImageCollectionViewCell"];
        [_collectionView registerNib:[UINib nibWithNibName:@"CYButtonCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CYButtonCollectionViewCell"];
        
        [self.contentView addSubview:_collectionView];
        //_collectionView = collectView;
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:17];
        [self.contentView addSubview:_titleLabel];
        
        UIImageView *imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:imageView];
        _titleImageView = imageView;
        
    }
    return self;
}

- (void)setSelectModel:(CYLocalSelectModel *)selectModel
{
    _selectModel = selectModel;
    [self.titleImageView sd_setImageWithURL:[NSURL URLWithString:selectModel.img_title]];
    self.titleLabel.text = selectModel.title;
    
    
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize size = [self.selectModel.title sizeWithFontSize:17 maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    float imageW = 40;
    float imageH = 20;
    float space = 5;
    self.titleImageView.frame = CGRectMake(self.contentView.frame.size.width/2 - (size.width+imageW+space)/2, 20, imageW, imageH);
    self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.titleImageView.frame)+5, 20, size.width, size.height);
    
    self.collectionView.frame = CGRectMake(0, 60, self.contentView.frame.size.width, self.selectModel.cellHeight - 60);
    
}

#pragma mark - delegate/datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.selectModel.organizedModelArr.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView    cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item < self.selectModel.small_icon_list.count)
    {
        CYButtonCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CYButtonCollectionViewCell" forIndexPath:indexPath];
        CYORGANIZEDModel *model = self.selectModel.organizedModelArr[indexPath.item];
        cell.model = model;
        return cell;
    }
    else
    {
        CYSelectImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CYSelectImageCollectionViewCell" forIndexPath:indexPath];
        CYORGANIZEDModel *model = self.selectModel.organizedModelArr[indexPath.item];
        cell.model = model;
        return cell;

    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item < self.selectModel.small_icon_list.count)
    {
        CGSize size = CGSizeMake((self.contentView.frame.size.width-20)/3, (self.contentView.frame.size.width-20)/3);
//        NSLog(@"%@", NSStringFromCGSize(size));
        return size;
        
    }
    else
    {
        float imageW = kScreenW-20;
        float imageH = imageW *720/1080;
//        NSLog(@"%f----%f", imageW, imageH);
        
        return CGSizeMake(imageW, imageH);
    }
}


@end
