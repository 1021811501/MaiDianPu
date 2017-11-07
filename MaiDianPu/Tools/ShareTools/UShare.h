//
//  UShare.h
//  WaShiKe
//
//  Created by Mr.Lin. on 2017/3/13.
//  Copyright © 2017年 JasonLee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UMShare/UMShare.h>
@interface UShare : NSObject

+ (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType;

@end
