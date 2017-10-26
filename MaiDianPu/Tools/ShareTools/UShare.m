//
//  UShare.m
//  WaShiKe
//
//  Created by Mr.Lin. on 2017/3/13.
//  Copyright © 2017年 JasonLee. All rights reserved.
//

#import "UShare.h"

@implementation UShare

+ (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType{
    
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"分享" descr:@"第一试客" thumImage:[UIImage imageNamed:@"loginLogo_big@2x"]];
    shareObject.webpageUrl = @"http://www.baidu.com";
    messageObject.shareObject = shareObject;

    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
    }];
}

@end
