//
//  GetMyIp.h
//  WaShiKe
//
//  Created by Mr.Lin. on 2017/3/14.
//  Copyright © 2017年 JasonLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetMyIp : NSObject

+ (void)getMyIpWithSucess:(void(^)(id response))sucess andFail:(void(^)(id error))fail;

@end
