//
//  CYENJOYViewController.m
//  CYEnjoyProject
//
//  Created by qianfeng on 16/9/28.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "CYMessageCenterViewController.h"
#import "CYConfig.h"
@interface CYMessageCenterViewController ()

@end

@implementation CYMessageCenterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (id)initialize
{
    self.navigationController.navigationBarHidden=NO;
    self.navigationController.navigationBar.backgroundColor = kColor(217, 217, 217);
    self.navigationItem.title = @"消息中心";
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_2"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"empty_home_refresh_icon_170x160_"]];
    imageView.layer.cornerRadius = CGRectGetWidth(imageView.frame)/2;
    imageView.clipsToBounds = YES;
    imageView.center = self.view.center;
    [self.view addSubview:imageView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"刷新" forState:UIControlStateNormal];
    button.frame = CGRectMake(self.view.frame.size.width/2 - 80/2 , CGRectGetMaxY(imageView.frame)+60, 80, 30);
    [button addTarget:self action:@selector(refreshControl) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initialize];
    
    
    
}
- (void)refreshControl
{
    //TODO::
}


- (void)back
{
    [self.navigationController popViewControllerAnimated:NO];
    
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
