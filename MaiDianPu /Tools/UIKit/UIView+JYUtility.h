//
//  UIView+JYUtility.h
//  warenqi
//
//  Created by 李志帅 on 16/9/26.
//  Copyright © 2016年 Mr.Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (JYUtility)

@property (nonatomic,readonly)UIViewController *viewController;



- (void)bottomShadowRectangleWithShadowArea:(CGFloat)shadowArea cornerRadius:(CGFloat)cornerRadius opacity:(CGFloat)opacity;
- (void)shadowRectangleWithShadowArea:(CGFloat)shadowArea cornerRadius:(CGFloat)cornerRadius opacity:(CGFloat)opacity;
- (void)addBorderWithColor:(UIColor *)color width:(CGFloat)width cornerRadius:(CGFloat)cornerRadius;

- (void)innerTextViewShadowWithArea:(CGFloat)shadowArea cornerRadius:(CGFloat)cornerRadius opacity:(CGFloat)opacity width:(CGFloat)width;
- (void)bottomBorderWithColor:(UIColor *)color height:(CGFloat)height;
@end
