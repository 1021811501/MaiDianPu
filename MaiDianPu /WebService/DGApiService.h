//
//  DGApiService.h
//  WaRenQiSeller
//
//  Created by JasonLee on 2017/6/14.
//  Copyright © 2017年 JasonLee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DGApiRequest+BuildFactory.h"
#import "DGApiResponse+BuildFactory.h"
@class DGApiService;
@protocol DGApiServiceDelegate <NSObject>

@optional
- (void)service:(DGApiService *)service willStartRequest:(DGApiRequest *)request;
- (void)service:(DGApiService *)service didFinishRequest:(DGApiRequest *)request withResponse:(DGApiResponse *)response;
- (void)service:(DGApiService *)service requestFailed:(DGApiRequest *)request withResponse:(DGApiResponse *)response;
- (void)service:(DGApiService *)service apiRequest:(DGApiRequest *)request downloadProgress:(NSProgress *)progress;
@end

@interface DGApiService : NSObject
@property(nonatomic, assign)NSInteger tag;
@property(nonatomic, weak)id <DGApiServiceDelegate>delegate;
+(id)serviceWithDelegate:(id <DGApiServiceDelegate>)delegate;
+(id)serviceWithTag:(NSInteger)tag delegate:(id <DGApiServiceDelegate>)delegate;
- (void)sendJSONRequest:(DGApiRequest *)apiRequest;
@end

