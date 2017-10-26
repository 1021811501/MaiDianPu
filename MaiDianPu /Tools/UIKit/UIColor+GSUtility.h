//
//  UIColor+GSUtility.h
//  Study_iOS
//
//  Created by Joe on 16/6/26.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (GSUtility)

/**
 * The main blue color #4e86cb
 **/
+ (instancetype)mainBlueColor;

/**
 * The color with Hex string
 **/
+ (instancetype)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert andAlpha:(float)alpha;
@end
