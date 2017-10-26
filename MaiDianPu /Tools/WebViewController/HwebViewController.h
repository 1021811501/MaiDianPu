//
//  HelpViewController.h
//  warenqi
//
//  Created by Mr.Lin. on 16/5/4.
//  Copyright © 2016年 Mr.Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NJKWebViewProgressView.h"
#import "NJKWebViewProgress.h"
@interface HwebViewController : DGBaseViewController<UIWebViewDelegate,NJKWebViewProgressDelegate,UIAlertViewDelegate>

@property(nonatomic, copy) NSString *urlString;
@property(nonatomic, assign) BOOL isShowShare;
@property(nonatomic, assign) BOOL isFromHelp;
@property(nonatomic, copy) NSString *shareTitle;

@property (nonatomic, strong) id target;
@property (nonatomic, copy) NSString *title1;
@property (nonatomic, copy) NSString *urlString1;
@property (nonatomic, copy) NSString *htmlString;

@end
