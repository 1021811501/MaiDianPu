//
//  GuideView.m
//  GuideDemo
//
//  Created by 李剑钊 on 15/7/23.
//  Copyright (c) 2015年 sunli. All rights reserved.
//

#import "GuideView.h"
#import "UIView+Layout.h"
#import "UIImage+Mask.h"

@interface GuideView ()

@property (nonatomic, weak) UIView *parentView;
@property (nonatomic, strong) UIView *maskBg;
@property (nonatomic, strong) UIButton *okBtn;
@property (nonatomic, strong) UIImageView *btnMaskView;
@property (nonatomic, strong) UIImageView *arrwoView;
@property (nonatomic, strong) UIImageView *tipsView;
@property (nonatomic, strong) UIImageView *tipsView2;


@property (nonatomic, weak) UIButton *maskBtn;

@property (nonatomic, strong) UIView *topMaskView;
@property (nonatomic, strong) UIView *bottomMaskView;
@property (nonatomic, strong) UIView *leftMaskView;
@property (nonatomic, strong) UIView *rightMaskView;

@end

@implementation GuideView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        [self addSubview:self.topMaskView];
        [self addSubview:self.bottomMaskView];
        [self addSubview:self.leftMaskView];
        [self addSubview:self.rightMaskView];
        [self addSubview:self.okBtn];
        [self addSubview:self.btnMaskView];
        [self addSubview:self.arrwoView];
        [self addSubview:self.tipsView];
        [self addSubview:self.tipsView2];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.frame = _parentView.bounds;
    _maskBg.frame = self.bounds;
    
//    _btnMaskView.center = [_maskBtn.superview convertPoint:_maskBtn.center toView:_maskBtn.superview];
//    CGRect btnMaskRect = _btnMaskView.frame;
//    btnMaskRect.size = CGSizeMake(floor(btnMaskRect.size.width), floor(btnMaskRect.size.height));
//    btnMaskRect.origin = CGPointMake(floor(btnMaskRect.origin.x), floor(btnMaskRect.origin.y));
//    _btnMaskView.frame = btnMaskRect;
//    _btnMaskView.frame = CGRectMake(kScreenWidth - 200, 200, 100, 50);
    
    switch (_maskType) {
        case 0:
        {
            [self maskHome];
//            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kGuideHome];
        }
            break;
            
        case 1:
        {
            [self maskTaskHall];
//            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kGuideTaskHall];
        }
            break;
            
        case 2:
        {
            [self maskTaskAutoReceieve];
//            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kGuideTaskReceieve];
        }
            break;
            
        case 3:
        {
            [self maskProfile];
//            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kGuideProfile];
        }
            break;
            
        default:
            break;
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    _topMaskView.left = 0;
    _topMaskView.top = 0;
    _topMaskView.height = _btnMaskView.top;
    _topMaskView.width = self.width;
    
    _bottomMaskView.left = 0;
    _bottomMaskView.top = _btnMaskView.bottom;
    _bottomMaskView.width = self.width;
    _bottomMaskView.height = self.height - _bottomMaskView.top;
    
    _leftMaskView.left = 0;
    _leftMaskView.top = _btnMaskView.top;
    _leftMaskView.width = _btnMaskView.left;
    _leftMaskView.height = _btnMaskView.height;
    
    _rightMaskView.left = _btnMaskView.right;
    _rightMaskView.top = _btnMaskView.top;
    _rightMaskView.width = self.width - _rightMaskView.left;
    _rightMaskView.height = _btnMaskView.height;
}

