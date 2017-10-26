//
//  UIColor+GSUtility.m
//  Study_iOS
//
//  Created by Joe on 16/6/26.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import "UIColor+GSUtility.h"

@implementation UIColor (GSUtility)

+ (instancetype)mainBlueColor {
  return [UIColor colorWithHexString:@"1c8fe6" alpha:1.f];
}

+ (instancetype)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha {
  //-----------------------------------------
  // Convert hex string to an integer
  //-----------------------------------------

  unsigned int hexint = 0;
  
  // Create scanner
  NSScanner *scanner = [NSScanner scannerWithString:hexString];
  
  // Tell scanner to skip the # character
  [scanner setCharactersToBeSkipped:[NSCharacterSet
                                     characterSetWithCharactersInString:@"#"]];
  [scanner scanHexInt:&hexint];
  
  //-----------------------------------------
  // Create color object, specifying alpha
  //-----------------------------------------
  UIColor *color =
  [UIColor colorWithRed:((CGFloat) ((hexint & 0xFF0000) >> 16))/255
                  green:((CGFloat) ((hexint & 0xFF00) >> 8))/255
                   blue:((CGFloat) (hexint & 0xFF))/255
                  alpha:alpha];
  
  return color;
}
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert andAlpha:(float)alpha
{
    NSAssert(stringToConvert.length == 6, @"颜色值必须是六位");
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:alpha];
}
@end
