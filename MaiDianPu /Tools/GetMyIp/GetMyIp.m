//
//  GetMyIp.m
//  WaShiKe
//
//  Created by Mr.Lin. on 2017/3/14.
//  Copyright © 2017年 JasonLee. All rights reserved.
//

#import "GetMyIp.h"

@implementation GetMyIp

+(AFHTTPSessionManager *)sessionManager{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript",@"text/plain", nil]];
    manager.requestSerializer.timeoutInterval = 10;
    [manager.requestSerializer setValue:@"Ko;l47q6P`KZo:=xTc]39CJ`JPwGJ=fss8n:MaxR[YjPVN/2DI6`>5g3KdfMKpS9" forHTTPHeaderField:@"secret"];
    return manager;
}

+ (void)getMyIpWithSucess:(void(^)(id response))sucess andFail:(void(^)(id error))fail{
    [[self sessionManager] GET:@"http://121.201.29.42:9001/getIp" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        sucess(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(error);
    }];
}

@end
