//
//  DGDeviceBatteryObserve.m
//  WaShiKe
//
//  Created by JasonLee on 2017/7/26.
//  Copyright © 2017年 JasonLee. All rights reserved.
//

#import "DGDeviceBatteryObserve.h"

@implementation DGDeviceBatteryObserve

+(instancetype)shareManager{
    static DGDeviceBatteryObserve *obeserve = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obeserve = [[self alloc]init];
    });
    return obeserve;
    
}

-(void)obeserveDevicebatteryInfoWithObject:(id)object{
    UIDevice *device = [UIDevice currentDevice];
    device.batteryMonitoringEnabled = true;
    self.delegate = object;
    [self addNotificationWithObject:object];
}

-(void)addNotificationWithObject:(id)object{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(batteryStateDidChanged:) name:UIDeviceBatteryStateDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(batteryLevelDidChanged:) name:UIDeviceBatteryLevelDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didChangePowerMode:) name:NSProcessInfoPowerStateDidChangeNotification object:nil];
}
-(void)batteryStateDidChanged:(NSNotification *)notification{
    UIDevice *deveice = [UIDevice currentDevice];
    if ([self.delegate respondsToSelector:@selector(deviceBattertyStateChanged:)]) {
        [self.delegate deviceBattertyStateChanged:deveice.batteryState];
    }
}
-(void)batteryLevelDidChanged:(NSNotification *)notification{
    UIDevice *deveice = [UIDevice currentDevice];
    if ([self.delegate respondsToSelector:@selector(deviceBattertyLevelChanged:)]) {
        [self.delegate deviceBattertyLevelChanged:deveice.batteryLevel];
    }
}
-(void)didChangePowerMode:(NSNotification *)notification{
    if ([self.delegate respondsToSelector:@selector(deviceBattertyPowerModeChanged:)]) {
        [self.delegate deviceBattertyPowerModeChanged:[[NSProcessInfo processInfo] isLowPowerModeEnabled] ? deveiceBatteryLowPowerMode : deveiceBatteryDefaultPowerMode];
    }
}
@end
