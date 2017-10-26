//
//  DGConfig.h
//  MaiDianPu
//
//  Created by JasonLee on 2017/10/25.
//  Copyright © 2017年 JasonLee. All rights reserved.
//

#import <Foundation/Foundation.h>
// 接口
//挖人气
#ifdef DEBUG
#define   kAPI                @"http://121.201.29.42:9005"
#define   kWebsSocketUrl      @"ws://121.201.29.42:9005/app/service/take"
#else
#define   kAPI                @"http://m.51wrq.com"
#define   kWebsSocketUrl      @"ws://m.51wrq.com/app/service/take"
//#define   kAPI                @"http://warenqi.com"
//#define   kWebsSocketUrl      @"ws://warenqi.com/app/service/take"
#endif
//七牛api域名
#define kQN_API               @"http://7qndaf.com2.z0.glb.qiniucdn.com"
#define   kUploadImageToken   [NSString stringWithFormat:@"%@/user/upload/token",kAPI]
extern NSString *const UMengAppkey;
extern NSString *const WXAPPID;
extern NSString *const WXAPPSECRET;
extern NSString *const WBAPPID;
extern NSString *const WBAPPSECRET;
extern NSString *const QQAPPID;
extern NSString *const QQAPPKEY;
@interface DGConfig : NSObject

@end
