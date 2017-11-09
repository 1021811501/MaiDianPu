//
//  JYBaseViewController.m
//  WaShiKe
//
//  Created by JasonLee on 17/1/5.
//  Copyright © 2017年 JasonLee. All rights reserved.
//

#import "DGBaseViewController.h"
#import <UMAnalytics/MobClick.h>
@interface DGBaseViewController ()<DGDeviceBatteryObserveDelegate,DGNetWorkReachabilityDelegate>
{
    UIButton *_btn;
    UIImageView *nodateImageView;
    UILabel *nodateLabel;
}
@end

@implementation DGBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = HexColor(@"f4f4f4", 1);
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = HexColor(@"fafafa", 1);
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:HexColor(@"333333", 1),NSFontAttributeName:[UIFont systemFontOfSize:18]}];
}
-(void)viewDidAppear:(BOOL)animated{
    [MobClick beginLogPageView:NSStringFromClass([self class])];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:NSStringFromClass([self class])];
}
- (UIImage *)imageWithColor:(UIColor *)color
{
    // 描述矩形
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 0.0f);
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    // 渲染上下文
    CGContextFillRect(context, rect);
    // 从上下文中获取图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    return theImage;
}

- (MJRefreshHeader *)configureHeaderRefreshWithTarget:(id)target refreshingAction:(SEL)action {
    /*
    MJRefreshNormalHeader *mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:action];
    mj_header.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    mj_header.ignoredScrollViewContentInsetTop = 10;
    
    // 隐藏时间
    mj_header.lastUpdatedTimeLabel.hidden = YES;
    [mj_header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [mj_header setTitle:@"释放刷新" forState:MJRefreshStatePulling];
    [mj_header setTitle:@"加载中 ..." forState:MJRefreshStateRefreshing];
     */
    
    NSMutableArray *loadImgArray = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 1; i <= 10; i ++) {
        UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"load%d@2x", i]];
        [loadImgArray addObject:img];
    }
    MJRefreshGifHeader *mj_header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:action];
    [mj_header setImages:loadImgArray forState:MJRefreshStateIdle];
    [mj_header setImages:loadImgArray forState:MJRefreshStatePulling];
    [mj_header setImages:loadImgArray forState:MJRefreshStateRefreshing];
    mj_header.ignoredScrollViewContentInsetTop = 0;
    mj_header.lastUpdatedTimeLabel.hidden = YES;
    mj_header.stateLabel.hidden = YES;
    mj_header.backgroundColor = [UIColor clearColor];
    return mj_header;
}

- (MJRefreshFooter *)configureFooterRefreshWithTarget:(id)target refreshingAction:(SEL)action {
    /*
    MJRefreshAutoNormalFooter *mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:target refreshingAction:action];
    mj_footer.triggerAutomaticallyRefreshPercent = 300.f;
    [mj_footer setTitle:@"上拉加载" forState:MJRefreshStateIdle];
    [mj_footer setTitle:@"正在加载 ..." forState:MJRefreshStateRefreshing];
    [mj_footer setTitle:@"没有更多数据" forState:MJRefreshStateNoMoreData];
     */
    
    NSMutableArray *loadImgArray = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 1; i <= 10; i ++) {
        UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"load%d@2x", i]];
        [loadImgArray addObject:img];
    }
    MJRefreshAutoGifFooter *mj_footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:target refreshingAction:action];
    [mj_footer setTitle:@"上拉加载" forState:MJRefreshStateIdle];
    [mj_footer setTitle:@"没有更多数据" forState:MJRefreshStateNoMoreData];
    [mj_footer setImages:loadImgArray forState:MJRefreshStateIdle];
    [mj_footer setImages:loadImgArray forState:MJRefreshStateRefreshing];
    mj_footer.labelLeftInset = 0;
    mj_footer.refreshingTitleHidden = YES;
    mj_footer.triggerAutomaticallyRefreshPercent = 300.f;
    mj_footer.backgroundColor = [UIColor clearColor];
    return mj_footer;
}

//-(void)setShowHudProgress:(BOOL)showHudProgress{
//    _showHudProgress = showHudProgress;
//    if (_showHudProgress == YES) {
//        [[MBProgressHUD showHUDAddedTo:self.view animated:YES] hideAnimated:YES afterDelay:10];
//    }else{
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
//    }
//}

