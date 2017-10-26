
//
//  ProvinceHttpManager.m
//  warenqi
//
//  Created by 李志帅 on 16/4/12.
//  Copyright © 2016年 Mr.Lin. All rights reserved.
//

#import "ProvinceHttpManager.h"
#import "ProvinceModel.h"
#import "CityModel.h"
#define kGetCityUrl           [NSString stringWithFormat:@"%@/app/region",kAPI]
#define   kGetProvinceUrl     [NSString stringWithFormat:@"%@/app/province",kAPI]
@implementation ProvinceHttpManager
+(void)requestProvince:(void(^)(NSMutableArray *provinceArr))sucess andFaile:(void(^)(id error))faile{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager GET:kGetProvinceUrl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *arr = [responseObject objectForKey:@"results"];
        NSMutableArray *array = [ProvinceModel mj_objectArrayWithKeyValuesArray:arr];
        sucess(array);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

+(void)requestCityWithId:(NSString *)provinceID andWith:(void(^)(NSMutableArray *cityArr))sucess andFaile:(void(^)(id error))faile{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager GET:kGetCityUrl parameters:@{@"pid":provinceID} progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *arr = [responseObject objectForKey:@"results"];
        NSMutableArray *array = [CityModel mj_objectArrayWithKeyValuesArray:arr];
        sucess(array);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
 
    
}
@end
