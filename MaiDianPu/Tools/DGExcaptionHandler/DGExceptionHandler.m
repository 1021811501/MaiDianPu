//
//  DGExceptionHandler.m
//  ExceptionHandler
//
//  Created by JasonLee on 17/4/14.
//  Copyright © 2017年 JasonLee. All rights reserved.
//

#import "DGExceptionHandler.h"

@implementation DGExceptionHandler
+(void)uploadExcaptionTxtWithUrl:(NSString *)url{
//    AFHTTPRequestOperationManager *requestManager = [AFHTTPRequestOperationManager manager];
//    [requestManager POST:@"http://192.168.10.18:8080/AFNetworkingServer/upload" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        
//        /**
//         *  appendPartWithFileURL   //  指定上传的文件
//         *  name                    //  指定在服务器中获取对应文件或文本时的key
//         *  fileName                //  指定上传文件的原始文件名
//         *  mimeType                //  指定商家文件的MIME类型
//         */
//        [formData appendPartWithFileURL:filePath name:@"file" fileName:[NSString stringWithFormat:@"%@.png",fileName] mimeType:@"image/png" error:nil];
//        
//    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        [[[UIAlertView alloc] initWithTitle:@"上传结果" message:[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]  delegate:self cancelButtonTitle:@"" otherButtonTitles:nil] show];
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        NSLog(@"获取服务器响应出错");
//        
//    }];
//    
//}
}
+ (void)caughtExceptionHandler{
    //指定crash的处理方法。
    NSSetUncaughtExceptionHandler(& UncaughtExceptionHandler);
}

+ (void)fileCreate{
    
    NSString *path = [DGExceptionHandler exceptionPath];
    
    NSFileManager *manager =[NSFileManager defaultManager];
    
    //文件不存在时创建
    
    if (![manager fileExistsAtPath:path])
        
    {
        
        NSString *dateString = [DGExceptionHandler currentTime];
        
        NSString *logStr = [NSString stringWithFormat:@"================\n文件创建时间：%@\n================",dateString];
        
        NSData *data = [logStr dataUsingEncoding:NSUTF8StringEncoding];
        
        
        
        [data writeToFile:path atomically:YES];
        
        
        
    }
    
}



void UncaughtExceptionHandler(NSException *exception) {
    
    /**
     
     *  获取异常崩溃信息
     
     */
    
    //在这里创建一个接受crash的文件
    
    [DGExceptionHandler fileCreate];
    
    NSArray *callStack = [exception callStackSymbols];
    
    NSString *reason = [exception reason];
    
    NSString *name = [exception name];
    
    
    
    NSString *dateString = [DGExceptionHandler currentTime];
    
    
    
    NSString *systemName = [[UIDevice currentDevice] systemName];
    
    
    NSString *systemNum = [[UIDevice currentDevice]systemVersion];
    
    
    NSString *strModel = [[UIDevice currentDevice] model];
    
    
    
    NSDictionary* infoDict =[[NSBundle mainBundle] infoDictionary];
    
    NSString *bundleIdentifier = infoDict[@"CFBundleIdentifier"];
    
    NSString* versionNum = [infoDict objectForKey:@"CFBundleShortVersionString"];
    
    
    
    NSString *content = [NSString stringWithFormat:@"\n\n\n========异常错误报告========\n错误时间:%@ 系统：%@ 系统版本: %@\n设备:%@\nAPP当前版本:%@ 当前唯一标示符:%@\n\n错误名称:%@\n错误原因:\n%@\ncallStackSymbols:\n%@\n\n========异常错误结束========\n",dateString,systemName,systemNum,strModel,versionNum,bundleIdentifier,name,reason,[callStack componentsJoinedByString:@"\n"]];
    
    
    
    NSString *path = [DGExceptionHandler exceptionPath];
    
    
    
    NSFileHandle *outFile = [NSFileHandle fileHandleForWritingAtPath:path];
    
    //找到并定位到outFile的末尾位置(在此后追加文件)
    
    [outFile seekToEndOfFile];
    
    
    
    [outFile writeData:[content dataUsingEncoding:NSUTF8StringEncoding]];
    
    //关闭读写文件
    
    [outFile closeFile];
    
    
    
    
    
}

+ (NSString *)exceptionPath{
    
    NSString *documents = [NSHomeDirectory()stringByAppendingPathComponent:@"Documents"];
    
    NSString *path = [documents stringByAppendingPathComponent:@"exceptionHandler.txt"];
    
    
    NSLog(@"%@",path);
    return path;
    
    
    
}

+ (NSString *)currentTime{
    
    NSDate *date = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm"];
    
    NSString *dateString = [formatter stringFromDate:date];
    
    return dateString;
    
    
    
}

@end
