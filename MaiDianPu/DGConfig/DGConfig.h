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

//extern是计算机语言中的一个函数，可置于变量或者函数前，以表示变量或者函数的定义在别的文件中。提示编译器遇到此变量或函数时，在其它模块中寻找其定义，另外，extern也可用来进行链接指定。
extern NSString *const UMengAppkey;
extern NSString *const WXAPPID;
extern NSString *const WXAPPSECRET;
extern NSString *const WBAPPID;
extern NSString *const WBAPPSECRET;
extern NSString *const QQAPPID;
extern NSString *const QQAPPKEY;
@interface DGConfig : NSObject

@end
