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
    //友盟统计
    [MobClick setLogEnabled:YES];
    UMConfigInstance.appKey = UMengAppkey;
    UMConfigInstance.channelId = @"Enterprise";  //企业
    [MobClick startWithConfigure:UMConfigInstance];
    [MobClick setAppVersion:APPVersion];
    
}
-(void)configurationUMSocialData{
    //设置友盟社会化组件appkey
    [[UMSocialManager defaultManager] setUmSocialAppkey:UMengAppkey];
//    [UMSocialData setAppKey:UmengAppkey];
    //打开调试log的开关
//    [UMSocialData openLog:YES];
    [[UMSocialManager defaultManager] openLog:YES];
    
     [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxdc1e388c3822c80b" appSecret:@"3baf1193c85774b3fd9d18447d76cab0" redirectURL:nil];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105821097"/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"3921700954"  appSecret:@"04b48b094faeb16683c32669824ebdad" redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
    //如果你要支持不同的屏幕方向，需要这样设置，否则在iPhone只支持一个竖屏方向
//    [UMSocialConfig setSupportedInterfaceOrientations:UIInterfaceOrientationMaskAll];
    
    //设置微信AppId，设置分享url，默认使用友盟的网址
//    [UMSocialWechatHandler setWXAppId:WXAPPID appSecret:WXAPPSECRET url:kUrlShareStr];
    //设置微博APPid
//    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:WBAPPID
//                                              secret:WBAPPSECRET
////                                         RedirectURL:kUrlShareStr];
    
    //设置分享到QQ/Qzone的应用Id，和分享url 链接
//    [UMSocialQQHandler setQQWithAppId:QQAPPID appKey:QQAPPKEY url:kUrlShareStr];
//    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ, UMShareToQzone, UMShareToWechatSession, UMShareToWechatTimeline]];
}
-(void)configurationUmMessageWithLaunchOptions:(NSDictionary *)launchOptions{
    //1.2.7版本开始简化初始化过程。如不需要交互式的通知，下面用下面一句话初始化即可。
    [UMessage startWithAppkey:UMengAppkey launchOptions:launchOptions];
    //iOS10必须加下面这段代码。
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate = self;
    UNAuthorizationOptions types10=UNAuthorizationOptionBadge|  UNAuthorizationOptionAlert|UNAuthorizationOptionSound;
    [center requestAuthorizationWithOptions:types10     completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            //点击允许
            //这里可以添加一些自己的逻辑
        } else {
            //点击不允许
            //这里可以添加一些自己的逻辑
            POPALERTSTRING(@"请打开设置允许通知")
        }
    }];
    //如果你期望使用交互式(只有iOS 8.0及以上有)的通知，请参考下面注释部分的初始化代码
    UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
    action1.identifier = @"action1_identifier";
    action1.title=@"打开应用";
    action1.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序
    
    UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];  //第二按钮
    action2.identifier = @"action2_identifier";
    action2.title=@"忽略";
    action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
    action2.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
    action2.destructive = YES;
    UIMutableUserNotificationCategory *actionCategory1 = [[UIMutableUserNotificationCategory alloc] init];
    actionCategory1.identifier = @"category1";//这组动作的唯一标示
    [actionCategory1 setActions:@[action1,action2] forContext:(UIUserNotificationActionContextDefault)];
    NSSet *categories = [NSSet setWithObjects:actionCategory1, nil];
    
    //如果要在iOS10显示交互式的通知，必须注意实现以下代码
    if ([[[UIDevice currentDevice] systemVersion]intValue]>=10) {
        UNNotificationAction *action1_ios10 = [UNNotificationAction actionWithIdentifier:@"action1_ios10_identifier" title:@"打开应用" options:UNNotificationActionOptionForeground];
        UNNotificationAction *action2_ios10 = [UNNotificationAction actionWithIdentifier:@"action2_ios10_identifier" title:@"忽略" options:UNNotificationActionOptionForeground];
        
        //UNNotificationCategoryOptionNone
        //UNNotificationCategoryOptionCustomDismissAction  清除通知被触发会走通知的代理方法
        //UNNotificationCategoryOptionAllowInCarPlay       适用于行车模式
        UNNotificationCategory *category1_ios10 = [UNNotificationCategory categoryWithIdentifier:@"category1" actions:@[action1_ios10,action2_ios10]   intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
        NSSet *categories_ios10 = [NSSet setWithObjects:category1_ios10, nil];
        [center setNotificationCategories:categories_ios10];
        [UMessage registerForRemoteNotifications:categories];
    }else
    {
        [UMessage registerForRemoteNotifications:categories];
    }
    [UMessage setLogEnabled:YES];
    [UMessage setAutoAlert:NO];
}
@end
