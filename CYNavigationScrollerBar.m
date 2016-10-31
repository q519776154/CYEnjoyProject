//
//  CYNavigationScrollerBar.m
//  Enjoy
//
//  Created by qianfeng on 16/9/24.
//  Copyright © 2016年 cz. All rights reserved.
//

#import "CYNavigationScrollerBar.h"

#define CYspace 40.0
#define CYedgs  20.0
#define CYfont  17
#define KBottomLineWidth 2
#define KBottomLineHeight 5
#define KTitleDefaultNormalColor [UIColor grayColor]
#define KTitleDefaultSelectedColor [UIColor blackColor]
#define KBottomDefaultLineColor [UIColor blackColor]

@interface CYNavigationScrollerBar ()

@property (nonatomic, weak) UIView *bottomView;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) NSArray *titleArr;
//@property (nonatomic, weak) UIButton *selectButton;


@end

@implementation CYNavigationScrollerBar

- (void)lastButton
{
    _currentIndex -= 1;
    if (_currentIndex < 1) {
        _currentIndex = self.titleArr.count;
    }
    UIButton *btn = [self viewWithTag:_currentIndex];
    [self click:btn];
}

- (void)nextButton
{
    _currentIndex += 1;
    if (_currentIndex > self.titleArr.count) {
        _currentIndex = 1;
    }
    UIButton *btn = [self viewWithTag:_currentIndex];
    [self click:btn];
}

+ (instancetype)NavigationScrollerBarWithTitles:(NSArray *)titles completeWithCallBack:(ClickTitleButtonCallBack)callBack
{
    CYNavigationScrollerBar *bar = [[self alloc] init];
    bar.titleArr = titles;
    bar.callBack = callBack;
    bar.showsVerticalScrollIndicator = NO;
    bar.showsHorizontalScrollIndicator = NO;
    return bar;
}

- (void)setTitleNormalColor:(UIColor *)titleNormalColor
{
    _titleNormalColor = titleNormalColor;
}

- (void)setTitleSelectedColor:(UIColor *)titleSelectedColor
{
    _titleSelectedColor = titleSelectedColor;
}

-(void)setTitleFont:(CGFloat)titleFont
{
    _titleFont = titleFont;
}

- (void)setBottomLineColor:(UIColor *)bottomLineColor
{
    _bottomLineColor = bottomLineColor;
}

- (void)setBottomLineWidth:(CGFloat)bottomLineWidth
{
    _bottomLineWidth = bottomLineWidth;
}

- (void)setBottomLineHeight:(CGFloat)bottomLineHeight
{
    _bottomLineHeight = bottomLineHeight;
}

- (void)setButtonSpace:(CGFloat)buttonSpace
{
    _buttonSpace = buttonSpace;
}
- (void)clickNavigationButtonFromIndex:(NSInteger)index
{
    UIButton *btn = [self viewWithTag:index+1];
    [self click:btn];
}

- (void)setTitleArr:(NSArray *)titleArr
{
    _titleArr = titleArr;

    [self.titleArr enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = idx + 1;
        if (idx == 0) {
            btn.selected = YES;
            //有时间再优化这里TODO:::::::::::::::::::::btn选中颜色的问题
        }
        [btn setTitle:obj forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
       
    }];

    UIView *view = [[UIView alloc] init];
    view.backgroundColor = KBottomDefaultLineColor;
    _bottomView = view;
    [self addSubview:view];
    
    //向左扫的手势
    //    [self.view addGestureRecognizer:[self swipeGestureGecognizerWithDirection:UISwipeGestureRecognizerDirectionLeft]];
    //向右扫的手势
    //    [self.view addGestureRecognizer:[self swipeGestureGecognizerWithDirection:UISwipeGestureRecognizerDirectionRight]];
}

- (NSInteger)currentIndex
{
    if (!_currentIndex) {
        _currentIndex = 1;
    }
    return _currentIndex;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        NSLog(@"%@", NSStringFromCGRect(self.frame));
        _bottomLineWidth = KBottomLineWidth;
        _bottomLineHeight = KBottomLineHeight;
        _titleFont = CYfont;
        _buttonSpace = CYspace;
        _titleNormalColor = KTitleDefaultNormalColor;
        _titleSelectedColor = KTitleDefaultSelectedColor;
        _bottomLineColor = KBottomDefaultLineColor;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
//    NSLog(@"%@", NSStringFromCGRect(self.frame));
        __block CGFloat totalWidth = 0;
     [self.titleArr enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
         UIButton *btn = [self viewWithTag:idx+1];
         NSDictionary *attr = @{NSFontAttributeName: [UIFont systemFontOfSize:self.titleFont]};
         btn.titleLabel.font = [UIFont systemFontOfSize:self.titleFont];
         [btn setTitleColor:self.titleNormalColor forState:UIControlStateNormal];
         [btn setTitleColor:self.titleSelectedColor forState:UIControlStateSelected];
         CGFloat width = [obj boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size.width;
         btn.frame = CGRectMake(0, 0, width, self.frame.size.height);
         btn.center = CGPointMake(CYedgs + self.buttonSpace * idx + width/2 + totalWidth, self.frame.size.height/2);
          totalWidth += width;
     }];
    
    
    self.contentSize = CGSizeMake(totalWidth + 2 *CYedgs + self.buttonSpace * (self.titleArr.count - 1), self.frame.size.height);
    if (CGRectEqualToRect(self.bottomView.frame, CGRectZero)) {
        UIButton *bn = [self viewWithTag:1];
        self.bottomView.frame = CGRectMake(CYedgs, self.frame.size.height - self.bottomLineHeight, bn.frame.size.width, self.bottomLineWidth);
    }
    self.bottomView.backgroundColor = self.bottomLineColor;

}

- (void)click:(UIButton *)sender
{
    [self.titleArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = [self viewWithTag:idx+1];
        if (btn.isSelected) {
            btn.selected = NO;
        }
    }];
    UIButton *bn = sender;
    sender.selected = YES;
    [UIView animateWithDuration:0.3 animations:^{
        self.bottomView.frame = CGRectMake(bn.frame.origin.x, self.bounds.size.height - self.bottomLineHeight, bn.frame.size.width, self.bottomLineWidth);
//        NSLog(@"%@", NSStringFromCGRect(_bottomView.frame));
        if (bn.center.x >= self.bounds.size.width/2 && bn.center.x <= self.contentSize.width - self.bounds.size.width/2) {
            
            self.contentOffset = CGPointMake(bn.center.x - self.bounds.size.width/2, 0);
//            NSLog(@"%@",NSStringFromCGPoint(self.contentOffset));
        }
        else if (bn.center.x >= self.contentSize.width - self.bounds.size.width/2)
        {
            self.contentOffset = CGPointMake(self.contentSize.width - self.bounds.size.width, 0);
        }
        else
        {
            self.contentOffset = CGPointMake(0, 0);
        }
    }];
    [UIView commitAnimations];
    
    if (_callBack) {
        _callBack(sender.tag - 1);
    }
}

@end
