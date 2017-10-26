//
//  DGApiResponse.m
//  WaRenQiSeller
//
//  Created by JasonLee on 2017/6/14.
//  Copyright © 2017年 JasonLee. All rights reserved.
//

#import "DGApiResponse.h"
#import "DGApiResponse+BuildFactory.h"
@implementation DGApiResponse
- (BOOL)isAuthNeedLogin{
    return [self.errorCode integerValue] == API_RESPONSE_CODE_NEED_LOGIN;
}
- (BOOL)isSucess{
    return [[self.data objectForKey:@"code"] integerValue] == 200;
}
-(BOOL)isNeedExamation{
    return [[self.data objectForKey:@"code"] integerValue] == 8013;
}
@end
