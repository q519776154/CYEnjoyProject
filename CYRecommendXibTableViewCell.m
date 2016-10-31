//
//  CYRecommendXibTableViewCell.m
//  CYEnjoyProject
//
//  Created by qianfeng on 16/9/29.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "CYRecommendXibTableViewCell.h"
#import "TAPageControl.h"
#import "CYRecommendXibCollectionViewCell.h"
#import "CYConfig.h"

@interface CYRecommendXibTableViewCell () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *recommendLabel;
@property (nonatomic, weak) TAPageControl *pageCtrl;
@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation CYRecommendXibTableViewCell


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
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView *collectView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:layout];
    collectView.delegate = self;
    collectView.dataSource = self;
    collectView.pagingEnabled = YES;
    collectView.backgroundColor = [UIColor clearColor];
    collectView.showsHorizontalScrollIndicator = NO;
    [collectView registerNib:[UINib nibWithNibName:@"CYRecommendXibCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CYRecommendXibCollectionViewCell"];
    [self.contentView addSubview:collectView];
    _collectionView = collectView;
}

- (TAPageControl *)pageCtrl
{
    if (!_pageCtrl) {
        TAPageControl *page = [[TAPageControl alloc] initWithFrame:CGRectMake(0, (kScreenW - 20)*720/1080 + 260, kScreenW, 20)];
        page.dotImage = [UIImage imageNamed:@"oval_icon_normal_5x5_"];
        page.currentDotImage = [UIImage imageNamed:@"oval_icon_highlighted_5x5_"];
        [self.contentView addSubview:page];
        _pageCtrl =page;
    }
    return _pageCtrl;
}


- (void)setSelectModel:(CYLocalSelectModel *)selectModel
{
    _selectModel = selectModel;
    self.recommendLabel.text = [NSString stringWithFormat:@"%@ 丨 %@", selectModel.text.firstObject, selectModel.text.lastObject]; ;
    if (selectModel.organizedModelArr.count <=1) {
        self.pageCtrl.hidden = YES;
    }
    else{
        self.pageCtrl.hidden = NO;
        self.pageCtrl.numberOfPages = selectModel.organizedModelArr.count;
        self.pageCtrl.currentPage = 0;
    }

    
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    layout.itemSize = CGSizeMake(kScreenW - 20, (kScreenW - 20)*720/1080 + 180);

    self.collectionView.frame = CGRectMake(0, 60, kScreenW, (kScreenW - 20)*720/1080 + 200);
}

#pragma mark - delegate/datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.selectModel.organizedModelArr.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView    cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CYRecommendXibCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CYRecommendXibCollectionViewCell" forIndexPath:indexPath];
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
