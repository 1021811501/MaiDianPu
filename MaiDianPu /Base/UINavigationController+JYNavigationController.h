//
//  UINavigationController+JYNavigationController.h
//  WaShiKe
//
//  Created by JasonLee on 17/1/13.
//  Copyright © 2017年 JasonLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (JYNavigationController)
- (void)pushViewControllerFromLeft:(UIViewController*)viewController;
- (void)pushViewControllerFromBottom:(UIViewController*)viewController;
- (void)pushViewControllerFromTop:(UIViewController*)viewController;
- (void)pushViewControllerFromFade:(UIViewController *)viewController;


- (void)popViewControllerTrendRight;
- (void)popViewControllerTrendTop;
- (void)popViewControllerTrendBottom;
- (void)popViewControllerTrendFade ;

- (void)popToViewControllerTrendRight:(UIViewController *)viewController;
- (void)popToViewControllerTrendTop:(UIViewController *)viewController;
- (void)popToViewControllerTrendBottom:(UIViewController *)viewController;
- (void)popToViewControllerTrendFade:(UIViewController *)viewController;
@end
