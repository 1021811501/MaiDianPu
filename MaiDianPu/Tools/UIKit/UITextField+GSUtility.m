//
//  UITextField+GSUtility.m
//  Study_iOS
//
//  Created by Joe on 16/6/26.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import "UITextField+GSUtility.h"

@implementation UITextField (GSUtility)

- (void)removeStringSuffixWhitespace {
  NSString *emailString = self.text;
  NSInteger emailLength = [emailString length];
  
  if (emailLength >= 1) {
    if ([[emailString substringFromIndex:emailLength - 1] isEqualToString:@" "]) {
      self.text = [emailString substringToIndex:emailLength - 1];
    }
  }
}
- (void)setPlaceholder:(NSString *)placeholder placeholderColor:(UIColor *)color placeholderFontOfSize:(CGFloat)size {
    self.placeholder = placeholder;
    [self setValue:color forKeyPath:@"_placeholderLabel.textColor"];
    [self setValue:[UIFont systemFontOfSize:size] forKeyPath:@"_placeholderLabel.font"];
}

@end