- (void)setShowHudProgress:(BOOL)showHudProgress{
    if (showHudProgress != _showHudProgress) {
        _showHudProgress = showHudProgress;
        if (_showHudProgress == YES) {
            [[MBProgressHUD showHUDAddedTo:self.view animated:YES] hideAnimated:YES afterDelay:10];
//                    NSMutableArray *loadImgArray = [[NSMutableArray alloc] initWithCapacity:0];
//                    for (int i = 1; i < 35; i ++) {
//                        [loadImgArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"load%d", i]]];
//                    }
//                    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//                    hud.mode = MBProgressHUDModeCustomView;
//                    UIImageView *imgView = [[UIImageView alloc] init];
//                    imgView.animationImages = loadImgArray;
//                    imgView.animationDuration = 1.0f;
//                    imgView.animationRepeatCount = 0;
//                    [imgView startAnimating];
//                    hud.customView = imgView;
        }else{
//            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self performSelector:@selector(removeHudProgressHUD) withObject:nil afterDelay:.15f];
        }
    }
}

- (void)removeHudProgressHUD{
    for (UIView *view in [self.view subviews]) {
        if ([view isKindOfClass:[MBProgressHUD class]]) {
            [view removeFromSuperview];
        }
    }
}

-(void)setShowNavLeftItem:(BOOL)showNavLeftItem{
    if (showNavLeftItem == YES) {
        
        if (!_btn) {
            _btn = [UIButton buttonWithType:UIButtonTypeCustom] ;
            _btn.frame = CGRectMake(0, 0, 40, 30);
            [_btn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
            [_btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
            UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:_btn];
            self.navigationItem.leftBarButtonItem = leftItem;
        }
        
    }
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)showEmptyView{
    if (!self.emptyView) {
        self.emptyView = [[QMUIEmptyView alloc] initWithFrame:self.view.bounds];
    }
    [self.view addSubview:self.emptyView];
}
-(void)hidEmptyView{
    [self.emptyView removeFromSuperview];
}
- (void)showEmptyViewWithLoading {
    [self showEmptyView];
    [self.emptyView setImage:nil];
    [self.emptyView setLoadingViewHidden:NO];
    [self.emptyView setTextLabelText:nil];
    [self.emptyView setDetailTextLabelText:nil];
    [self.emptyView setActionButtonTitle:nil];
}

- (void)showEmptyViewWithText:(NSString *)text
                   detailText:(NSString *)detailText
                  buttonTitle:(NSString *)buttonTitle
                 buttonAction:(SEL)action {
    [self showEmptyViewWithLoading:NO image:nil text:text detailText:detailText buttonTitle:buttonTitle buttonAction:action];
}

- (void)showEmptyViewWithImage:(UIImage *)image
                          text:(NSString *)text
                    detailText:(NSString *)detailText
                   buttonTitle:(NSString *)buttonTitle
                  buttonAction:(SEL)action {
    [self showEmptyViewWithLoading:NO image:image text:text detailText:detailText buttonTitle:buttonTitle buttonAction:action];
}

- (void)showEmptyViewWithLoading:(BOOL)showLoading
                           image:(UIImage *)image
                            text:(NSString *)text
                      detailText:(NSString *)detailText
                     buttonTitle:(NSString *)buttonTitle
                    buttonAction:(SEL)action {
    [self showEmptyView];
    [self.emptyView setLoadingViewHidden:!showLoading];
    [self.emptyView setImage:image];
    [self.emptyView setTextLabelText:text];
    [self.emptyView setDetailTextLabelText:detailText];
    [self.emptyView setActionButtonTitle:buttonTitle];
    [self.emptyView.actionButton removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
    [self.emptyView.actionButton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
}
-(void)deviceBattertyStateChanged:(UIDeviceBatteryState )batteryState{
    NSLog(@"电池状态改变");
}
-(void)deviceBattertyLevelChanged:(CGFloat)batteryLevel{
    NSLog(@"电池电量改变");
}
-(void)deviceBattertyPowerModeChanged:( DeveiceBatteryPowerMode)batteryPowMode{
    NSLog(@"不是低电量和低电量状态改变");
}
-(void)netWorkStateDidChanged:(AFNetworkReachabilityStatus)status{
    /*
    AFNetworkReachabilityStatusUnknown          = -1,
    AFNetworkReachabilityStatusNotReachable     = 0,
    AFNetworkReachabilityStatusReachableViaWWAN = 1,
    AFNetworkReachabilityStatusReachableViaWiFi = 2,
     */
    NSLog(@"网络状态改变");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
