//
//  ULogin.h
//  WaShiKe
//
//  Created by Mr.Lin. on 2017/3/14.
//  Copyright © 2017年 JasonLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ULogin : NSObject

+ (void)getUserInfoForPlatform:(UMSocialPlatformType)platformType Sucess:(void(^)(id response))sucess andFail:(void(^)(id error))fail;

@end
