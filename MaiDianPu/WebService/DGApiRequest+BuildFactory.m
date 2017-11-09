//
//  DGApiRequest+BuildFactory.m
//  WaRenQiSeller
//
//  Created by JasonLee on 2017/6/13.
//  Copyright © 2017年 JasonLee. All rights reserved.
//

#import "DGApiRequest+BuildFactory.h"


@implementation DGApiRequest (BuildFactory)

+(instancetype)requestForLoginInWithNick:(NSString *)nick andPassWord:(NSString *)pwd{
    DGApiRequest *request = [self defaultRequestWithUrlStr:@"/app/login"];
    request.requestType = ApiRequestTypeLogin;
    request.method = ApiRequestMethodPost;
    [request.parameters setValue:nick forKey:@"nick"];
    [request.parameters setValue:pwd forKey:@"pass"];
    return request;
}

@end