- (void)maskHome{
    _btnMaskView.frame = CGRectMake(kScreenWidth - (kScreenWidth - 200) / 8 - 50 - 22.5, kScreenWidth / 2 + 13 - 5, 95, 95);
    [_btnMaskView setImage:[UIImage imageNamed:@"guideBg1"]];
    _btnMaskView.alpha = 0.965;
    
    _arrwoView.frame = CGRectMake(0, 0, 43, 34);
    _arrwoView.right = _btnMaskView.left;
    _arrwoView.bottom = _btnMaskView.top + 20;
    [_arrwoView setImage:[UIImage imageNamed:@"arrow1"]];
    
    _tipsView.frame = CGRectMake((kScreenWidth - 305 * kHEIGHT_SCALE) / 2, 0, 305 * kHEIGHT_SCALE, 56 * kHEIGHT_SCALE);
    _tipsView.bottom = _arrwoView.top - 10;
    [_tipsView setImage:[UIImage imageNamed:@"text1"]];
    
    _okBtn.frame = CGRectMake(0, 0, 148 * kHEIGHT_SCALE, 50 * kHEIGHT_SCALE);
    _okBtn.center = CGPointMake(kScreenWidth / 2, kScreenHeight - 100);
    [_okBtn setBackgroundImage:[UIImage imageNamed:@"guideButton1"] forState:UIControlStateNormal];
}

- (void)maskTaskHall{
    _btnMaskView.frame = CGRectMake(kScreenWidth - 120 * kHEIGHT_SCALE - 8.5 - 15, 204 - 6.5, 120 * kHEIGHT_SCALE + 17 , 58);
    [_btnMaskView setImage:[UIImage imageNamed:@"guideBg2"]];
    
    _arrwoView.frame = CGRectMake(0, 0, 40.5, 37);
    _arrwoView.top = _btnMaskView.bottom + 10;
    _arrwoView.right = _btnMaskView.left;
    [_arrwoView setImage:[UIImage imageNamed:@"arrow2"]];
    
    _tipsView.frame = CGRectMake((kScreenWidth - (493 / 2.0) * kHEIGHT_SCALE) / 2, 0, (493 / 2.0) * kHEIGHT_SCALE, (107 / 2.0) * kHEIGHT_SCALE);
    _tipsView.top = _arrwoView.bottom + 10;
    [_tipsView setImage:[UIImage imageNamed:@"text3"]];
    
    _tipsView2.frame = CGRectMake(_tipsView.left, 0, (378 / 2.0) * kHEIGHT_SCALE, (48 / 2.0) * kHEIGHT_SCALE);
    _tipsView2.bottom = _btnMaskView.top - 20;
    [_tipsView2 setImage:[UIImage imageNamed:@"text2"]];
    
    _okBtn.frame = CGRectMake(0, 0, 148 * kHEIGHT_SCALE, 50 * kHEIGHT_SCALE);
    _okBtn.center = CGPointMake(kScreenWidth / 2, kScreenHeight - 100);
    [_okBtn setBackgroundImage:[UIImage imageNamed:@"guideButton1"] forState:UIControlStateNormal];
}

- (void)maskTaskAutoReceieve{
    _btnMaskView.frame = CGRectMake(40 - 10.5, kScreenHeight - 120 - 10.5 , 75, 75);
    [_btnMaskView setImage:[UIImage imageNamed:@"guideBg3"]];
    
    _arrwoView.frame = CGRectMake(0, 0, 47 / 2.0, 99 / 2.0);
    _arrwoView.bottom = _btnMaskView.top - 10;
    _arrwoView.left = _btnMaskView.right - 10;
    [_arrwoView setImage:[UIImage imageNamed:@"arrow2"]];
    
    _tipsView.frame = CGRectMake((kScreenWidth - (487 / 2.0) * kHEIGHT_SCALE) / 2.0, 0, (487 / 2.0) * kHEIGHT_SCALE, (146 / 2.0) * kHEIGHT_SCALE);
    _tipsView.bottom = _arrwoView.top - 20;
    [_tipsView setImage:[UIImage imageNamed:@"text4"]];
    
    _okBtn.frame = CGRectMake(0, 0, 148 * kHEIGHT_SCALE, 50 * kHEIGHT_SCALE);
    _okBtn.left = _btnMaskView.right + (kScreenWidth - _btnMaskView.right - 148 * kHEIGHT_SCALE) / 2.0;
    _okBtn.centerY = _btnMaskView.centerY;
    [_okBtn setBackgroundImage:[UIImage imageNamed:@"guideButton1"] forState:UIControlStateNormal];
}

