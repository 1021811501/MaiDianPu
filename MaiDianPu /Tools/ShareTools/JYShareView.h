//
//  JYShareView.h
//  WaShiKe
//
//  Created by JasonLee on 17/2/8.
//  Copyright © 2017年 JasonLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UShare.h"
@interface JYShareView : UIView
@property(nonatomic,strong)UIVisualEffectView *bgView;
-(instancetype)initWithShareView;
-(void)show;
@end
