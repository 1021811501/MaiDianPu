//
//  DGClassUtility.h
//  WaRenQi
//
//  Created by JasonLee on 2017/8/11.
//  Copyright © 2017年 JasonLee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
@interface DGClassUtility : NSObject
+(NSArray*)getAllPropertiesWithObject:(id)obj;
@end
