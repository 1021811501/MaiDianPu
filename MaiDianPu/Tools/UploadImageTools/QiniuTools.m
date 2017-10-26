//
//  QiniuTools.m
//  七牛
//
//  Created by 李志帅 on 16/4/6.
//  Copyright © 2016年 李志帅. All rights reserved.
//

#import "QiniuTools.h"
#import "AFNetworking.h"

@implementation QiniuTools

+(void)uploadImageToQNImageDictionary:(NSDictionary *)imageDic WithSucess:(void(^)(id urlDic))sucess andFail:(void(^)(id error))fail{
    NSMutableDictionary *newImageDic = [self getNewImage:imageDic];
    NSArray *newImageArray = [newImageDic allKeys];
    
    NSMutableDictionary *urlDic = [NSMutableDictionary dictionaryWithCapacity:0];
        //1.管理器
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript",@"text/plain", nil]];
    manager.requestSerializer.timeoutInterval = 10;
    [manager.requestSerializer setValue:@"Ko;l47q6P`KZo:=xTc]39CJ`JPwGJ=fss8n:MaxR[YjPVN/2DI6`>5g3KdfMKpS9" forHTTPHeaderField:@"secret"];
    
    [manager GET:kUploadImageToken parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString * token = responseObject[@"results"];
        QNUploadManager *upManager = [[QNUploadManager alloc] init];
        QNUploadOption * uploadOption = [[QNUploadOption alloc] initWithMime:nil progressHandler:^(NSString *key, float percent) {
            NSLog(@"percent == %.2f",percent);
        } params:nil checkCrc:NO cancellationSignal:nil];
        for (int i = 0; i< newImageArray.count; i++) {
            UIImage *image = [newImageDic objectForKey:newImageArray[i]];
            NSString*fileName = [NSString stringWithFormat:@"%@_%@.png", [self getDateTimeString], [self randomStringWithLength:8]];
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                // 并行执行的线程一
                //                    NSLog(@"新图片再次压缩后大小%ld",UIImageJPEGRepresentation(image, 0.8).length );
                [upManager putData:UIImageJPEGRepresentation(image, 0.8) key:fileName token:token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                    NSLog(@"%d",info.statusCode);
                    NSString *urlStr = [NSString stringWithFormat:@"%@/%@",kQN_API,resp[@"key"]];
                    //                        [urlArr addObject:urlStr];
                    [urlDic setObject:urlStr forKey:newImageArray[i]];
                    if ([urlDic allKeys].count == newImageArray.count) {
                        sucess(urlDic);
                    }
                } option:uploadOption];
                
            });
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        fail(error);
    }];
}
+(NSMutableDictionary *)getNewImage:(NSDictionary *)imageDic{
    //    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    NSArray *imageArray = [imageDic allKeys];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:0];
    for (int i = 0; i < imageArray.count; i++) {
        UIImage *newImage = [self getSmallImage:[imageDic objectForKey:imageArray[i]]];
        [dic setObject:newImage forKey:imageArray[i]];
        NSData *data = UIImageJPEGRepresentation(newImage, 1);
        NSLog(@"新图片大小:%ld 宽%f 高%f",data.length,newImage.size.width,newImage.size.height);
        //        [array addObject:newImage];
    }
    return dic;
}
+(UIImage *)getSmallImage:(UIImage *)source_image{
    //先调整分辨率
    CGSize newSize = CGSizeMake(source_image.size.width, source_image.size.height);
    
    CGFloat tempHeight = newSize.height / 800;
    CGFloat tempWidth = newSize.width / 800;
    
    if (tempWidth > 1.0 && tempWidth > tempHeight) {
        newSize = CGSizeMake(source_image.size.width / tempWidth, source_image.size.height / tempWidth);
    }
    else if (tempHeight > 1.0 && tempWidth < tempHeight){
        newSize = CGSizeMake(source_image.size.width / tempHeight, source_image.size.height / tempHeight);
    }
    
    UIGraphicsBeginImageContext(newSize);
    [source_image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
+ ( NSString* )getDateTimeString

{
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];
//    NSDateFormatter*formatter;
//    
//    NSString*dateString;
//    
//    formatter = [[NSDateFormatter alloc]init];
//    
//    [formatter setDateFormat:@"yyyy-MM-dd-mm:ss"];
//    
//    dateString = [formatter stringFromDate:[NSDate date]];
    
    return [NSString stringWithFormat:@"%f",timeInterval];
    
}

+ (NSString*)randomStringWithLength:(int)len

{
    
    NSString*letters =@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for(int i=0; i < len;i++ ){
        
        [randomString appendFormat:@"%C", [letters characterAtIndex:arc4random_uniform((int)[letters length])]];
        
    }
    
    return randomString;
    
}

@end
