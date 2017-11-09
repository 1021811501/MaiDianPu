//
//  UIView+DGAdditions.m
//  MaiDianPu
//
//  Created by JasonLee on 2017/11/3.
//  Copyright © 2017年 JasonLee. All rights reserved.
//

#import "UIView+DGAdditions.h"
#import <objc/runtime.h>

@implementation UIView (DGAdditions)

#if TARGET_OS_IPHONE || TARGET_OS_TV

- (MASViewAttribute *)dg_mas_safeAreaLayoutGuide {
    return [self adjustLayoutGuideWithLayoutGuide:NSLayoutAttributeNotAnAttribute];
}

- (MASViewAttribute *)dg_mas_safeAreaLayoutGuideLeading {

    return [self adjustLayoutGuideWithLayoutGuide:NSLayoutAttributeLeading];
}

- (MASViewAttribute *)dg_mas_safeAreaLayoutGuideTrailing {

    return [self adjustLayoutGuideWithLayoutGuide:NSLayoutAttributeTrailing];
}

- (MASViewAttribute *)dg_mas_safeAreaLayoutGuideLeft {

    return [self adjustLayoutGuideWithLayoutGuide:NSLayoutAttributeLeft];
}

- (MASViewAttribute *)dg_mas_safeAreaLayoutGuideRight {

    return [self adjustLayoutGuideWithLayoutGuide:NSLayoutAttributeRight];
}

- (MASViewAttribute *)dg_mas_safeAreaLayoutGuideTop {

    return  [self adjustLayoutGuideWithLayoutGuide:NSLayoutAttributeTop];
}

- (MASViewAttribute *)dg_mas_safeAreaLayoutGuideBottom {

    return [self adjustLayoutGuideWithLayoutGuide:NSLayoutAttributeBottom];
}

- (MASViewAttribute *)dg_mas_safeAreaLayoutGuideWidth {

    return [self adjustLayoutGuideWithLayoutGuide:NSLayoutAttributeWidth];
}

- (MASViewAttribute *)dg_mas_safeAreaLayoutGuideHeight {

    return [self adjustLayoutGuideWithLayoutGuide:NSLayoutAttributeHeight];
}

- (MASViewAttribute *)dg_mas_safeAreaLayoutGuideCenterX {

    return [self adjustLayoutGuideWithLayoutGuide:NSLayoutAttributeCenterX];
}

- (MASViewAttribute *)dg_mas_safeAreaLayoutGuideCenterY {

    return [self adjustLayoutGuideWithLayoutGuide:NSLayoutAttributeCenterY];
}
-(MASViewAttribute *)adjustLayoutGuideWithLayoutGuide:(NSLayoutAttribute)attribute{
    if (@available(iOS 11.0,*)) {
        return [[MASViewAttribute alloc] initWithView:self item:self.safeAreaLayoutGuide layoutAttribute:attribute];
    }else{
        return [[MASViewAttribute alloc] initWithView:self layoutAttribute:attribute];
    }
}
#endif

#pragma mark - associated properties

- (id)mas_key {
    return objc_getAssociatedObject(self, @selector(mas_key));
}

- (void)setMas_key:(id)key {
    objc_setAssociatedObject(self, @selector(mas_key), key, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - heirachy

- (instancetype)mas_closestCommonSuperview:(MAS_VIEW *)view {
    MAS_VIEW *closestCommonSuperview = nil;
    
    MAS_VIEW *secondViewSuperview = view;
    while (!closestCommonSuperview && secondViewSuperview) {
        MAS_VIEW *firstViewSuperview = self;
        while (!closestCommonSuperview && firstViewSuperview) {
            if (secondViewSuperview == firstViewSuperview) {
                closestCommonSuperview = secondViewSuperview;
            }
            firstViewSuperview = firstViewSuperview.superview;
        }
        secondViewSuperview = secondViewSuperview.superview;
    }
    return closestCommonSuperview;
}

@end
