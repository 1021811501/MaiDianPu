//
//  JYBaseViewController.h
//  WaShiKe
//
//  Created by JasonLee on 17/1/5.
//  Copyright © 2017年 JasonLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DGBaseViewController : UIViewController
@property(nonatomic , assign)BOOL showHudProgress;
@property(nonatomic , assign)BOOL showNavLeftItem;
@property(nonatomic , assign)BOOL showNodateView;
@property(nonatomic , strong)MBProgressHUD *hud;
- (MJRefreshHeader *)configureHeaderRefreshWithTarget:(id)target refreshingAction:(SEL)action;
- (MJRefreshFooter *)configureFooterRefreshWithTarget:(id)target refreshingAction:(SEL)action;
@end
