//
//  DGDeviceBatteryObserve.h
//  WaShiKe
//
//  Created by JasonLee on 2017/7/26.
//  Copyright © 2017年 JasonLee. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger) {
    deveiceBatteryDefaultPowerMode, //不是低电量模式
    deveiceBatteryLowPowerMode,     //低电量模式打开
}DeveiceBatteryPowerMode;

@protocol DGDeviceBatteryObserveDelegate <NSObject>
@optional
-(void)deviceBattertyStateChanged:(UIDeviceBatteryState )batteryState;
-(void)deviceBattertyLevelChanged:(CGFloat)batteryLevel;
-(void)deviceBattertyPowerModeChanged:( DeveiceBatteryPowerMode)batteryPowMode;

@end
@interface DGDeviceBatteryObserve : NSObject
@property(nonatomic, weak)id <DGDeviceBatteryObserveDelegate>delegate;

+(instancetype)shareManager;
-(void)obeserveDevicebatteryInfoWithObject:(id)object;
@end