- (void)maskProfile{
    _btnMaskView.frame = CGRectMake(5, 430 , 129, 40);
    [_btnMaskView setImage:[UIImage imageNamed:@"guideBg4"]];
    
    _arrwoView.frame = CGRectMake(0, 0, 35, 42);
    _arrwoView.bottom = _btnMaskView.top - 10;
    _arrwoView.left = _btnMaskView.right - 10;
    [_arrwoView setImage:[UIImage imageNamed:@"arrow4"]];
    
    _tipsView.frame = CGRectMake((kScreenWidth - (534 / 2.0) * kHEIGHT_SCALE) / 2.0, 0, (534 / 2.0) * kHEIGHT_SCALE, (163 / 2.0) * kHEIGHT_SCALE);
    _tipsView.bottom = _arrwoView.top - 20;
    [_tipsView setImage:[UIImage imageNamed:@"text5"]];
    
    _okBtn.frame = CGRectMake(0, 0, 148 * kHEIGHT_SCALE, 50 * kHEIGHT_SCALE);
    _okBtn.top = _btnMaskView.bottom + 10;
    _okBtn.left = (kScreenWidth - _btnMaskView.right - 148 * kHEIGHT_SCALE) / 2.0 + _btnMaskView.right;
    [_okBtn setBackgroundImage:[UIImage imageNamed:@"guideButton1"] forState:UIControlStateNormal];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//    [self dismiss];
}

- (void)showInView:(UIView *)view maskBtn:(UIButton *)btn {
    self.parentView = view;
    self.maskBtn = btn;
    self.alpha = 0;
    [view addSubview:self];
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 1;
    } completion:nil];
}

- (void)dismiss {
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - getter and setter

- (UIView *)maskBg {
    if (!_maskBg) {
        UIView *view = [[UIView alloc] init];
        _maskBg = view;
    }
    return _maskBg;
}

- (UIButton *)okBtn {
    if (!_okBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"okBtn"] forState:UIControlStateNormal];
        [btn sizeToFit];
        [btn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        _okBtn = btn;
    }
    return _okBtn;
}

- (UIImageView *)btnMaskView {
    if (!_btnMaskView) {
        UIImageView *imageView = [[UIImageView alloc] init];
        _btnMaskView = imageView;
    }
    return _btnMaskView;
}

- (UIImageView *)arrwoView {
    if (!_arrwoView) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrowDown"]];
        _arrwoView = imageView;
    }
    return _arrwoView;
}

- (UIImageView *)tipsView {
    if (!_tipsView) {
        UIImageView *imageView = [[UIImageView alloc] init];
        _tipsView = imageView;
    }
    return _tipsView;
}

- (UIImageView *)tipsView2 {
    if (!_tipsView2) {
        UIImageView *imageView = [[UIImageView alloc] init];
        _tipsView2 = imageView;
    }
    return _tipsView2;
}

- (UIView *)topMaskView {
    if (!_topMaskView) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
        _topMaskView = view;
    }
    return _topMaskView;
}

- (UIView *)bottomMaskView {
    if (!_bottomMaskView) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
        _bottomMaskView = view;
    }
    return _bottomMaskView;
}

- (UIView *)leftMaskView {
    if (!_leftMaskView) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
        _leftMaskView = view;
    }
    return _leftMaskView;
}

- (UIView *)rightMaskView {
    if (!_rightMaskView) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
        _rightMaskView = view;
    }
    return _rightMaskView;
}

- (void)setMaskType:(MaskType)maskType{
    if (maskType != _maskType) {
        _maskType = maskType;
        [self setNeedsLayout];
    }
}

@end
