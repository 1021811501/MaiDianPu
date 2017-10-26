//
//  DGApiResponse.h
//  WaRenQiSeller
//
//  Created by JasonLee on 2017/6/14.
//  Copyright © 2017年 JasonLee. All rights reserved.
//

#import <Foundation/Foundation.h>
#define API_RESPONSE_CODE_AUTH_NO_NETWORK 0
#define API_RESPONSE_CODE_NEED_LOGIN 561
#define API_RESPONSE_CODE_FORBIDDEN 403
#define API_RESPONSE_CODE_NOTFOUND 404
#define API_RESPONSE_CODE_SUCESS 200
@interface DGApiResponse : NSObject
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, copy) NSString *errorCode;
@property (nonatomic, copy) NSString *errorMessage;
@property (nonatomic, strong) id data;
- (BOOL)isAuthNeedLogin;
- (BOOL)isSucess;
- (BOOL)isNeedExamation;
@end
