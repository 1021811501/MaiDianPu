//
//  UIScreen+GSUtility.h
//  Study_iOS
//
//  Created by Joe on 16/6/26.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
  DeviceScreenInch_3_5 = 1,
  DeviceScreenInch_4_0 = 2,
  DeviceScreenInch_4_7 = 3,
  DeviceScreenInch_5_5 = 4,
} DeviceScreenInchEnum;

@interface UIScreen (GSUtility)

+ (BOOL)is35Inch;
+ (BOOL)is4Inch;
+ (BOOL)is47Inch;
+ (BOOL)is55Inch;

+ (CGRect)bounds;
+ (CGSize)screenSize;
+ (CGPoint)screenCenterPoint;

@end
