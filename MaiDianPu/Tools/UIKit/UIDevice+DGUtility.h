//
//  UIDevice+DGUtility.h
//  MaiDianPu
//
//  Created by JasonLee on 2017/10/25.
//  Copyright © 2017年 JasonLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (DGUtility)
+ (NSString *)getSystemVersion;
+ (CGFloat)getBatteryQuantity;
+ (BOOL)isIos7;
+ (BOOL)isIos8OrIos9;
+ (BOOL)isIos10OrLater;
+(BOOL)isIos11OrLater;
@end
