//
//  CGSizeUtility.m
//  Study_iOS
//
//  Created by Joe on 16/6/26.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import "CGSizeUtility.h"

@implementation CGSizeUtility

+ (float)scaleOfsize:(CGSize)scaleSize toAspectFillSize:(CGSize)size {
  if ((scaleSize.width / scaleSize.height)  > (size.width / size.height)) {
    return size.height / scaleSize.height;
  } else {
    return size.width / scaleSize.width;
  }
}

+ (float)scaleOfSize:(CGSize)scaleSize toAspectFitSize:(CGSize)size {
  if ((scaleSize.width / scaleSize.height)  > (size.width / size.height)) {
    return size.width / scaleSize.width;
  } else {
    return size.height / scaleSize.height;
  }
}

@end
