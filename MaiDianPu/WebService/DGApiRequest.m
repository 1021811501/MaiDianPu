//
//  DGApiRequest.m
//  WaRenQiSeller
//
//  Created by JasonLee on 2017/6/13.
//  Copyright © 2017年 JasonLee. All rights reserved.
//

#import "DGApiRequest.h"
#import "DGApiRequest+BuildFactory.h"

@implementation DGApiRequest
static const NSInteger requestTimeOut = 20 ;
- (NSString *)assembleParameters {
    NSMutableArray *parts = [NSMutableArray array];
    for (NSString *key in [self.parameters allKeys]) {
        NSString *part = [NSString stringWithFormat:@"%@=%@", key, [self.parameters valueForKey:key]];
        [parts addObject: part];
    }
    
    return [parts componentsJoinedByString: @"&"];
}
- (void)setJsonHTTPHeadersForRequest:(NSMutableURLRequest *)request {
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"Ko;l47q6P`KZo:=xTc]39CJ`JPwGJ=fss8n:MaxR[YjPVN/2DI6`>5g3KdfMKpS9" forHTTPHeaderField:@"secret"];
}
+(instancetype)defaultRequestWithUrlStr:(NSString *)urlStr{
    DGApiRequest *request = [[DGApiRequest alloc] init];
    request.url = [NSString stringWithFormat:@"%@%@",kAPI,urlStr];
    request.method = ApiRequestMethodPost;
    request.content = ApiRequestContentJSON;
    request.timeout = requestTimeOut;
    request.parameters = [NSMutableDictionary dictionary];
    return request;
}
@end
