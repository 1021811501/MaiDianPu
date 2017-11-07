//
//  ThirdPartLogin.h
//  WaShiKe
//
//  Created by JasonLee on 17/1/11.
//  Copyright © 2017年 JasonLee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UMShare/UMShare.h>
typedef NS_ENUM(NSInteger ) {
    ThirdPartLoginPlatformTypeWechat = 1,
    ThirdPartLoginPlatformTypeQQ,
    ThirdPartLoginPlatformTypeSina
}ThirdPartLoginPlatformType;

@interface ThirdPartLogin : NSObject
+(void)loginWithPlatform:(ThirdPartLoginPlatformType)platform andViewController:(id)object;
@end
