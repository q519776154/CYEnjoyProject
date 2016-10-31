//
//  CYChooseViewController.m
//  CYEnjoyProject
//
//  Created by qianfeng on 16/9/24.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "CYChooseViewController.h"
#import "CYConfig.h"
#import "CYNavigationScrollerBar.h"
#import "CYLocationManager.h"
#import "CYCenterButton.h"
#import "CYCityListViewController.h"
#import "CYCity.h"

@interface CYChooseViewController () <UIScrollViewDelegate>

@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, weak) CYNavigationScrollerBar *navigationBar;
@property (nonatomic, weak) UIScrollView *contentScrollView;
@property (nonatomic, strong) NSMutableArray *childControllersTitles;

@property (nonatomic, weak) CYCenterButton *centerButton;
@end

@implementation CYChooseViewController

- (UIScrollView *)contentScrollView
{
    if (!_contentScrollView) {
        UIScrollView *scView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kCYNavigationScrollerViewHeight, self.view.bounds.size.width, self.view.frame.size.height - kCYNavigationScrollerViewHeight - 64 - 49)];
        scView.contentSize = CGSizeMake(self.childControllersTitles.count * kScreenW, kScreenH - kCYNavigationScrollerViewHeight - 64 - 49);
//        NSLog(@"%@", NSStringFromCGSize(scView.contentSize));
        scView.pagingEnabled = YES;
        scView.bounces = NO;
        scView.delegate = self;
        [self.view addSubview:scView];
        _contentScrollView = scView;
    }
    return _contentScrollView;
}



- (NSMutableArray *)childControllersTitles
{
    if (!_childControllersTitles) {
        _childControllersTitles = [NSMutableArray arrayWithArray:@[@"本地精选",@"全国送",@"酒",@"家居",@"食品",@"咖啡"]];
    }
    return _childControllersTitles;
}

- (CYNavigationScrollerBar *)navigationBar
{
    if (!_navigationBar) {
        CYNavigationScrollerBar *bar = [CYNavigationScrollerBar NavigationScrollerBarWithTitles:self.childControllersTitles completeWithCallBack:^(NSInteger index)
        {
//            NSLog(@"%ld", index);
            self.currentIndex = index;
            [self setupOneViewController:index];
            CGFloat x = index * [UIScreen mainScreen].bounds.size.width;
            self.contentScrollView.contentOffset = CGPointMake(x, 0);
        }];
        bar.frame = CGRectMake(0, 0, self.view.bounds.size.width, kCYNavigationScrollerViewHeight);
        bar.titleFont = 15;
        bar.bottomLineHeight = 8;
        [self.view addSubview:bar];
        _navigationBar = bar;
    }
    return _navigationBar;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = NO;
    
    [self initChildControllers];
    [self navigationBar];
    
    //启动服务
    [[CYLocationManager sharedLocationManager] startLocationService:^(CLPlacemark *placemark) {
        
        //1.获取城市和经纬度
//        NSString *city = placemark.locality;
//        NSLog(@"%@",placemark);
        [self initCenterBarButtonWithTitle:@"深圳"];
        
        //2.请求首页数据
    }];

    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.000001 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationBar clickNavigationButtonFromIndex:0];
    });

}

//navigationBarTitleView
- (void)initCenterBarButtonWithTitle:(NSString *)title
{
    CYCenterButton *button = [CYCenterButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 0, 30);
    [button setTitleColor:kAppTintColor forState:UIControlStateNormal];
    [button addTarget:self action:@selector(cityListViewController) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor redColor];
    [button setTitle:title forState:UIControlStateNormal];
    self.navigationItem.titleView = button;
    _centerButton = button;
}

- (void)cityListViewController
{
    CYCityListViewController *cityListCtrl = [[CYCityListViewController alloc] init];
    [cityListCtrl setCityListViewControllerDidSelectCityCallback:^(CYCity *city) {
        
        //修改城市
        [self.centerButton setTitle:city.name forState:UIControlStateNormal];
    }];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:cityListCtrl];
    /*
     //当navigationBar设置背景图片的时候translucent会默认关闭
     [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"AppIcon29x29.png"] forBarMetrics:UIBarMetricsDefault];
     nav.navigationBar.translucent = YES;
     */
    [self presentViewController:nav animated:YES completion:nil];

}

#pragma mark - 创建子控制器
- (void)initChildControllers
{
    NSArray *ctrlNames = @[
                           @"CYLocalViewController",
                           @"CYNationViewController",
                           @"CYWineViewController",
                           @"CYHomeViewController",
                           @"CYFoodViewController",
                           @"CYCoffeeViewController"];
    
    [ctrlNames enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIViewController *ctrl = [[NSClassFromString(obj) alloc] init];
        [self addChildViewController:ctrl];
        ctrl.title = self.childControllersTitles[idx];

        }];
    

}

#pragma mark - 添加一个子控制器
- (void)setupOneViewController:(NSInteger)i
{
    UIViewController *vc = self.childViewControllers[i];
    if (vc.view.superview) {
        return;
    }
    CGFloat x = i * kScreenW;
    vc.view.frame = CGRectMake(x, 0, kScreenW , self.contentScrollView.bounds.size.height);
    [self.contentScrollView addSubview:vc.view];
}

#pragma mark - contentViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //先获取当前属于哪一个控制器页面
    NSInteger i = scrollView.contentOffset.x / kScreenW;
    //点击按钮
    [self.navigationBar clickNavigationButtonFromIndex:i];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //为了良好的用户体验,拖到哪儿就加载哪儿,哈哈
//    NSLog(@"didScroll == %.2f", scrollView.contentOffset.x);
    NSInteger i = scrollView.contentOffset.x / kScreenW;
    if (scrollView.contentOffset.x > self.currentIndex) {
        [self setupOneViewController:MIN(self.childControllersTitles.count - 1, i+1)];
    }
    [self setupOneViewController:MAX(0, i-1)];
}


@end
