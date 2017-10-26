//
//  SelectedButton.m
//  01-简单画板的实现
//
//  Created by kangkathy on 15/9/10.
//  Copyright (c) 2015年 kangkathy. All rights reserved.
//

#import "SelectedButton.h"

@implementation SelectedButton


- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.font = [UIFont systemFontOfSize:16];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    //绘制标题
    UIColor *color  = _titleColor;
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    
    style.alignment = NSTextAlignmentCenter;
    style.lineBreakMode = NSLineBreakByTruncatingTail;
    
    [self.title drawInRect:rect withAttributes:@{NSFontAttributeName : self.font,
                                                 NSForegroundColorAttributeName : color,
                                                 NSParagraphStyleAttributeName : style
                                                 }];
    
    //绘制下划线,高度很小的矩形
    if (self.isSelected) {
        
        CGRect frame = CGRectMake(0, CGRectGetHeight(rect) - 5, CGRectGetWidth(rect), 4);
        
//        CGRect frame1 = CGRectMake(0, CGRectGetHeight(rect) - 5, [self.title labelAutoCalculateRectWith:self.title FontSize:14.0 MaxSize:CGSizeMake(100, 20)].width, 4);
        
//        [kLoginBtnColor setFill];
        
        UIRectFill(frame);
    }
}

//当属性值发生改变时，需要刷新界面
- (void)setFont:(UIFont *)font {
    if (_font != font) {
        _font = font;
        
        [self setNeedsDisplay];
    }
}

- (void)setTitle:(NSString *)title {
    
    if (_title != title) {
        _title = title;
        [self setNeedsDisplay];
    }
}

- (void)setIsSelected:(BOOL)isSelected {
    if (_isSelected != isSelected) {
        _isSelected = isSelected;
        
        [self setNeedsDisplay];
    }
}

- (void)setTitleColor:(UIColor *)titleColor{
    if (_titleColor != titleColor) {
        _titleColor = titleColor;
    }
}

@end
