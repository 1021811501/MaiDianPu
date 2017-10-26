//
//  QiniuTools.h
//  七牛
//
//  Created by 李志帅 on 16/4/6.
//  Copyright © 2016年 李志帅. All rights reserved.
//

#import <Foundation/Foundation.h>
static NSString *const UserHeadImage = @"UserHeadImage";
static NSString *const TaskSearchScreenshots = @"TaskSearchScreenshots";
static NSString *const BrowseScreenshots = @"BrowseScreenshots";
static NSString *const AddShopCartScreenshots = @"AddShopCartScreenshots";
static NSString *const GoodsCollectionScreenshots = @"GoodsCollectionScreenshots";
static NSString *const ShopCollectionScreenshots = @"ShopCollectionScreenshots";
static NSString *const ChartScreenshots = @"ChartScreenshots";
static NSString *const HighPraiseScreenshots = @"HighPraiseScreenshots";
static NSString *const CouponsScreenshots = @"CouponsScreenshots";
static NSString *const SpecialTaskScreenshots = @"SpecialTaskScreenshots";
static NSString *const CurrentBuyerScreensShots = @"CurrentBuyerScreensShots";
@interface QiniuTools : NSObject
@property (nonatomic, strong) NSString * token;
@property (nonatomic, strong) NSString * domain;
@property (nonatomic, strong) UIImage * pickImage;

+(void)uploadImageToQNImageDictionary:(NSDictionary *)imageDic WithSucess:(void(^)(id urlDic))sucess andFail:(void(^)(id error))fail;

@end
