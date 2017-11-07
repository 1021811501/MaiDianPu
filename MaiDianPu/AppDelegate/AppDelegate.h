//
//  AppDelegate.h
//  MaiDianPu
//
//  Created by JasonLee on 2017/10/25.
//  Copyright © 2017年 JasonLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "QMUIConfigurationTemplate.h"
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 100000
#import <UserNotifications/UserNotifications.h>
#endif
#import <UMCommon/UMCommon.h>           // 公共组件是所有友盟产品的基础组件，必选
#import <UMAnalytics/MobClick.h>        // 统计组件
#import <UMShare/UMShare.h>    // 分享组件
#import <UMPush/UMessage.h>             // Push组件
#import <UMErrorCatch/UMErrorCatch.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate,UNUserNotificationCenterDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

