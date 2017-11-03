//
//  JYBaseViewController.h
//  WaShiKe
//
//  Created by JasonLee on 17/1/5.
//  Copyright © 2017年 JasonLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DGDeviceBatteryObserve.h"
#import "DGNetWorkReachabilityManager.h"
@interface DGBaseViewController : UIViewController
/*
 *显示菊花
 */
@property(nonatomic , assign)BOOL showHudProgress;
/*
 *显示导航自定义按钮
 */
@property(nonatomic , assign)BOOL showNavLeftItem;
/*
 *菊花
 */
@property(nonatomic , strong)MBProgressHUD *hud;
/*
 *数据为空或者网络失败的的view
 */
@property(nonatomic , strong)QMUIEmptyView *emptyView;
/*
 *上拉加载下拉刷新
 */
- (MJRefreshHeader *)configureHeaderRefreshWithTarget:(id)target refreshingAction:(SEL)action;
- (MJRefreshFooter *)configureFooterRefreshWithTarget:(id)target refreshingAction:(SEL)action;
/*
 *展示空view的几个方法
 */
-(void)showEmptyView;

- (void)showEmptyViewWithLoading;
-(void)hidEmptyView;
- (void)showEmptyViewWithLoading:(BOOL)showLoading
                           image:(UIImage *)image
                            text:(NSString *)text
                      detailText:(NSString *)detailText
                     buttonTitle:(NSString *)buttonTitle
                    buttonAction:(SEL)action;
- (void)showEmptyViewWithImage:(UIImage *)image
                          text:(NSString *)text
                    detailText:(NSString *)detailText
                   buttonTitle:(NSString *)buttonTitle
                  buttonAction:(SEL)action;
- (void)showEmptyViewWithText:(NSString *)text
                   detailText:(NSString *)detailText
                  buttonTitle:(NSString *)buttonTitle
                 buttonAction:(SEL)action;
@end
