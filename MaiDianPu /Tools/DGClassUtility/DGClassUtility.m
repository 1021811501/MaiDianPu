//
//  DGClassUtility.m
//  WaRenQi
//
//  Created by JasonLee on 2017/8/11.
//  Copyright © 2017年 JasonLee. All rights reserved.
//

#import "DGClassUtility.h"

@implementation DGClassUtility
+(NSArray*)getAllPropertiesWithObject:(id)obj{
    u_int count;
    objc_property_t *properties = class_copyPropertyList([obj class], &count);
    NSMutableArray *propertiliesArray = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i<count; i++) {
        const char* propertyName = property_getName(properties[i]);
        [propertiliesArray addObject:[NSString stringWithUTF8String:propertyName]];
    }
    return propertiliesArray;
}
@end
