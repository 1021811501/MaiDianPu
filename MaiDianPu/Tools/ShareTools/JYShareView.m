//
//  JYShareView.m
//  WaShiKe
//
//  Created by JasonLee on 17/2/8.
//  Copyright © 2017年 JasonLee. All rights reserved.
//

#import "JYShareView.h"
static const CGFloat ShareBtnWidth = 60;
static const CGFloat CloseBtnWidth = 35;
@implementation JYShareView
-(instancetype)initWithShareView{
    self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    if (self) {
        self.alpha = 0;
        UIBlurEffect *light = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        self.bgView = [[UIVisualEffectView alloc] initWithEffect:light];
        _bgView.frame = self.bounds;
        [self addSubview:self.bgView];
        [self createShareBtn];
    }
    return self;
}
-(void)createShareBtn{
    NSArray *imgArray = @[@"ic_share_qq@2x.png",@"ic_share_wechat@2x.png",@"ic_share_weibo@2x.png",@"ic_share_zoom@2x",@"ic_share_moment@2x"];
    NSArray *titleArray =  @[@"QQ",@"微信好友",@"新浪微博",@"QQ空间",@"朋友圈"];
    CGFloat col =( self.frame.size.width - 3 * ShareBtnWidth)/6.0;
    
    for (int j = 0; j < 2; j++) {
        for (int i = 0; i < 3; i++) {
            if (j == 1 && i == 2) {
                break;
            }
            UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            shareBtn.tag = (i + 3 * j) + 1;
            shareBtn.layer.cornerRadius = ShareBtnWidth/2.0;
            shareBtn.layer.masksToBounds = YES;
            [shareBtn setBackgroundImage:[UIImage imageNamed:imgArray[i + 3 * j]] forState:UIControlStateNormal];
            [shareBtn addTarget:self action:@selector(shareBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:shareBtn];
            shareBtn.frame = CGRectMake(col + (col * 2 + ShareBtnWidth) * i , self.frame.size.height + (20 + ShareBtnWidth + 13 / 2.0 + 15) * j, ShareBtnWidth, ShareBtnWidth);
            
            UILabel *label = [[UILabel alloc] init];
            label.textColor = HexColor(@"ffffff", 1);
            label.font = [UIFont systemFontOfSize:13];
            label.text = titleArray[i + 3 * j];
            label.textAlignment = NSTextAlignmentCenter;
            label.tag = (i + 3 * j) + 10;
            [self addSubview:label];
            label.frame = CGRectMake(col + (col * 2 + ShareBtnWidth) * i , self.frame.size.height + ShareBtnWidth + 13 / 2.0 + (20 + ShareBtnWidth + 13 / 2.0 + 15) * j, ShareBtnWidth, 15);
        }
    }
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [closeBtn setBackgroundImage:[UIImage imageNamed:@"ic_close@2x.png"] forState:UIControlStateNormal];
    closeBtn.tag = 111;
    [closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtn];
    closeBtn.frame = CGRectMake(self.center.x - CloseBtnWidth/2.0, self.frame.size.height , CloseBtnWidth, CloseBtnWidth);
}
-(void)doApperaAnimation {
    dispatch_queue_t queue = dispatch_queue_create(0, 0);
    
    for (int j = 0; j < 2; j++) {
        for (int i = 0; i < 3; i++) {
            if (j == 1 && i == 2) {
                break;
            }
            dispatch_async(queue, ^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIButton *btn = [self viewWithTag:(i + 3 * j) + 1];
                    UILabel *label = [self viewWithTag:(i + 3 * j) + 10];
                    [UIView animateWithDuration:0.2 + 0.1 * (i + 3 * j) animations:^{
                        btn.transform = CGAffineTransformTranslate(btn.transform, 0, -350);
                        label.transform = CGAffineTransformTranslate(label.transform, 0, -350);
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:0.1 animations:^{
                            btn.transform = CGAffineTransformTranslate(btn.transform, 0, 20);
                            label.transform = CGAffineTransformTranslate(label.transform, 0, 20);
                        }];
                    }];
                });
                
            });
        }
    }

    dispatch_async(queue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            UIButton *closeBtn = [self viewWithTag:111];
            [UIView animateWithDuration: 0.5 animations:^{
                closeBtn.transform = CGAffineTransformTranslate(closeBtn.transform, 0, -100);
            }];
        });
    });
}
-(void)doDisMissAnimation{
    dispatch_queue_t queue = dispatch_queue_create(0, 0);
    dispatch_async(queue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            UIButton *closeBtn = [self viewWithTag:111];
            [UIView animateWithDuration:0.2 animations:^{
                closeBtn.transform = CGAffineTransformIdentity;
            }];
            
            for (int j = 0; j < 2; j++) {
                for (int i = 0; i < 3; i++) {
                    UIButton *btn = [self viewWithTag:(i + 3 * j) + 1];
                    UILabel *label = [self viewWithTag:(i + 3 * j) + 10];
                    [UIView animateWithDuration:(5 - (i + 3 * j))/10.0 animations:^{
                        btn.transform = CGAffineTransformIdentity;
                        label.transform = CGAffineTransformIdentity;
                    } completion:^(BOOL finished) {
                        if (j == 0) {
                            [UIView animateWithDuration:0.1 animations:^{
                                self.alpha = 0;
                            } completion:^(BOOL finished) {
                                if (finished) {
                                    [self removeFromSuperview];
                                }
                            }];
                        }
                    }];
                }
            }
        });
    });
}
-(void)shareBtnAction:(UIButton *)btn{
    switch (btn.tag) {
        case 1:
        {
            NSLog(@"QQ");
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]]) {
                [UShare shareWebPageToPlatformType:UMSocialPlatformType_QQ];
            }else{
                POPALERTSTRING(@"请安装手机QQ");
            }
        }
            break;
        case 2:
        {
            NSLog(@"微信");
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"wechat://"]]) {
                [UShare shareWebPageToPlatformType:UMSocialPlatformType_WechatSession];
            }else{
                POPALERTSTRING(@"请安装手机微信");
            }
        }
            break;
        case 3:
        {
            NSLog(@"新浪微博");
//            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"sinaweibo://"]]) {
//                [UShare shareWebPageToPlatformType:UMSocialPlatformType_Sina];
//            }else{
//                POPALERTSTRING(@"请安装手机新浪微博");
//            }
            POPALERTSTRING(@"暂未开放");
        }
            break;
        case 4:
        {
            NSLog(@"QQ空间");
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]]) {
                [UShare shareWebPageToPlatformType:UMSocialPlatformType_Qzone];
            }else{
                POPALERTSTRING(@"请安装手机QQ");
            }
        }
            break;
        case 5:
        {
            NSLog(@"朋友圈");
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"wechat://"]]) {
                [UShare shareWebPageToPlatformType:UMSocialPlatformType_WechatTimeLine];
            }else{
                POPALERTSTRING(@"请安装手机微信");
            }
        }
            break;
        default:
            break;
    }
}
-(void)closeAction{
    [self doDisMissAnimation];
}
-(void)show{
    [[APP window] addSubview:self];
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 1;
    }];
    [self doApperaAnimation];
}
//[UIView animateWithDuration:0.5 animations:^{
//    _closeIcon.transform = CGAffineTransformMakeRotation(M_PI_4);
//} completion:NULL];
//
//[_items enumerateObjectsUsingBlock:^(SnailIconLabel *item, NSUInteger idx, BOOL * _Nonnull stop) {
//    item.alpha = 0;
//    item.transform = CGAffineTransformMakeTranslation(0, ROWS * _itemSize.height);
//    [UIView animateWithDuration:0.85
//                          delay:idx * 0.035
//         usingSpringWithDamping:0.6
//          initialSpringVelocity:0
//                        options:UIViewAnimationOptionCurveLinear
//                     animations:^{
//                         item.alpha = 1;
//                         item.transform = CGAffineTransformIdentity;
//                     } completion:completion];
//}];
//}
//
//- (void)endAnimationsCompletion:(void (^)(SnailFullView *))completion {
//    if (!_closeButton.userInteractionEnabled) {
//        [UIView animateWithDuration:0.35 animations:^{
//            _closeIcon.transform = CGAffineTransformIdentity;
//        } completion:NULL];
//    }
//    
//    [_items enumerateObjectsUsingBlock:^(SnailIconLabel * _Nonnull item, NSUInteger idx, BOOL * _Nonnull stop) {
//        [UIView animateWithDuration:0.35
//                              delay:0.025 * (_items.count - idx)
//                            options:UIViewAnimationOptionCurveLinear
//                         animations:^{
//                             
//                             item.alpha = 0;
//                             item.transform = CGAffineTransformMakeTranslation(0, ROWS * _itemSize.height);
//                         } completion:^(BOOL finished) {
//                             if (finished) {
//                                 if (idx == _items.count - 1) {
//                                     completion(self);
//                                 }
//                             }
//                         }];
//    }];
//}

@end
