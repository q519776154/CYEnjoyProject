//
//  CYBaseTabbarController.m
//  CYEnjoyProject
//
//  Created by qianfeng on 16/9/24.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "CYBaseTabbarController.h"
#import "CYConstConfig.h"

@interface CYBaseTabbarController ()

@end

@implementation CYBaseTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:kAppTintColor } forState:UIControlStateSelected];
    
    [self initChildrenController];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)initChildrenController
{
    NSArray *ctrlNames = @[
                           @"CYChooseViewController",
                           @"CYExploreViewController",
                           @"CYShoppingCarViewController",
                           @"CYMyViewController"];
    
    NSArray *titles = @[@"精选",@"发现",@"购物车",@"我的"];
    NSArray *normalImageNames = @[
                                  @"tab_home_25x25_",
                                  @"tab_explore_n_25x25_",
                                  @"tab_cart_25x25_",
                                  @"tab_me_25x25_"];
    NSArray *selectedImageNames = @[
                                @"tab_home_selected_25x25_",
                                    @"tab_explore_h_25x25_",
                                @"tab_cart_selected_25x25_",
                                    @"tab_me_selected_25x25_"];
    
    
    [ctrlNames enumerateObjectsUsingBlock:^(NSString *ctrlName, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIViewController *ctrl = [[NSClassFromString(ctrlName) alloc] init];
        ctrl.title = titles[idx];
        ctrl.tabBarItem.image = [UIImage imageNamed:normalImageNames[idx]];
        ctrl.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageNames[idx]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:ctrl];
        
        //添加子控制器
        [self addChildViewController:nav];
    }];

    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
