//
//  CityModel.h
//  warenqi
//
//  Created by 李志帅 on 16/4/12.
//  Copyright © 2016年 Mr.Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityModel : NSObject
@property(nonatomic ,assign)int id;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *zip;
@property(nonatomic,assign)int parent_id;
@property(nonatomic,assign)int type;
@end
