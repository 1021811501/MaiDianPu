//
//  UIViewController+DGUtility.h
//  MaiDianPu
//
//  Created by JasonLee on 2017/11/8.
//  Copyright © 2017年 JasonLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (DGUtility)

/**
 找到当前window下的最顶层显示的viewcontroller

 @return window下的最顶层显示的viewcontroller
 */
+ (nullable UIViewController *)currentVisibleViewController;
@end
