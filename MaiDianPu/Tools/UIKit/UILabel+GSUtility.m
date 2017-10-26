//
//  UILabel+GSUtility.m
//  Study_iOS
//
//  Created by Joe on 16/6/26.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import "UILabel+GSUtility.h"

@implementation UILabel (GSUtility)

#pragma mark Public Methods

- (NSUInteger)satisfiedLineNumberWidth:(CGFloat)width {
  if (0 == self.text.length) {
    return 1;
  }
  CGFloat fontWidth = [self.text sizeWithAttributes:@{NSFontAttributeName:self.font}].width;
  return [self extraHardLineBreakCount] + (int)ceilf(fontWidth / width) ;
}

- (CGSize)setLines:(NSInteger)lines andText:(NSString *)text LineSpacing:(CGFloat)lineSpacing {
  self.numberOfLines = lines;
  CGFloat oneRowHeight = [text sizeWithAttributes:@{NSFontAttributeName:self.font}].height;
  CGSize textSize = [text boundingRectWithSize:CGSizeMake(self.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil].size;
  
  //设置文字的属性
  NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:text];
  
  NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
  [paragraphStyle setLineSpacing:lineSpacing];
  paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;//结尾部分的内容以……方式省略
  
  [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
  
  //计算出真实大小
  CGFloat rows = textSize.height / oneRowHeight;
  CGFloat realHeight;
  if (rows >= lines) {
    rows = lines;
  }
  realHeight = (rows * oneRowHeight) + (rows - 1) * lineSpacing;
  [self setAttributedText:attributedString];
  return CGSizeMake(textSize.width, realHeight);
}

#pragma mark Private Methods

- (NSUInteger)extraHardLineBreakCount {
  NSUInteger count = 0;
  unichar cr = '\n';
  for (int i = 0; i < self.text.length - 1; i++) {
    if ([self.text characterAtIndex:i] == cr) {
      count++;
    }
  }
  return count;
}

@end
