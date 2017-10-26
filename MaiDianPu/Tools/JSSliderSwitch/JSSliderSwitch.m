//
//  JSSliderSwitch.m
//  WaShiKe
//
//  Created by JasonLee on 17/2/6.
//  Copyright © 2017年 JasonLee. All rights reserved.
//

#import "JSSliderSwitch.h"
//static const CGFloat TopScrollViewHeight = 40;
//static const CGFloat NormalFontSize = 14;
//static const CGFloat SlectedFontSize = 16;
//static const CGFloat ButtonMargin = 20.0;

//button间隔
static const CGFloat ButtonMargin = 10.0f;
//button标题正常大小
static const CGFloat ButtonFontNormalSize = 14.0f;
//button标题选中大小
static const CGFloat ButtonFontSelectedSize = 16.0f;
//顶部ScrollView高度
static const CGFloat TopScrollViewHeight = 40.0f;
@implementation JSSliderSwitch
{
    UIButton *_lastBtn;
    NSMutableArray *_btnArray;
    //button间隔
    //界面滑动的ScrollView
    UIScrollView *_mainScrollView;
    //阴影效果
    UIImageView *_shadowImageView;
    //按钮与下半部分的分割线
    UIView *_lineView;
    //存放按钮
    NSMutableArray *_buttons;
    //存放view
    NSMutableArray *_views;
}
#pragma mark -
#pragma mark 初始化方法

-(instancetype)init
{
    if (self = [super init]) {
        [self buildUI];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self buildUI];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}

