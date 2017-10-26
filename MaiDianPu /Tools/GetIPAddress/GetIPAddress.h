//
//  GetIPAddress.h
//  warenqi
//
//  Created by 李志帅 on 16/8/19.
//  Copyright © 2016年 Mr.Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
@interface GetIPAddress : NSObject

+(NSString *)getIPAddress;
+(NSString *)deviceWANIPAdress;
@end
