//
//  FontAndColorMacros.h
//  WaRenQiSeller
//
//  Created by JasonLee on 2017/6/13.
//  Copyright © 2017年 JasonLee. All rights reserved.
//

#ifndef FontAndColorMacros_h
#define FontAndColorMacros_h
#import "UIColor+GSUtility.h"
/*
 字体和颜色的宏
 */
#define RGBA_COLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define HexColor(color,alpha) [UIColor colorWithHexString:color andAlpha:alpha]
#define KClearColor [UIColor clearColor]
#define KWhiteColor [UIColor whiteColor]
#define KBlackColor [UIColor blackColor]
#define KGrayColor [UIColor grayColor]
#define KGray2Color [UIColor lightGrayColor]
#define KBlueColor [UIColor blueColor]
#define KRedColor [UIColor redColor]
#define kRandomColor    KRGBColor(arc4random_uniform(256)/255.0,arc4random_uniform(256)/255.0,arc4random_uniform(256)/255.0)        //随机色生成
#endif /* FontAndColorMacros_h */
