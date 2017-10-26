//
//  DGNetWorkReachabilityManager.h
//  WaShiKe
//
//  Created by JasonLee on 2017/7/26.
//  Copyright © 2017年 JasonLee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@protocol DGNetWorkReachabilityDelegate <NSObject>

-(void)netWorkStateDidChanged:(AFNetworkReachabilityStatus )status;

@end

@interface DGNetWorkReachabilityManager : NSObject

@property (nonatomic, weak)id<DGNetWorkReachabilityDelegate>delegate;

+(instancetype)shareManager;
-(void)startMonitoringWithDelegate:(id)object;
@end