-(void)buildUI
{
    _buttons = [NSMutableArray new];
    _views = [NSMutableArray new];
    _selectedIndex = 0;
    
    //防止navigationbar对ScrollView的布局产生影响
    [self addSubview:[UIView new]];
    //创建顶部ScrollView
    _topScrollView = [UIScrollView new];
    _topScrollView.showsHorizontalScrollIndicator = NO;
    _topScrollView.backgroundColor = [UIColor clearColor];
    _topScrollView.frame = CGRectMake(0, 0, kScreenWidth,TopScrollViewHeight);
    [self addSubview:_topScrollView];
    
    //创建展示视图控制器的ScrollView
    _mainScrollView = [UIScrollView new];
    _mainScrollView.delegate = self;
    _mainScrollView.pagingEnabled = YES;
    _mainScrollView.userInteractionEnabled = YES;
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    //    [_mainScrollView.panGestureRecognizer addTarget:self action:@selector(scrollHandlePan:)];
    [self addSubview:_mainScrollView];
    
    //创建分割线
    _lineView = [UIView new];
    _lineView.backgroundColor = HexColor(@"000000", 1);
    _lineView.frame = CGRectMake(0, _topScrollView.bounds.size.height, self.bounds.size.width, 0.5);
    [self addSubview:_lineView];
    
    //创建阴影view
    _shadowImageView = [[UIImageView alloc] init];
    _shadowImageView.backgroundColor = _btnSelectedColor;
    [_topScrollView addSubview:_shadowImageView];
}
-(void)setViewControllers:(NSMutableArray *)viewControllers{
    _viewControllers = viewControllers;
    for (int i = 0; i<viewControllers.count; i++) {
        UIViewController *VC = _viewControllers[i];
        [_views addObject:VC.view];
    }
    UIViewController *control = viewControllers[0];
    [_mainScrollView addSubview:control.view];

    for (int i = 0; i < [_viewControllers count]; i++) {
        UIViewController *vc = _viewControllers[i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:vc.title forState:UIControlStateNormal];
        button.backgroundColor = [UIColor clearColor];
        button.titleLabel.font = [UIFont systemFontOfSize:ButtonFontNormalSize];
        [button setTitleColor:self.btnSelectedColor forState:UIControlStateSelected];
        [button setTitleColor:self.btnNormalColor forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonSelectedMethod:) forControlEvents:UIControlEventTouchUpInside];
        [_topScrollView addSubview:button];
        [_buttons addObject:button];
    }
}
//设置当前选中位置
-(void)setSelectedIndex:(NSInteger)selectedIndex
{
    //更新frame
    [self updateUIWithSelectedIndex:selectedIndex byButton:true];
}
-(void)updateButtons
{
    CGFloat btnXOffset = ButtonMargin;
    for (NSInteger i = 0; i<_buttons.count; i++) {
        UIButton *button = _buttons[i];
        CGSize textSize = [NSString labelAutoCalculateRectWith:button.currentTitle FontSize:ButtonFontSelectedSize MaxSize:CGSizeMake(kScreenWidth, 50)];
        button.frame = CGRectMake(btnXOffset, 0, textSize.width + 20, _topScrollView.bounds.size.height);
        [button setTitleColor:_btnNormalColor forState:UIControlStateNormal];
        [button setTitleColor:_btnSelectedColor forState:UIControlStateSelected];
        btnXOffset += textSize.width + 20 + ButtonMargin;
        if (i == _selectedIndex) {
            button.titleLabel.font = [UIFont systemFontOfSize:ButtonFontSelectedSize];
            button.selected = true;
        }else{
            button.titleLabel.font = [UIFont systemFontOfSize:ButtonFontNormalSize];
            button.selected = false;
        }
    }
    
    //更新顶部ScrollView的滚动范围
    UIButton *button = _buttons.lastObject;
    _topScrollView.contentSize = CGSizeMake(CGRectGetMaxX(button.frame) + ButtonMargin, 0);
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(-kScreenWidth, TopScrollViewHeight)];
    [path addLineToPoint:CGPointMake(_topScrollView.contentSize.width + kScreenWidth, TopScrollViewHeight)];
    CAShapeLayer *layer =[CAShapeLayer layer];
    layer.strokeColor = HexColor(@"d9d9d9", 1).CGColor;
    layer.lineWidth = 0.5;
    layer.path = path.CGPath;
    [_topScrollView.layer addSublayer:layer];
    
}
-(void)updateShadowView
{
    //更新阴影的范围
    UIButton *button = _buttons[_selectedIndex];
    _shadowImageView.frame = CGRectMake(button.frame.origin.x, CGRectGetMaxY(button.frame) - 1.5,button.bounds.size.width,1.5);
    _shadowImageView.center = CGPointMake(button.center.x, _shadowImageView.center.y);
    _shadowImageView.backgroundColor = _btnSelectedColor;
}
-(void)buttonSelectedMethod:(UIButton *)btn{
    [self updateUIWithSelectedIndex:[_buttons indexOfObject:btn] byButton:YES];
}
-(void)updateUIWithSelectedIndex:(NSInteger)index byButton:(BOOL)byButton{
    _selectedIndex = index;
    for (UIButton *btn in _buttons) {
        if ([_buttons indexOfObject:btn] == _selectedIndex) {
            btn.titleLabel.font = [UIFont systemFontOfSize:ButtonFontSelectedSize];
            btn.selected = YES;
        }else{
            btn.titleLabel.font = [UIFont systemFontOfSize:ButtonFontNormalSize];
            btn.selected = NO;
        }
    }
    UIView *view = _views[index];
    if (![_mainScrollView.subviews containsObject:view]) {
        [_mainScrollView addSubview:view];
        view.frame = CGRectMake(index*_mainScrollView.bounds.size.width, 0, _mainScrollView.bounds.size.width, _mainScrollView.bounds.size.height);
    }
    [UIView animateWithDuration:0.35 animations:^{
        //更新TopScrollView的farme
        [self adjustTopScrollView:_buttons[index]];
        //更新shadow的frame
        [self updateShadowView];
    } completion:^(BOOL finished) {
        if ([_delegate respondsToSelector:@selector(slideSwitchDidselectTab:)]) {
            [_delegate slideSwitchDidselectTab:index];
        }
        if (byButton) {
            //更新主ScrollView范围
            dispatch_async(dispatch_get_main_queue(), ^{
                [_mainScrollView setContentOffset:CGPointMake(index * self.bounds.size.width, 0) animated:YES];
            });
        }
    }];
}
//是选中button显示在屏幕中间适配
- (void)adjustTopScrollView:(UIButton *)sender
{
    
    CGFloat targetX = CGRectGetMidX(sender.frame) - _topScrollView.bounds.size.width/2.0f;
    //左边缘适配
    if (targetX <=0) {
        targetX = 0;
    }
    //右边缘适配
    if (targetX >= _topScrollView.contentSize.width - _topScrollView.bounds.size.width) {
        targetX = _topScrollView.contentSize.width - _topScrollView.bounds.size.width;
    }
    [_topScrollView setContentOffset:CGPointMake(targetX, 0)];
    
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == _mainScrollView) {
        NSInteger index = (NSInteger)scrollView.contentOffset.x/self.bounds.size.width;
        [self updateUIWithSelectedIndex:index byButton:false];
    }
}


#pragma mark -
#pragma mark LayoutSubViews

//更新View
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //上半部分
    [self updateButtons];
    
    //更新shadow的位置
    [self updateShadowView];
    
    //下半部分
    _mainScrollView.frame = CGRectMake(0, TopScrollViewHeight, self.bounds.size.width, self.bounds.size.height - TopScrollViewHeight);
    _mainScrollView.contentSize = CGSizeMake(self.bounds.size.width * [_viewControllers count], 0);
    //分配子view的frame
    for (NSInteger i = 0; i<_views.count; i++) {
        UIView *view = _views[i];
        view.frame = CGRectMake(i*_mainScrollView.bounds.size.width, 0, _mainScrollView.bounds.size.width, _mainScrollView.bounds.size.height);
    }
}


@end
