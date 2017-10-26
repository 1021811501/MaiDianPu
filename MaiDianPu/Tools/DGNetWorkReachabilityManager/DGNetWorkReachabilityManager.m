//
//  DGNetWorkReachabilityManager.m
//  WaShiKe
//
//  Created by JasonLee on 2017/7/26.
//  Copyright © 2017年 JasonLee. All rights reserved.
//

#import "DGNetWorkReachabilityManager.h"

@implementation DGNetWorkReachabilityManager
+(instancetype)shareManager{
    static DGNetWorkReachabilityManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}
-(void)startMonitoringWithDelegate:(id)object{
    self.delegate = object;
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if ([self.delegate respondsToSelector:@selector(netWorkStateDidChanged:)]) {
            [self.delegate netWorkStateDidChanged:status];
        }
    }];
}
@end
