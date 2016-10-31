//
//  CYShoppingCarViewController.m
//  CYEnjoyProject
//
//  Created by qianfeng on 16/9/24.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "CYShoppingCarViewController.h"
#import "HttpRequest.h"
#import "AFNetworking.h"
#import "MJRefresh.h"
#import "NSString+Size.h"
#import "CYExploreModel1.h"
#import "CYShoppingCarCollectionViewCell.h"
#import "CYShoppingCarGoods.h"
#import "CYShoppingCarBottomView.h"
#import "CYShppingCarGoodsManager.h"
#import "CYShoppingCarContentView.h"
@interface CYShoppingCarViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    CYShoppingCarBottomView *_shoppingCarBottomView;
}

@property (nonatomic,strong) NSMutableArray *shoppingCarArray;

@property (nonatomic, weak) CYShoppingCarContentView *shoppingCarContentView;

@property (nonatomic,weak)UICollectionView *collectionView;

@property (nonatomic,strong)NSMutableArray *dataSource;

@property (nonatomic,weak)UIView *headView;

@end

@implementation CYShoppingCarViewController

- (CYShoppingCarContentView *)shoppingCarContentView
{
    if (!_shoppingCarContentView)
    {
        CYShoppingCarContentView *shoppingCarContentView = [[CYShoppingCarContentView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64)];
        [self.view addSubview:shoppingCarContentView];
        
        _shoppingCarContentView = shoppingCarContentView;
    }
    
    return _shoppingCarContentView;
}
#pragma mark - 计算总价格
- (CGFloat)totalPrice
{
    CGFloat sum = 0;
    
    for (CYShoppingCarGoods *goods in self.shoppingCarArray)
    {
        //选中的商品才计算价格
        if (goods.isSelected)
        {
            sum += ([goods.price integerValue] * goods.number);
        }
    }
    
    return sum;
}

- (UIView *)headView
{
    if (!_headView) {
        CGFloat imageWidth = 160;
        CGFloat imageHeight = imageWidth;
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"empty_cart_icon_170x178_"]];
        
        imageView.frame = CGRectMake(self.view.frame.size.width/2 - imageWidth/2, 200 - imageHeight/2, imageWidth, imageHeight);

        [self.view addSubview:imageView];
        
        _headView = imageView;
    }
 return _headView;
}

- (UICollectionView *)collectionView
{
    
    if (!_collectionView) {
        CGFloat itemWidth = (CGRectGetWidth(self.view.frame) - 10 * 3)/2;
        CGFloat itemHeight = itemWidth;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(20, 10, 0, 10);
        layout.itemSize = CGSizeMake(itemWidth, itemHeight);
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:layout];
        collectionView.delegate = self;
        collectionView.dataSource = self;

        collectionView.backgroundColor = [UIColor clearColor];
        
        UIImageView *view1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"endline_left_25x2_"]];
        view1.frame = CGRectMake(10, 10, self.view.frame.size.width/2 - 40, 2);
        UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(view1.frame)+15, 0, 40, 20)];
        l.text = @"推荐";
        UIImageView *view2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"endline_right_25x2_"]];
        view2.frame = CGRectMake(CGRectGetMaxX(l.frame)+10, 10, self.view.frame.size.width/2-40, 2);
        [collectionView addSubview:view1];
        [collectionView addSubview:l];
        [collectionView addSubview:view2];
        [self.view addSubview:collectionView];
        
        [collectionView registerNib:[UINib nibWithNibName:@"CYShoppingCarCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"carCell"];
        _collectionView = collectionView;
        
    }
    return _collectionView;
}

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    
    return _dataSource;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self collectionView];
    [self headView];
//    //1.获取购物车数据
//    self.shoppingCarArray = [[CYShppingCarGoodsManager shareManager] queryAllShoppingGoodsInShoppingCar];
//    
//    //2.刷新界面
//    self.shoppingCarContentView.shoppingCarArray = self.shoppingCarArray;
//    
//    //3.创建bottomView
//    [self initShoppingCarBottomView];
//
    
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusReachableViaWWAN) {
            [self requestDataFromNetworking];
        }
        else
        {
            [self requestDataFromNetworking];
        }
    }];
    [manager startMonitoring];
    
}

/**
 *  创建bottomView
 */
- (void)initShoppingCarBottomView
{
    CYShoppingCarBottomView *shoppingCarBottomView = [CYShoppingCarBottomView shoppingCarBottomViewWithFrame:CGRectMake(0, self.view.frame.size.height  - 64, self.view.frame.size.width, 60)];
    [shoppingCarBottomView setCYShoppingCarBottomViewDidClickSelectAllButtonCallBack:^(BOOL selectAll) {
        //1.把所有的商品的select = yes
        for (CYShoppingCarGoods *goods in self.shoppingCarArray)
        {
            goods.selected = selectAll;
        }
        
        //2.刷新tableView
        [self.shoppingCarContentView reloadData];
        
        //3.计算总价格
        _shoppingCarBottomView.totalPrice = [self totalPrice];
        
    }];
    [self.view addSubview:shoppingCarBottomView];
    
    _shoppingCarBottomView = shoppingCarBottomView;
}



- (void)requestDataFromNetworking
{
    [HttpRequest GET:[NSString stringWithFormat:@"https://open.seriousapps.cn/3/enjoy_product/cart_recommend_product.json?city_id=299"] paramters:nil success:^(id responseObject) {
        
        [self handleDataObjectWithResponseObject:responseObject];
        
    } failure:^(NSError *error) {
        
        
    }];
    
}

- (void)handleDataObjectWithResponseObject:(id)responseObject
{
    NSArray *arr = responseObject[@"content"];
    for (NSDictionary *dic in arr) {
        CYExploreModel1 *cyeModel1 = [CYExploreModel1 modelWithDictionary:dic];
        [self.dataSource addObject:cyeModel1];
      }
    
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CYShoppingCarCollectionViewCell *carCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"carCell" forIndexPath:indexPath];
    
    CYExploreModel1 *cyModel = self.dataSource[indexPath.item];
    
    carCell.cyeModel1 = cyModel;
    
    
    return carCell;
}




@end
