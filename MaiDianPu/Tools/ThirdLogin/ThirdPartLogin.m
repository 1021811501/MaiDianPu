//
//  ThirdPartLogin.m
//  WaShiKe
//
//  Created by JasonLee on 17/1/11.
//  Copyright © 2017年 JasonLee. All rights reserved.
//

#import "ThirdPartLogin.h"

@implementation ThirdPartLogin
+(void)loginWithPlatform:(ThirdPartLoginPlatformType)platform andViewController:(id)object{
    UMSocialPlatformType type;
    switch (platform) {
        case ThirdPartLoginPlatformTypeWechat:
            type = UMSocialPlatformType_WechatSession;
            break;
        case ThirdPartLoginPlatformTypeQQ:
            type = UMSocialPlatformType_QQ;
            break;
        case ThirdPartLoginPlatformTypeSina:
            type = UMSocialPlatformType_Sina;
            break;
        default:
            break;
    }
       [[UMSocialManager defaultManager] authWithPlatform:type currentViewController:object completion:^(id result, NSError *error) {
        if (error) {
            NSLog(@"登录失败%@",error);
            POPALERTSTRING([NSString stringWithFormat:@"登录失败!"]);
        }else{
            if ([result isKindOfClass:[UMSocialAuthResponse class]]) {
                UMSocialAuthResponse * resp = result;
                
                UMSocialUserInfoResponse *userInfoResp = [[UMSocialUserInfoResponse alloc] init];
                userInfoResp.uid = resp.uid;
                userInfoResp.openid = resp.openid;
                userInfoResp.accessToken = resp.accessToken;
                userInfoResp.refreshToken = resp.refreshToken;
                userInfoResp.expiration = resp.expiration;
                NSLog(@"登录成功!");
//                authInfo.response = userInfoResp;
//                
//                ws.authOpFinish();
//                [ws reloadInfo];
            }else{
//                message = @"Get info fail";
                UMSocialLogInfo(@"Get info fail with  unknow error");
            }

        }
    }];
}
@end
