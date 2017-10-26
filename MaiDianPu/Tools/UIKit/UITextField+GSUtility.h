//
//  UITextField+GSUtility.h
//  Study_iOS
//
//  Created by Joe on 16/6/26.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (GSUtility)

- (void)removeStringSuffixWhitespace;
- (void)setPlaceholder:(NSString *)placeholder placeholderColor:(UIColor *)color placeholderFontOfSize:(CGFloat)size;
@end
