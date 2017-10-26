//
//  DGApiResponse+BuildFactory.h
//  WaRenQiSeller
//
//  Created by JasonLee on 2017/6/14.
//  Copyright © 2017年 JasonLee. All rights reserved.
//

#import "DGApiResponse.h"

@interface DGApiResponse (BuildFactory)
+ (instancetype)responseWithDictionary:(NSDictionary *)dictionary responseCode:(NSInteger)responseCode error:(NSError *)error;
@end
