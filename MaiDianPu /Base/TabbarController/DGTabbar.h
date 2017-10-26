//
//  DGTabbar.h
//  MaiDianPu
//
//  Created by JasonLee on 2017/10/25.
//  Copyright © 2017年 JasonLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DGTabbar;
@protocol DGTabbarDelegate <NSObject>
-(void)tabbarPluseBtnClick:(DGTabbar *)tabbar;
@end

@interface DGTabbar : UITabBar
@property(nonatomic,weak)id<DGTabbarDelegate>delegate;
@end
