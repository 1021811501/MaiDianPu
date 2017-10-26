//
//  CGSizeUtility.h
//  Study_iOS
//
//  Created by Joe on 16/6/26.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface CGSizeUtility : NSObject

+ (float)scaleOfSize:(CGSize)scaleSize toAspectFitSize:(CGSize)size;
+ (float)scaleOfsize:(CGSize)scaleSize toAspectFillSize:(CGSize)size;

@end
