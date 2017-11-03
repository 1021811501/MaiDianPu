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
//- (NSArray *)mas_makeConstraints:(void(^)(MASConstraintMaker *))block {
//    self.translatesAutoresizingMaskIntoConstraints = NO;
//    MASConstraintMaker *constraintMaker = [[MASConstraintMaker alloc] initWithView:self];
//    block(constraintMaker);
//    return [constraintMaker install];
//}
//
//- (NSArray *)mas_updateConstraints:(void(^)(MASConstraintMaker *))block {
//    self.translatesAutoresizingMaskIntoConstraints = NO;
//    MASConstraintMaker *constraintMaker = [[MASConstraintMaker alloc] initWithView:self];
//    constraintMaker.updateExisting = YES;
//    block(constraintMaker);
//    return [constraintMaker install];
//}
//
//- (NSArray *)mas_remakeConstraints:(void(^)(MASConstraintMaker *make))block {
//    self.translatesAutoresizingMaskIntoConstraints = NO;
//    MASConstraintMaker *constraintMaker = [[MASConstraintMaker alloc] initWithView:self];
//    constraintMaker.removeExisting = YES;
//    block(constraintMaker);
//    return [constraintMaker install];
//}

#pragma mark - NSLayoutAttribute properties

//- (MASViewAttribute *)mas_left {
//    return [[MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeLeft];
//}
//
//- (MASViewAttribute *)mas_top {
//    return [[MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeTop];
//}
//
//- (MASViewAttribute *)mas_right {
//    return [[MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeRight];
//}
//
//- (MASViewAttribute *)mas_bottom {
//    return [[MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeBottom];
//}
//
//- (MASViewAttribute *)mas_leading {
//    return [[MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeLeading];
//}
//
//- (MASViewAttribute *)mas_trailing {
//    return [[MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeTrailing];
//}
//
//- (MASViewAttribute *)mas_width {
//    return [[MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeWidth];
//}
//
//- (MASViewAttribute *)mas_height {
//    return [[MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeHeight];
//}
//
//- (MASViewAttribute *)mas_centerX {
//    return [[MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeCenterX];
//}
//
//- (MASViewAttribute *)mas_centerY {
//    return [[MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeCenterY];
//}
//
//- (MASViewAttribute *)mas_baseline {
//    return [[MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeBaseline];
//}
//
//- (MASViewAttribute *(^)(NSLayoutAttribute))mas_attribute
//{
//    return ^(NSLayoutAttribute attr) {
//        return [[MASViewAttribute alloc] initWithView:self layoutAttribute:attr];
//    };
//}
//
//- (MASViewAttribute *)mas_firstBaseline {
//    return [[MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeFirstBaseline];
//}
//- (MASViewAttribute *)mas_lastBaseline {
//    return [[MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeLastBaseline];
//}

#if TARGET_OS_IPHONE || TARGET_OS_TV

//- (MASViewAttribute *)mas_leftMargin {
//    return [[MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeLeftMargin];
//}
//
//- (MASViewAttribute *)mas_rightMargin {
//    return [[MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeRightMargin];
//}
//
//- (MASViewAttribute *)mas_topMargin {
//    return [[MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeTopMargin];
//}
//
//- (MASViewAttribute *)mas_bottomMargin {
//    return [[MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeBottomMargin];
//}
//
//- (MASViewAttribute *)mas_leadingMargin {
//    return [[MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeLeadingMargin];
//}
//
//- (MASViewAttribute *)mas_trailingMargin {
//    return [[MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeTrailingMargin];
//}
//
//- (MASViewAttribute *)mas_centerXWithinMargins {
//    return [[MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeCenterXWithinMargins];
//}
//
//- (MASViewAttribute *)mas_centerYWithinMargins {
//    return [[MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeCenterYWithinMargins];
//}

- (MASViewAttribute *)dg_mas_safeAreaLayoutGuide {
//    return [[MASViewAttribute alloc] initWithView:self item:self.safeAreaLayoutGuide layoutAttribute:NSLayoutAttributeNotAnAttribute];
    return [self adjustLayoutGuideWithLayoutGuide:NSLayoutAttributeNotAnAttribute];
}

- (MASViewAttribute *)dg_mas_safeAreaLayoutGuideLeading {
//    return [[MASViewAttribute alloc] initWithView:self item:self.safeAreaLayoutGuide layoutAttribute:NSLayoutAttributeLeading];
    return [self adjustLayoutGuideWithLayoutGuide:NSLayoutAttributeLeading];
}

- (MASViewAttribute *)dg_mas_safeAreaLayoutGuideTrailing {
//    return [[MASViewAttribute alloc] initWithView:self item:self.safeAreaLayoutGuide layoutAttribute:NSLayoutAttributeTrailing];
    return [self adjustLayoutGuideWithLayoutGuide:NSLayoutAttributeTrailing];
}

- (MASViewAttribute *)dg_mas_safeAreaLayoutGuideLeft {
//    return [[MASViewAttribute alloc] initWithView:self item:self.safeAreaLayoutGuide layoutAttribute:NSLayoutAttributeLeft];
    return [self adjustLayoutGuideWithLayoutGuide:NSLayoutAttributeLeft];
}

- (MASViewAttribute *)dg_mas_safeAreaLayoutGuideRight {
//    return [[MASViewAttribute alloc] initWithView:self item:self.safeAreaLayoutGuide layoutAttribute:NSLayoutAttributeRight];
    return [self adjustLayoutGuideWithLayoutGuide:NSLayoutAttributeRight];
}

- (MASViewAttribute *)dg_mas_safeAreaLayoutGuideTop {
//    return [[MASViewAttribute alloc] initWithView:self item:self.safeAreaLayoutGuide layoutAttribute:NSLayoutAttributeTop];
    return  [self adjustLayoutGuideWithLayoutGuide:NSLayoutAttributeTop];
}

- (MASViewAttribute *)dg_mas_safeAreaLayoutGuideBottom {
//    return [[MASViewAttribute alloc] initWithView:self item:self.safeAreaLayoutGuide layoutAttribute:NSLayoutAttributeBottom];
    return [self adjustLayoutGuideWithLayoutGuide:NSLayoutAttributeBottom];
}

- (MASViewAttribute *)dg_mas_safeAreaLayoutGuideWidth {
//    return [[MASViewAttribute alloc] initWithView:self item:self.safeAreaLayoutGuide layoutAttribute:NSLayoutAttributeWidth];
    return [self adjustLayoutGuideWithLayoutGuide:NSLayoutAttributeWidth];
}

- (MASViewAttribute *)dg_mas_safeAreaLayoutGuideHeight {
//    return [[MASViewAttribute alloc] initWithView:self item:self.safeAreaLayoutGuide layoutAttribute:NSLayoutAttributeHeight];
    return [self adjustLayoutGuideWithLayoutGuide:NSLayoutAttributeHeight];
}

- (MASViewAttribute *)dg_mas_safeAreaLayoutGuideCenterX {
//    return [[MASViewAttribute alloc] initWithView:self item:self.safeAreaLayoutGuide layoutAttribute:NSLayoutAttributeCenterX];
    return [self adjustLayoutGuideWithLayoutGuide:NSLayoutAttributeCenterX];
}

- (MASViewAttribute *)dg_mas_safeAreaLayoutGuideCenterY {
//    return [[MASViewAttribute alloc] initWithView:self item:self.safeAreaLayoutGuide layoutAttribute:NSLayoutAttributeCenterY];
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
