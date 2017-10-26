//
//  ULogin.m
//  WaShiKe
//
//  Created by Mr.Lin. on 2017/3/14.
//  Copyright © 2017年 JasonLee. All rights reserved.
//

#import "ULogin.h"

#define EMOJI_CODE_TO_SYMBOL(x) ((((0x808080F0 | (x & 0x3F000) >> 4) | (x & 0xFC0) << 10) | (x & 0x1C0000) << 18) | (x & 0x3F) << 24);
#define MULITTHREEBYTEUTF16TOUNICODE(x,y) (((((x ^ 0xD800) << 2) | ((y ^ 0xDC00) >> 8)) << 8) | ((y ^ 0xDC00) & 0xFF)) + 0x10000

@implementation ULogin

+ (void)getUserInfoForPlatform:(UMSocialPlatformType)platformType Sucess:(void(^)(id response))sucess andFail:(void(^)(id error))fail{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:platformType currentViewController:self completion:^(id result, NSError *error) {
        if (error) {
            POPALERTSTRING(@"授权登入失败");
        }else{
            UMSocialUserInfoResponse *resp = result;
            
            // 第三方登录数据(为空表示平台未提供)
            // 授权数据
            NSLog(@" uid: %@", resp.uid);
            NSLog(@" openid: %@", resp.openid);
            NSLog(@" accessToken: %@", resp.accessToken);
            NSLog(@" refreshToken: %@", resp.refreshToken);
            NSLog(@" expiration: %@", resp.expiration);
            
            // 用户数据
            NSLog(@" name: %@", resp.name);
            NSLog(@" iconurl: %@", resp.iconurl);
            NSLog(@" gender: %@", resp.gender);
            
            // 第三方平台SDK原始数据
            NSLog(@" originalResponse: %@", resp.originalResponse);
            
            NSMutableDictionary *paramDic = [[NSMutableDictionary alloc] initWithCapacity:0];
            if (resp.openid) {
                [paramDic setObject:resp.openid forKey:@"vo.openid"];
            }
            if (resp.name) {
                NSString *nick;
                if ([resp.name stringContainsEmoji]) {
                    nick = [resp.name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                }else{
                    nick = resp.name;
                }
                [paramDic setObject:nick forKey:@"vo.nickName"];
            }
            if (resp.iconurl) {
                [paramDic setObject:resp.iconurl forKey:@"vo.figureurl"];
            }
            if (resp.accessToken) {
                [paramDic setObject:resp.accessToken forKey:@"vo.accessToken"];
            }
            if (resp.refreshToken) {
                [paramDic setObject:resp.refreshToken forKey:@"vo.refreshToken"];
            }
            if (resp.gender) {
                NSString *gender;
                if ([resp.gender isEqualToString:@"m"]) {
                    gender = @"男";
                }else if ([resp.gender isEqualToString:@"f"]){
                    gender = @"女";
                }else{
                    gender = resp.gender;
                }
                [paramDic setObject:gender forKey:@"vo.gender"];
            }

            NSString *type;
            if (platformType == UMSocialPlatformType_WechatSession) {
                type = @"WX";
            }else if (platformType == UMSocialPlatformType_QQ){
                type = @"QQ";
            }else{
                type = @"SINA";
            }
            [paramDic setObject:type forKey:@"vo.type"];
            
//            [LoginHttpmanager thirdPartLoginWithParam:paramDic andSucess:^(id response) {
//                sucess(response);
//            } fail:^(id error) {
//                fail(error);
//            }];
        }
    }];
}

+ (NSArray *)defaultEmoticons {
    NSMutableArray *array = [NSMutableArray new];
    for (int i=0x1F600; i<=0x1F64F; i++) {
        if (i < 0x1F641 || i > 0x1F644) {
            int sym = EMOJI_CODE_TO_SYMBOL(i);
            NSString *emoT = [[NSString alloc] initWithBytes:&sym length:sizeof(sym) encoding:NSUTF8StringEncoding];
            [array addObject:emoT];
        }
    }
    return array;
}

//判断字符串是否含有表情
+ (BOOL)stringContainsEmoji:(NSString *)string{
    __block BOOL returnValue = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    return returnValue;
}

@end
