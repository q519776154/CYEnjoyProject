//
//  CYACCOUNTSetViewController.m
//  CYEnjoyProject
//
//  Created by qianfeng on 16/9/28.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "CYACCOUNTSetViewController.h"
#import "CYConfig.h"
#import "CYAccountTableViewCell.h"



@interface CYACCOUNTSetViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,weak)UITableView *tableView;

@property (nonatomic,weak)UIView *footerView;

@property (nonatomic,weak)UIImageView *headView;

@property (nonatomic, weak) UIImage *iconImage;

@property (nonatomic)NSArray *textArr;


@end

@implementation CYACCOUNTSetViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (UIImage *)iconImage
{
    if (!_iconImage) {
        UIImage *image = [[UIImage alloc] init];
        _iconImage = image;
    }
    return _iconImage;
}

- (id)initialize
{
    self.navigationController.navigationBarHidden=NO;
    self.navigationController.navigationBar.backgroundColor = kColor(217, 217, 217);
    self.navigationItem.title = @"账户设置";
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_2"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    return self;
}

- (UIView *)footerView
{
    if (!_footerView) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,60)];
        
        UIButton *button = [[UIButton alloc] init];
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(20, 10, self.view.frame.size.width - 40, 40);
        button.layer.cornerRadius = 5;
        button.clipsToBounds = YES;
        button.backgroundColor = [UIColor blackColor];
        [button setTitle:@"退出登录" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(comeOutAlertView) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        [self.view addSubview:view];
        _footerView = view;
    }
    return _footerView;
}
- (UITableView *)tableView
{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        [self.view addSubview:tableView];
        tableView.tableFooterView = self.footerView;

        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [tableView registerNib:[UINib nibWithNibName:@"CYAccountTableViewCell" bundle:nil] forCellReuseIdentifier:@"account"];
        _tableView = tableView;
    }
    return _tableView;
}
- (UIImageView *)headView
{
    if (!_headView) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"double_line_10x3_"]];
        imageView.frame = CGRectMake(2, 50, self.view.frame.size.width - 40,0);
        [self.view addSubview:imageView];
        _headView = imageView;
    }
    return _headView;
}
- (NSArray *)textArr
{
    if (!_textArr) {
        _textArr = [NSArray array];
    }
    return _textArr;
}

- (void)comeOutAlertView
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"是否确认退出" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil] ;
    [alert show];
}

- (void)back

{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initialize];
    [self tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 更换头像
- (void)seclectHeadImageFromPhoto
{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"更换头像" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"立即拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self imageFromCamera];
    }];
    
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"从相册中获取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self imageFromPhoto];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertController addAction:cameraAction];
    [alertController addAction:photoAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)imageFromCamera
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"拍照功能不可用" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil] show];
        return;
    }
    [self initImagePickerControllerWithSourceType:UIImagePickerControllerSourceTypeCamera];
}

- (void)initImagePickerControllerWithSourceType:(UIImagePickerControllerSourceType)sourceType
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = sourceType;
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    [self presentViewController:imagePickerController animated:YES completion:nil];
    
    
}

- (void)imageFromPhoto
{
    [self initImagePickerControllerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 5;
    }else
    {
        return 2;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    
    if (indexPath.section == 0) {
        if ( indexPath.row == 0) {
           CYAccountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"account"];
            if (!cell) {
                cell = [[NSBundle mainBundle] loadNibNamed:@"CYAccountTableViewCell" owner:nil options:nil][0];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.headImageButton.image = self.iconImage;
            return cell;
        }
        else
        {
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        
        self.textArr = @[@"邮箱",@"昵称",@"称谓",@"地址管理"];
        cell.textLabel.text = self.textArr[indexPath.row  - 1];
            cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = 1;

        cell.detailTextLabel.textColor = [UIColor lightGrayColor];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        cell.detailTextLabel.text = @"未设置";
        cell.detailTextLabel.textColor = [UIColor lightGrayColor];
        return cell;
        }
    }else if (indexPath.section == 1)
    {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.textLabel.text = self.textArr[indexPath.row];
        self.textArr = @[@"手机号",@"密码"];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.accessoryType = 1;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        cell.detailTextLabel.textColor = [UIColor lightGrayColor];
        cell.detailTextLabel.text = @"未设置";
        return cell;
    }
    else
    {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        self.textArr = @[@"新浪微博",@"微信"];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.text = self.textArr[indexPath.row];
        cell.accessoryType = 1;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        cell.detailTextLabel.text = @"未登录";
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        [self seclectHeadImageFromPhoto];
    }
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        
        return  @"个人资料";
    }
    if (section == 1) {
        return  @"账号安全";
    }
    else
    {
        return @"其他登录方式";
    }
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0 &&indexPath.row == 0 ) {
        return 70;
    }
    else
    {
        return 44;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 60;
   
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *editImage = info[UIImagePickerControllerEditedImage];
    
    self.iconImage = editImage;
    
    if (_headImageCallBack) {
        _headImageCallBack(editImage);
    }
    
    [self.tableView reloadData];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


@end
