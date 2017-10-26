//
//  SystemInfo.h
//  WaRenQiSeller
//
//  Created by JasonLee on 2017/6/13.
//  Copyright © 2017年 JasonLee. All rights reserved.
//

#ifndef SystemInfo_h
#define SystemInfo_h
/*
 放一些常用的工具宏,比如获取屏幕尺寸,系统版本数据类型验证
 */

///屏幕的宽高
#define kScreenWidth      [UIScreen mainScreen].bounds.size.width
#define kScreenHeight     [UIScreen mainScreen].bounds.size.height
////本机的屏幕宽度和6的比例
#define kHEIGHT_SCALE (kScreenWidth/375.0)
//本机的屏幕宽度和5的比例
#define kHEIGHT_SCALE_5 (kScreenWidth/320.0)


// 获取入口类
#define APP [[UIApplication sharedApplication] delegate]
//app版本号
#define APPVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
//app名字
#define APPDisplayName [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]

//获取当前设备版本号
#define  kCurrentDeveiceSystem [[UIDevice currentDevice]systemVersion]
//获取app的bundle ID
#define kAPPBundleID [[NSBundle mainBundle]bundleIdentifier]

//DEBUG模式有输出    release模式没有输出
#ifndef __OPTIMIZE__
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
//#define NSLog(...) {}
#define DLog(...)
#endif


#define kWeakSelf __weak typeof(self)weakself = self;
#define kStrongSelf(type) __strong typeof(type) type = weak##type;
//当前语言
#define CurrentLanguage (［NSLocale preferredLanguages] objectAtIndex:0])


#endif /* SystemInfo_h */
