//
//  UILabel+GSUtility.h
//  Study_iOS
//
//  Created by Joe on 16/6/26.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (GSUtility)

- (NSUInteger)satisfiedLineNumberWidth:(CGFloat)width;
- (CGSize)setLines:(NSInteger)lines andText:(NSString *)text LineSpacing:(CGFloat)lineSpacing;

@end
