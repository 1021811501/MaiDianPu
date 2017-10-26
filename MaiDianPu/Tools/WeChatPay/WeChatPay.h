//
//  WeChatPay.h
//  warenqi
//
//  Created by 李志帅 on 16/8/19.
//  Copyright © 2016年 Mr.Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GetIPAddress.h"
#import "WXApi.h"
typedef NS_ENUM(int,VersonType){
    VersonTypeRecharge,           //充值
    VersonTypeMember,            //充会员
};
@protocol WeChatPayDelegate <NSObject>
/*
 开始获取订单信息
 这里可以让你的菊花转起来
 */
-(void)weChatPayGetOrderInfoStart;

/*
 获取订单信息成功
 我想你的菊花已经累了吧,休息一下,吧你的菊花隐藏掉吧
 */
-(void)weChatPayGetOrderInfoEnd;

/*
 微信同步返回支付结果以服务器结果为准
 支付成功
 */
-(void)weChatPayResultSucess:(NSString *)prepayId andStatus:(NSString *)status;

/*
微信同步返回支付结果以服务器结果为准
支付失败
 */
-(void)weChatPayResultFaile:(NSString *)prepayId andStatus:(NSString *)status;
@end

@interface WeChatPay : NSObject <WXApiDelegate>

@property(nonatomic,weak)id <WeChatPayDelegate>delegate;
@property(nonatomic,copy)NSString *prepayId;
@property(nonatomic,assign)VersonType versonType;
+(instancetype)sharedManager;
//参数1:活动Id   参数2:购买数量
-(void)weChatPayWithActivityId:(long)activityId andShare:(long)shareCount andVersionType:(VersonType)type;
//微信充值
-(void)weChatPayRechargeCoinWithAmount:(int)amount andVersionType:(VersonType)type;


@end
