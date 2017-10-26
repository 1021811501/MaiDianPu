//
//  JSSliderSwitch.h
//  WaShiKe
//
//  Created by JasonLee on 17/2/6.
//  Copyright © 2017年 JasonLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JSSliderSwitchDelegate <NSObject>

-(void)slideSwitchDidselectTab:(NSInteger )index;

@end

@interface JSSliderSwitch : UIView <UIScrollViewDelegate>
/**
 顶部scroll
 */
@property (strong,nonatomic,readonly)  UIScrollView *topScrollView;
/**
 需要显示的viewController集合
 */
@property (strong,nonatomic) NSMutableArray *viewControllers;
/**
 是否隐藏选中效果
 */
@property (assign,nonatomic) BOOL hideShadow;
/**
 当前选中位置
 */
@property (assign,nonatomic) NSInteger selectedIndex;
/**
 按钮正常时的颜色
 */
@property (strong,nonatomic) UIColor *btnNormalColor;
/**
 按钮选中时的颜色
 */
@property (strong,nonatomic) UIColor *btnSelectedColor;

@property(weak,nonatomic)id <JSSliderSwitchDelegate> delegate;

@end
