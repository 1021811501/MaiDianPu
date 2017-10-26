//
//  UIButton+GSUtility.m
//  Xinbei
//
//  Created by Joe on 16/6/3.
//  Copyright © 2016年 PuShuJinFu. All rights reserved.
//

#import "UIButton+GSUtility.h"

@implementation UIButton (GSUtility)

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state {
  CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
  UIGraphicsBeginImageContext(rect.size);
  CGContextRef context = UIGraphicsGetCurrentContext();
  
  CGContextSetFillColorWithColor(context, [backgroundColor CGColor]);
  CGContextFillRect(context, rect);
  
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  [self setBackgroundImage:image forState:state];
}

@end
