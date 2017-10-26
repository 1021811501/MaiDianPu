//
//  GetIPAddress.m
//  warenqi
//
//  Created by 李志帅 on 16/8/19.
//  Copyright © 2016年 Mr.Lin. All rights reserved.
//

#import "GetIPAddress.h"

@implementation GetIPAddress
+ (NSString *)getIPAddress {
    NSString *address = @"127.0.0.1";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}

+(NSString *)deviceWANIPAdress{
    NSError *error;
    //    http://ip.taobao.com/service/getIpInfo2.php?ip=myip
    //    http://pv.sohu.com/cityjson?ie=utf-8
//    115.192.110.163
//    ip	__NSCFString *	@"{\"code\":0,\"data\":{\"country\":\"\\u4e2d\\u56fd\",\"country_id\":\"CN\",\"area\":\"\\u534e\\u4e1c\",\"area_id\":\"300000\",\"region\":\"\\u6d59\\u6c5f\\u7701\",\"region_id\":\"330000\",\"city\":\"\\u676d\\u5dde\\u5e02\",\"city_id\":\"330100\",\"county\":\"\",\"county_id\":\"-1\",\"isp\":\"\\u7535\\u4fe1\",\"isp_id\":\"100017\",\"ip\":\"115.192.110.163\"}}"	0x000060000066ab40
    
//    NSURL *ipURL = [NSURL URLWithString:@"http://ip.taobao.com/service/getIpInfo2.php?ip=myip"];
//
    NSURL *ipURL = [NSURL URLWithString:@"http://121.201.29.42:9001/getIp"];
    NSMutableString *ip = [NSMutableString stringWithContentsOfURL:ipURL encoding:NSUTF8StringEncoding error:&error];
    
    if (ip.length != 0) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[ip dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
//        NSDictionary *dic1 = [dic objectForKey:@"data"];
        NSString *string = [dic objectForKey:@"results"];
        NSLog(@"%@", string);
        if (string) {
            return string;
        }
    }
    return @"127.0.0.1";
}



@end
