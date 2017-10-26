//
//  UIScreen+GSUtility.m
//  Study_iOS
//
//  Created by Joe on 16/6/26.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import "UIScreen+GSUtility.h"
#import "SDiPhoneVersion.h"

@implementation UIScreen (GSUtility)

#pragma mark - Public Methods

+ (BOOL)is35Inch {
  return [SDiPhoneVersion deviceSize] == iPhone35inch;
}

+ (BOOL)is4Inch {
  return [SDiPhoneVersion deviceSize] == iPhone4inch;
}

+ (BOOL)is47Inch {
  return [SDiPhoneVersion deviceSize] == iPhone47inch;
}

+ (BOOL)is55Inch {
  return [SDiPhoneVersion deviceSize] == iPhone55inch;
}

+ (CGSize)screenSize {
  CGSize screenSize = CGSizeZero;
  switch ([SDiPhoneVersion deviceSize]) {
    case iPhone35inch:
      screenSize = CGSizeMake(320, 480);
      break;
    case iPhone4inch:
      screenSize = CGSizeMake(320, 568);
      break;
    case iPhone47inch:
      screenSize = CGSizeMake(375, 667);
      break;
    case iPhone55inch:
      screenSize = CGSizeMake(414, 736);
      break;
      
    default:
      break;
  }
  
  return screenSize;
}

+ (CGPoint)screenCenterPoint {
  return CGPointMake([UIScreen screenSize].width / 2, [UIScreen screenSize].height / 2);
}

+ (CGRect)bounds {
  return CGRectMake(0.f, 0.f, [self screenSize].width, [self screenSize].height);
}

@end
