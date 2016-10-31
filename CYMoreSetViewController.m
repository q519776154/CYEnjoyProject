//
//  CYMoreSetViewController.m
//  CYEnjoyProject
//
//  Created by qianfeng on 16/10/7.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "CYMoreSetViewController.h"
#import "CYConfig.h"
#import "CYACCOUNTSetViewController.h"
#import "SDImageCache.h"

@interface CYMoreSetViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,weak)UITableView *tableView;

@property (nonatomic,strong) NSArray *textArray;

@property (nonatomic,copy)UILabel *detailLabel;

@end

@implementation CYMoreSetViewController

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
    self.navigationItem.title = @"更多设置";
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_2"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    return self;
}
- (void)back

{
    [self.navigationController popViewControllerAnimated:NO];
}

- (UITableView *)tableView
{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        [self.view addSubview:tableView];
        
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        _tableView = tableView;
        }
        return _tableView;
}

- (NSArray *)textArray
{
    if (!_textArray) {
        _textArray = [NSArray array];
    }
    return _textArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initialize];
    [self tableView];
    self.tableView.tableFooterView = [[UIView alloc] init];
    
}

- ( long long ) fileSizeAtPath:( NSString *) filePath{
    
    NSFileManager * manager = [ NSFileManager defaultManager ];
    if ([manager fileExistsAtPath :filePath]){
        return [[manager attributesOfItemAtPath :filePath error : nil ] fileSize ];
    }
    return 0 ;
    
}
- ( float ) folderSizeAtPath:( NSString *) folderPath{
    
    NSFileManager * manager = [ NSFileManager defaultManager ];
    
    if (![manager fileExistsAtPath :folderPath]) return 0 ;
    
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath :folderPath] objectEnumerator ];
    
    NSString * fileName;
    
    long long folderSize = 0 ;
    
    while ((fileName = [childFilesEnumerator nextObject ]) != nil ){
        
        NSString * fileAbsolutePath = [folderPath stringByAppendingPathComponent :fileName];
        
        folderSize += [ self fileSizeAtPath :fileAbsolutePath];
        
    }
    
    return folderSize/( 1024.0 * 1024.0 );
    
}
- ( float )filePath
{
NSString * cachPath = [ NSSearchPathForDirectoriesInDomains ( NSCachesDirectory , NSUserDomainMask , YES ) firstObject ];
    
    return [ self folderSizeAtPath :cachPath];
    
}
- (void)clearCache
{
    NSString * cachPath = [ NSSearchPathForDirectoriesInDomains ( NSCachesDirectory , NSUserDomainMask , YES ) firstObject ];
    
    NSArray * files = [[ NSFileManager defaultManager ] subpathsAtPath :cachPath];
    
    NSLog ( @"cachpath = %@" , cachPath);
    
    for ( NSString * p in files) {
        NSError * error = nil ;
        NSString * path = [cachPath stringByAppendingPathComponent :p];
        if ([[ NSFileManager defaultManager ] fileExistsAtPath :path]) {
            [[ NSFileManager defaultManager ] removeItemAtPath :path error :&error];
        }
    }

    [ self performSelectorOnMainThread : @selector (clearCachSuccess) withObject :nil waitUntilDone : YES ];
    
    
}
- ( void )clearCachSuccess

{
    UIAlertView * alertView = [[ UIAlertView alloc ] initWithTitle : @" 提示 " message : @" 缓存清理完毕 " delegate : nil cancelButtonTitle : @" 确定 " otherButtonTitles : nil ];
    [alertView show ];
    [ _tableView reloadData];
}

- (void)comeOutAlertView
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"是否清除缓存" delegate:nil cancelButtonTitle:@"否" otherButtonTitles:@"是", nil] ;
    [alert show];
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        return;
    }
    else
    {
        [self clearCache];
    }
}

- (void)enterAccountMessageController
{
    CYACCOUNTSetViewController *acconutController = [[CYACCOUNTSetViewController alloc] init];
    [self.navigationController pushViewController:acconutController animated:NO];
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    self.textArray = @[@"个人设置",@"推送设置",@"清除图片缓存",@"开源许可证",@"关于"];
    cell.textLabel.text = self.textArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 2) {
        cell.detailTextLabel.text = [ NSString stringWithFormat : @"%.2fM" , [self filePath]];
        cell.detailTextLabel.textColor = [UIColor blackColor];
    }else
    {
        cell.accessoryType = 1;
        cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    }
   
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        [self enterAccountMessageController];
    }
    else if (indexPath.row == 2)
    {
        [self comeOutAlertView];
    }
}


@end
