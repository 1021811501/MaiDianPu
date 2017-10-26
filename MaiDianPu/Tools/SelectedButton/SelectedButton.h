//
//  SelectedButton.h
//  01-简单画板的实现
//
//  Created by kangkathy on 15/9/10.
//  Copyright (c) 2015年 kangkathy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectedButton : UIControl

@property(nonatomic, copy)NSString *title;
@property(nonatomic, strong)UIFont *font;
@property(nonatomic, strong)UIColor *titleColor;

@property(nonatomic, assign)BOOL isSelected; //是否选中



@end
