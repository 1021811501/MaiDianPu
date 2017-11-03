//
//  JYBaseNavigationController.m
//  WaShiKe
//
//  Created by JasonLee on 17/1/5.
//  Copyright © 2017年 JasonLee. All rights reserved.
//

#import "DGBaseNavigationController.h"

@interface DGBaseNavigationController ()

@end

@implementation DGBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.hidesBottomBarWhenPushed = YES;
//    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
//    {
//        self.interactivePopGestureRecognizer.delegate = self;
//        self.delegate = self;
//    }
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}
//解决自定返回按钮后返回手势不能用问题
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
//    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
//        self.interactivePopGestureRecognizer.enabled = NO;
    if (self.viewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

#pragma mark UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animate
{
//    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
//        self.interactivePopGestureRecognizer.enabled = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
