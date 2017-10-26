//
//  DGApiResponse+BuildFactory.m
//  WaRenQiSeller
//
//  Created by JasonLee on 2017/6/14.
//  Copyright © 2017年 JasonLee. All rights reserved.
//

#import "DGApiResponse+BuildFactory.h"

@implementation DGApiResponse (BuildFactory)
+ (instancetype)responseWithDictionary:(NSDictionary *)dictionary responseCode:(NSInteger)responseCode error:(NSError *)error{
    DGApiResponse *response = [[DGApiResponse alloc] init];
    response.code = responseCode;
    response.errorCode = [dictionary objectForKey:@"code"];
    if (response.code == API_RESPONSE_CODE_FORBIDDEN) {
        response.errorMessage = @"服务器拒绝访问";
    }else if (response.code == API_RESPONSE_CODE_AUTH_NO_NETWORK){
        response.errorMessage = @"似乎与网络断开链接";
    }else if (response.code == API_RESPONSE_CODE_NOTFOUND){
        response.errorMessage = @"没有找到链接";
    }
    if (response.code == API_RESPONSE_CODE_SUCESS) {
        if ([[dictionary objectForKey:@"code"] integerValue] != 200) {
            response.errorCode = [dictionary objectForKey:@"code"];
            response.errorMessage = [dictionary objectForKey:@"msg"];
        }
        response.data = dictionary;
    }
    return response;
}
@end
