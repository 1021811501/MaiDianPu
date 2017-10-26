//
//  WeChatPay.m
//  warenqi
//
//  Created by 李志帅 on 16/8/19.
//  Copyright © 2016年 Mr.Lin. All rights reserved.
//

#import "WeChatPay.h"

@implementation WeChatPay
+(instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static WeChatPay *instance;
    dispatch_once(&onceToken, ^{
        instance = [[WeChatPay alloc] init];
    });
    return instance;
}
-(AFHTTPSessionManager *)createHttpManager{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript",@"text/plain", nil]];
    manager.requestSerializer.timeoutInterval = 10;
    [manager.requestSerializer setValue:@"Ko;l47q6P`KZo:=xTc]39CJ`JPwGJ=fss8n:MaxR[YjPVN/2DI6`>5g3KdfMKpS9" forHTTPHeaderField:@"secret"];
    return manager;
    
}
-(void)weChatPayWithActivityId:(long)activityId andShare:(long)shareCount andVersionType:(VersonType)type{
    [self requestOrderSignInfoWithActivityId:activityId andShare:shareCount andVersionType:type];
}
-(void)weChatPayRechargeCoinWithAmount:(int)amount andVersionType:(VersonType)type{
    [self requestToRechargeCoinByWeChatWithAmount:amount andVersionType:type];
}
-(void)requestOrderSignInfoWithActivityId:(long)activityId andShare:(long)shareCount andVersionType:(VersonType)type{
    if ([self.delegate respondsToSelector:@selector(weChatPayGetOrderInfoStart)]) {
        [self.delegate weChatPayGetOrderInfoStart];
    }
//    AFHTTPSessionManager *manager = [self createHttpManager];
//    [GetToken getTokenSucess:^(id result, NSURLResponse *response, NSError *error) {
//        NSString *ipAddress = [[NSUserDefaults standardUserDefaults] objectForKey:kMyIp];
//        NSDictionary *dic = @{
//                              @"activityId":[NSString stringWithFormat:@"%ld",activityId],
//                              @"share":[NSString stringWithFormat:@"%ld",shareCount],
//                              @"ip":ipAddress,
//                              @"authenticityToken":result,
//                              @"type":[NSString stringWithFormat:@"%d",type]
//                              };
//        [manager POST:kGetWeChatOrderUrl parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            if ([[responseObject objectForKey:@"code"]integerValue] == 200) {
//                [self openWeChatPayWith:responseObject];
//            }else{
//                POPALERTSTRING([responseObject objectForKey:@"msg"]);
//            }
//            if ([self.delegate respondsToSelector:@selector(weChatPayGetOrderInfoEnd)]) {
//                [self.delegate weChatPayGetOrderInfoEnd];
//            }
//
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                        if ([self.delegate respondsToSelector:@selector(weChatPayGetOrderInfoEnd)]) {
//                            [self.delegate weChatPayGetOrderInfoEnd];
//                        }
//            POPALERTSTRING(@"请稍后重试!")
//        }];
//    } Failed:^(id result, NSURLResponse *response, NSError *error) {
//                if ([self.delegate respondsToSelector:@selector(weChatPayGetOrderInfoEnd)]) {
//                    [self.delegate weChatPayGetOrderInfoEnd];
//                }
//        POPALERTSTRING(@"请稍后重试!")
//        
//    }];
}
-(void)requestToRechargeCoinByWeChatWithAmount:(int)amount andVersionType:(VersonType)type{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:0];
    [dic setObject:[NSString stringWithFormat:@"%d",amount] forKey:@"amount"];
    [dic setObject:@"192.168.1.1" forKey:@"ip"];
    if (type == VersonTypeRecharge) {
        [dic setObject:@"INGOT" forKey:@"tradeType"];
    }else{
        [dic setObject:@"MEMBER" forKey:@"tradeType"];
    }
    if ([self.delegate respondsToSelector:@selector(weChatPayGetOrderInfoStart)]) {
        [self.delegate weChatPayGetOrderInfoStart];
    }
    AFHTTPSessionManager *manager = [self createHttpManager];
//        [manager POST:kRechargeWeChatOrderUrl parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            if ([[responseObject objectForKey:@"code"]integerValue] == 200) {
//                [self openWeChatPayWith:responseObject];
//            }else{
//                POPALERTSTRING([responseObject objectForKey:@"msg"]);
//            }
//            if ([self.delegate respondsToSelector:@selector(weChatPayGetOrderInfoEnd)]) {
//                [self.delegate weChatPayGetOrderInfoEnd];
//            }
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            if ([self.delegate respondsToSelector:@selector(weChatPayGetOrderInfoEnd)]) {
//                [self.delegate weChatPayGetOrderInfoEnd];
//            }
//            POPALERTSTRING(@"请稍后重试!");
//        }];
}
-(void)openWeChatPayWith:(id _Nullable)responseObject{
    NSLog(@"%@",responseObject);
    PayReq *req = [[PayReq alloc] init];
    req.partnerId = [[responseObject objectForKey:@"results" ] objectForKey:@"partnerid"];
    req.prepayId = [[responseObject objectForKey:@"results" ] objectForKey:@"prepayid"];
    self.prepayId = req.prepayId;
    req.nonceStr = [[responseObject objectForKey:@"results" ] objectForKey:@"noncestr"];
    req.timeStamp = [[[responseObject objectForKey:@"results" ] objectForKey:@"timestamp"] intValue];
    req.package = [[responseObject objectForKey:@"results" ] objectForKey:@"package"];
    req.sign = [[responseObject objectForKey:@"results" ] objectForKey:@"sign"];

    [WXApi sendReq:req];
}
-(void)onResp:(BaseResp*)resp{
    if ([resp isKindOfClass:[PayResp class]]){
        PayResp*response=(PayResp*)resp;
        switch(response.errCode){
            case WXSuccess:
                //服务器端查询支付通知或查询API返回的结果再提示成功
                //                NSlog(@"支付成功");
                [self requestToPayResultWithPrepayId:self.prepayId];
            
                NSLog(@"支付成功");
                break;
            default:
                NSLog(@"支付失败，retcode=%d",resp.errCode);
                if ([self.delegate respondsToSelector:@selector(weChatPayResultFaile: andStatus:)]) {
                    [self.delegate weChatPayResultFaile:self.prepayId andStatus:@"FAIl"];
                }
                break;
        }
    }
}
-(void)requestToPayResultWithPrepayId:(NSString *)prepayId{
    AFHTTPSessionManager *manager = [self createHttpManager];
//    [manager GET:kWeChatPayResultUrl parameters:@{@"prepayId":prepayId} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        if ([[responseObject objectForKey:@"code"] intValue] == 200) {
//            if ([self.delegate respondsToSelector:@selector(weChatPayResultSucess: andStatus:)]) {
//                [self.delegate weChatPayResultSucess:self.prepayId andStatus:[[responseObject objectForKey:@"results"] objectForKey:@"status"]];
//            }
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//    }];
}
@end
