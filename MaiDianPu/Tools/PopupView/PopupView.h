//
//  ImageTapView.h
//  warenqi
//
//  Created by 李志帅 on 16/5/3.
//  Copyright © 2016年 Mr.Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PopupViewDelegate;

@interface PopupView : UIView
-(id)initWithTitle:(NSString *)title;
-(void)show;
@end

