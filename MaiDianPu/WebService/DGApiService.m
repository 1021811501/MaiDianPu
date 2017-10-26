//
//  DGApiService.m
//  WaRenQiSeller
//
//  Created by JasonLee on 2017/6/14.
//  Copyright © 2017年 JasonLee. All rights reserved.
//

#import "DGApiService.h"

@implementation DGApiService
+(id)serviceWithDelegate:(id <DGApiServiceDelegate>)delegate{
    return [self serviceWithTag:0 delegate:delegate];
}
+(id)serviceWithTag:(NSInteger)tag delegate:(id <DGApiServiceDelegate>)delegate{
    DGApiService *service = [[self alloc] init];
    service.delegate = delegate;
    service.tag = tag;
    return service;
}
-(void)sendJSONRequest:(DGApiRequest *)apiRequest{
    [self sendRequest:apiRequest withCompletion:^(id data, NSInteger responsecode, NSError *error) {
        if (error) {
            DGApiResponse *response = [DGApiResponse responseWithDictionary:data responseCode:responsecode error:error];
            if ([self.delegate respondsToSelector:@selector(service:requestFailed:withResponse:)]) {
                [self.delegate service:self requestFailed:apiRequest withResponse:response];
            }
        }else{
            DGApiResponse *response = [DGApiResponse responseWithDictionary:data responseCode:responsecode error:error];
            if ([self.delegate respondsToSelector:@selector(service:didFinishRequest:withResponse:)]) {
                [self.delegate service:self didFinishRequest:apiRequest withResponse:response];
            }
        }
    }];
}
-(void)sendDownloadrequestWith:(DGApiRequest *)apiRequest andUrl:(NSString *)url{
    if ([self.delegate respondsToSelector:@selector(service:willStartRequest:)]) {
        [self.delegate service:self willStartRequest:apiRequest];
    }
    NSURLSessionDownloadTask *sessionTask = [self createDownloadTaskWithRequest:apiRequest andUrl:url progress:^(NSProgress * _Nonnull downloadProgress) {
        if ([self.delegate respondsToSelector:@selector(service:apiRequest:downloadProgress:)]) {
            [self.delegate service:self apiRequest:apiRequest downloadProgress:downloadProgress];
        }
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error, NSInteger responseCode) {
        if (error) {
            DGApiResponse *response = [DGApiResponse responseWithDictionary:nil responseCode:responseCode error:error];
            if ([self.delegate respondsToSelector:@selector(service:requestFailed:withResponse:)]) {
                [self.delegate service:self requestFailed:apiRequest withResponse:response];
            }
        }else{
            DGApiResponse *response = [DGApiResponse responseWithDictionary:nil responseCode:responseCode error:error];
            if ([self.delegate respondsToSelector:@selector(service:didFinishRequest:withResponse:)]) {
                [self.delegate service:self didFinishRequest:apiRequest withResponse:response];
            }
        }
    }];
    [sessionTask resume];
}
-(void)sendRequest:(DGApiRequest *)apiRequest withCompletion:(void(^)(id data,NSInteger responsecode,NSError *error))completion{
    if ([self.delegate respondsToSelector:@selector(service:willStartRequest:)]) {
        [self.delegate service:self willStartRequest:apiRequest];
    }
    NSURLSessionTask *sessionTask = nil;
    switch (apiRequest.content) {
        case ApiRequestContentJSON:
        {
            sessionTask = [self createJasonDataTaskWithRequest:apiRequest completion:completion];
            [self logJsonDataRequestCall:sessionTask];
        }
            break;
            
        default:
            break;
    }
    [sessionTask resume];
}
-(NSURLSessionTask *)createJasonDataTaskWithRequest:(DGApiRequest *)apiRequest completion:(void (^)(id data,NSInteger responseCode,NSError *error))completion{
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableURLRequest *request = [self createJasonRequestWithApiRequest:apiRequest];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSHTTPURLResponse *httprResponse = (NSHTTPURLResponse *)response;
        NSInteger responseCode = httprResponse.statusCode;
        if (error) {
            [self logRequest:request response:(NSHTTPURLResponse *)response withError:error];
            completion(nil,responseCode,error);
        }else{
            id json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            [self logRequest:request response:(NSHTTPURLResponse *)response data:responseObject];
            completion(json, responseCode, nil);
        }
    }];
    return dataTask;
}
-(NSURLSessionDownloadTask *)createDownloadTaskWithRequest:(DGApiRequest *)apiRequest andUrl:(NSString *)url progress:(void(^)(NSProgress * _Nonnull downloadProgress))progress completionHandler:(void(^)(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error, NSInteger responseCode))completion {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%.2f-------------",downloadProgress.completedUnitCount/downloadProgress.totalUnitCount * 1.0);
        progress(downloadProgress);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSURL *url = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [url URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        NSLog(@"File downloaded to: %@", filePath);
        NSHTTPURLResponse *httprResponse = (NSHTTPURLResponse *)response;
        NSInteger responseCode = httprResponse.statusCode;
        if (error) {
            [self logRequest:request response:(NSHTTPURLResponse *)response withError:error];
            completion(response,filePath,error,responseCode);
        }else{
            [self logRequest:request response:(NSHTTPURLResponse *)response data:nil];
            completion(response, filePath, nil, responseCode);
        }
    }];
    return task;
}
-(NSMutableURLRequest *)createJasonRequestWithApiRequest:(DGApiRequest *)apiRequest{
    AFHTTPRequestSerializer *afHttpRequestSerializer = [AFHTTPRequestSerializer serializer];
    [afHttpRequestSerializer setTimeoutInterval:apiRequest.timeout];
    [afHttpRequestSerializer setValue:@"Ko;l47q6P`KZo:=xTc]39CJ`JPwGJ=fss8n:MaxR[YjPVN/2DI6`>5g3KdfMKpS9" forHTTPHeaderField:@"secret"];
    NSString *method = nil;
    if (apiRequest.method == ApiRequestMethodGet) {
        method = @"GET";
    }
    if (apiRequest.method == ApiRequestMethodPost) {
        method = @"POST";
    }
    if (apiRequest.method == ApiRequestMethodDelete) {
        method = @"DELETE";
    }
    if (apiRequest.method == ApiRequestMethodPut) {
        method = @"PUT";
    }
    NSMutableURLRequest *request = [afHttpRequestSerializer requestWithMethod:method URLString:apiRequest.url parameters:apiRequest.parameters error:nil];
    [apiRequest setJsonHTTPHeadersForRequest:request];
    return request;
}

