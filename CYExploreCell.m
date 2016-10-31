//
//  CYExploreCell.m
//  CYEnjoyProject
//
//  Created by qianfeng on 16/9/26.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "CYExploreCell.h"
#import "CYExploreCell1.h"
#import "UIImageView+WebCache.h"
#import "CYConfig.h"

@interface CYExploreCell () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *icon;


@property (weak, nonatomic) IBOutlet UIImageView *product_image;

@property (weak, nonatomic) IBOutlet UIImageView *first_pre_icon;

@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *price;

@property (weak, nonatomic) IBOutlet UILabel *original_price;



@property (nonatomic, strong) NSMutableArray *collectionArr;

@property (nonatomic, weak) UICollectionView *collectionView;


@end

@implementation CYExploreCell

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
    
        
    }
    return self;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:layout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:collectionView];
        
        [collectionView registerNib:[UINib nibWithNibName:@"CYExploreCell1" bundle:nil] forCellWithReuseIdentifier:@"CYExploreCell"];
        _collectionView = collectionView;

    }
    return _collectionView;
}

- (NSMutableArray *)collectionArr
{
    if (!_collectionArr) {
        _collectionArr = [NSMutableArray array];
    }
    return _collectionArr;
}

- (void)setCyModel:(CYExploreModel *)cyModel;
{
    [self.icon sd_setImageWithURL:[NSURL URLWithString:cyModel.icon]];

    [self.first_pre_icon sd_setImageWithURL:[NSURL URLWithString:cyModel.first_pre_icon]];
    self.first_pre_icon.frame =CGRectMake(0, 0, 20, 10);
   
    self.titleLabel.text = cyModel.title;
    CYExploreModel1 *cyModel1 = cyModel.cyModel1Arr[0];
    
    [self.product_image sd_setImageWithURL:[NSURL URLWithString:cyModel.image]];
    
    NSString *s = [NSString stringWithFormat:@"%@", cyModel1.price];
    NSInteger price = [s integerValue];
    self.price.text = [NSString stringWithFormat:@"%ld元/%@",price/100,cyModel1.entity_name];
    self.name.text = cyModel1.name;
    
    NSString *s1 = [NSString stringWithFormat:@"%@", cyModel1.original_price];
    NSInteger price1 = [s1 integerValue];
    self.original_price.text = [NSString stringWithFormat:@"¥%ld",price1/100];
    
    if (![s1 isEqualToString:@"0"]) {
        NSMutableAttributedString *newPrice = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",self.original_price.text]];
        [newPrice addAttribute:NSStrikethroughStyleAttributeName  value:@( NSUnderlineStyleThick) range:NSMakeRange(0, self.original_price.text.length)];
        self.original_price.attributedText = newPrice;
    }
    else
    {
        self.original_price.text = nil;
    }
    
    self.collectionArr = nil;
    
    for (int i =0; i < cyModel.cyModel1Arr.count; i++) {
        if (i > 0) {
            [self.collectionArr addObject:cyModel.cyModel1Arr[i]];
        
        }
    }
    
    [self.collectionView reloadData];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    flowLayout.itemSize = CGSizeMake(150, 195);
    self.collectionView.frame = CGRectMake(0, 300, self.contentView.frame.size.width, 220);
}
#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.collectionArr.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CYExploreCell1 *cyExCell1 = [collectionView dequeueReusableCellWithReuseIdentifier:@"CYExploreCell" forIndexPath:indexPath];
    
    CYExploreModel1 *cyModel = self.collectionArr[indexPath.item];
    
    cyExCell1.cyModel1 = cyModel;
    cyExCell1.index = indexPath.item +2;
    
    return cyExCell1;
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
