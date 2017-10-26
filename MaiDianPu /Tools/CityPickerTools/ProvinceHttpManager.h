//
//  ProvinceHttpManager.h
//  warenqi
//
//  Created by 李志帅 on 16/4/12.
//  Copyright © 2016年 Mr.Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProvinceHttpManager : NSObject
+(void)requestProvince:(void(^)(NSMutableArray *provinceArr))sucess andFaile:(void(^)(id error))faile;
+(void)requestCityWithId:(NSString *)provinceID andWith:(void(^)(NSMutableArray *cityArr))sucess andFaile:(void(^)(id error))faile;
@end