- (void)logJsonDataRequestCall:(NSURLSessionTask *)sessionTask {
#if DEBUG
    NSLog(@"----------- WEBSERVICE CALL ----------%@",[sessionTask.currentRequest description]);
    NSData *httpBodyData = sessionTask.currentRequest.HTTPBody;
    NSString *httpBody =  [[NSString alloc] initWithData:httpBodyData encoding:(NSUTF8StringEncoding)];
    NSString *httpMethod = sessionTask.currentRequest.HTTPMethod;
    printf("/%s: %s\n%s\n%s\n",[httpMethod cStringUsingEncoding:NSASCIIStringEncoding], [[[sessionTask.currentRequest URL] absoluteString] cStringUsingEncoding:NSASCIIStringEncoding], [[sessionTask.currentRequest.allHTTPHeaderFields description] cStringUsingEncoding:NSASCIIStringEncoding], [[[httpBody toDictionaryAsJSON] description] cStringUsingEncoding:NSUTF8StringEncoding]);
    NSLog(@"--------- END WEBSERVICE CALL --------%@",[sessionTask.currentRequest description]);
#endif
}
- (void)logRequest:(NSURLRequest*)request response:(NSHTTPURLResponse*)response data:(id)data {
#if DEBUG
    NSLog(@"*********** WEBSERVICE RESPONSE ***********%@",[request description]);
    NSLog(@"Response From Called URL: %s\n%s\n%ld\n%@\n", [[[request URL] absoluteString] cStringUsingEncoding:NSASCIIStringEncoding], [[response.allHeaderFields description] cStringUsingEncoding:NSASCIIStringEncoding], (long)response.statusCode, [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil]);
    NSLog(@"*********** END WEBSERVICE RESPONSE ***********%@",[request description]);
#endif
}

- (void)logRequest:(NSURLRequest*)request response:(NSHTTPURLResponse*)response withError:(NSError*)error {
#if DEBUG
    NSLog(@"*********** WEBSERVICE CALL FAILED ***********%@",[request description]);
    NSLog(@"Response From Called URL: %s\n%s\n%ld\n%@\n", [[[request URL] absoluteString] cStringUsingEncoding:NSASCIIStringEncoding], [[response.allHeaderFields description] cStringUsingEncoding:NSASCIIStringEncoding], (long)response.statusCode, [error description]);
    NSLog(@"*********** END WEBSERVICE CALL FAILED ***********%@",[request description]);
#endif
}
@end
