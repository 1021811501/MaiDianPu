//
//  UIView+JYUtility.m
//  warenqi
//
//  Created by 李志帅 on 16/9/26.
//  Copyright © 2016年 Mr.Lin. All rights reserved.
//

#import "UIView+JYUtility.h"

@implementation UIView (JYUtility)

//通过事件响应者链 查找下一个响应者

- (UIViewController *)viewController{
    
    UIResponder *nextResponder = self.nextResponder;
    
    while (nextResponder != nil) {
        
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
        nextResponder = nextResponder.nextResponder;
    }
    
    return nil;
}


- (void)bottomShadowRectangleWithShadowArea:(CGFloat)shadowArea cornerRadius:(CGFloat)cornerRadius opacity:(CGFloat)opacity{
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, self.frame.size.height- 8 , self.frame.size.width, 8)];
    self.layer.shadowColor = HexColor(@"a8a8a8", 1).CGColor; //阴影颜色
    self.layer.shadowRadius = shadowArea;               //半径
    self.layer.shadowOffset = CGSizeMake(0, 0);         //偏移距离
    self.layer.shadowOpacity = opacity;                    //不透明度
    self.layer.cornerRadius = cornerRadius;                 //圆角
    self.layer.shadowPath = path.CGPath;
    self.layer.masksToBounds = NO;
}
- (void)shadowRectangleWithShadowArea:(CGFloat)shadowArea cornerRadius:(CGFloat)cornerRadius opacity:(CGFloat)opacity{
    self.layer.shadowColor = HexColor(@"a8a8a8", 1).CGColor; //阴影颜色
    self.layer.shadowRadius = shadowArea;               //半径
    self.layer.shadowOffset = CGSizeMake(0, 0);         //偏移距离
    self.layer.shadowOpacity = opacity;                    //不透明度
    self.layer.cornerRadius = cornerRadius;                 //圆角
    self.layer.masksToBounds = NO;
}
- (void)addBorderWithColor:(UIColor *)color width:(CGFloat)width cornerRadius:(CGFloat)cornerRadius {
    [self.layer setBorderColor:[color CGColor]];
    [self.layer setBorderWidth:width];
    [self.layer setCornerRadius:cornerRadius];
    [self.layer setMasksToBounds:YES];
    [self setClipsToBounds:YES];
}

- (void)bottomBorderWithColor:(UIColor *)color height:(CGFloat)height {
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.backgroundColor = [color CGColor];
    bottomBorder.frame = CGRectMake(0, CGRectGetHeight(self.frame), CGRectGetWidth(self.frame), height);
    [self.layer addSublayer:bottomBorder];
}

- (void)innerTextViewShadowWithArea:(CGFloat)shadowArea cornerRadius:(CGFloat)cornerRadius opacity:(CGFloat)opacity width:(CGFloat)width {
    CAShapeLayer* shadowLayer = [CAShapeLayer layer];
    [shadowLayer setFrame:self.bounds];
    [shadowLayer setShadowColor:[[UIColor grayColor] CGColor]];
    [shadowLayer setShadowOffset:CGSizeMake(0.f, 0.f)];
    [shadowLayer setShadowOpacity:1.f];
    [shadowLayer setShadowRadius:1.f];
    
    [shadowLayer setFillRule:kCAFillRuleEvenOdd];
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectInset(CGRectMake(0, 0, width, self.bounds.size.height), -5, -5));
    
    CGMutablePathRef someInnerPath = CGPathCreateMutable();
    CGPathAddRect(someInnerPath, NULL, CGRectInset(CGRectMake(0, 0, width, self.bounds.size.height), 0, 0));
    
    CGPathAddPath(path, NULL, someInnerPath);
    CGPathCloseSubpath(path);
    [shadowLayer setPath:path];
    CGPathRelease(path);
    
    CAShapeLayer* maskLayer = [CAShapeLayer layer];
    [maskLayer setPath:someInnerPath];
    [shadowLayer setMask:maskLayer];
    [[self layer] addSublayer:shadowLayer];
}
@end
