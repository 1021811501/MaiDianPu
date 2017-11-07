//
//  UIView+Configuration.m
//  MaiDianPu
//
//  Created by JasonLee on 2017/10/25.
//  Copyright © 2017年 JasonLee. All rights reserved.
//

#import "AppDelegate+Configuration.h"

@implementation AppDelegate (Configuration)
- (void)configureKeyboardManager {
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.keyboardDistanceFromTextField = 100;
    //    [[[IQKeyboardManager sharedManager] disabledDistanceHandlingClasses] addObject:[AddNewAddressViewController class]];//设置哪个界面不起作用
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    //        manager.overrideKeyboardAppearance = YES;
    manager.enableAutoToolbar = NO;
    //    manager.enableDebugging = YES;
}
-(void)configurationMobClick{
    [MobClick setScenarioType:E_UM_NORMAL];
    [UMErrorCatch initErrorCatch];
}
-(void)configurationUMSDKWithLaunchOptions:(NSDictionary *)launchOptions{
    [UMConfigure initWithAppkey:UMengAppkey channel:@"APPSTORE"];
    [UMConfigure setLogEnabled:YES];
    [self configurationMobClick];
    [self configurationUMSocialData];
    [self configurationUmMessageWithLaunchOptions:launchOptions];
}
-(void)configurationUMSocialData{
    //设置友盟社会化组件appkey
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WXAPPID appSecret:WXAPPSECRET redirectURL:nil];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQAPPID /*设置QQ平台的appID*/  appSecret:QQAPPKEY redirectURL:@"http://mobile.umeng.com/social"];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:WBAPPID  appSecret:WBAPPSECRET redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
}
-(void)configurationUmMessageWithLaunchOptions:(NSDictionary *)launchOptions{

    // Push组件基本功能配置
    [UNUserNotificationCenter currentNotificationCenter].delegate = self;
    UMessageRegisterEntity * entity = [[UMessageRegisterEntity alloc] init];
    //type是对推送的几个参数的选择，可以选择一个或者多个。默认是三个全部打开，即：声音，弹窗，角标等
    entity.types = UMessageAuthorizationOptionBadge|UMessageAuthorizationOptionAlert|UMessageAuthorizationOptionSound;
    [UMessage registerForRemoteNotificationsWithLaunchOptions:launchOptions Entity:entity completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            // 用户选择了接收Push消息
        }else{
            // 用户拒绝接收Push消息
            POPALERTSTRING(@"请打开设置允许通知")
        }
    }];
    [UMessage setAutoAlert:NO];
}
-(void)configurationQMUI{
    [QMUIConfigurationTemplate setupConfigurationTemplate];
}
@end
