//
//  UIDevice+DGUtility.m
//  MaiDianPu
//
//  Created by JasonLee on 2017/10/25.
//  Copyright © 2017年 JasonLee. All rights reserved.
//

#import "UIDevice+DGUtility.h"

@implementation UIDevice (DGUtility)
+ (NSString *)getSystemVersion {
    NSString *systemVersion = [[UIDevice currentDevice] systemVersion];
    
    return systemVersion;
}
+ (CGFloat)getBatteryQuantity {
    [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    return ([[UIDevice currentDevice] batteryLevel] * 100);
}
+ (BOOL)isIos7 {
    return ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 && [[[UIDevice currentDevice] systemVersion] floatValue] < 8.0);
}

+ (BOOL)isIos8OrIos9 {
    return ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 && [[[UIDevice currentDevice] systemVersion] floatValue] < 10.0);
}

+ (BOOL)isIos10OrLater {
    return [[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0;
}
+(BOOL)isIos11OrLater{
    return [[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0;
}
@end
