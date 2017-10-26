//
//  GuideView.h
//  GuideDemo
//
//  Created by 李剑钊 on 15/7/23.
//  Copyright (c) 2015年 sunli. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger){
    Home = 0,
    TaskHall = 1,
    TaskAutoReceieve = 2,
    Profile = 3
}MaskType;

@interface GuideView : UIView

@property(nonatomic ,assign)MaskType maskType;

- (void)showInView:(UIView *)view maskBtn:(UIButton *)btn;

@end
