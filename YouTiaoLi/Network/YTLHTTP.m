//
//  YTLHTTP.m
//  YouTiaoLi
//
//  Created by 天蓝 on 2017/8/2.
//  Copyright © 2017年 PT. All rights reserved.
//

#import "YTLHTTP.h"

static YTLHTTP *_ytlTttp = nil;

@interface YTLHTTP ()
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@end

@implementation YTLHTTP

+ (void)initialize
{
    [self sharedYTLHTTP];
}

+ (instancetype)sharedYTLHTTP
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _ytlTttp = [[[self class] alloc] init];
    });
    return _ytlTttp;
}

+ (void)POST:(NSString *)action
  parameters:(NSDictionary *)parameters
     success:(void (^)(NSDictionary * responseObject))success
{
    [self POST:action parameters:parameters success:success failure:nil];
}

+ (void)POST:(NSString *)action
  parameters:(NSDictionary *)parameters
     success:(void (^)(NSDictionary * responseObject))success
     failure:(void (^)(NSError *error))failure
{
    [self POST:action parameters:parameters success:success failure:failure timeoutInterval:20];
}

+ (void)POST:(NSString *)action
  parameters:(NSDictionary *)parameters
     success:(void (^)(NSDictionary * responseObject))success
     failure:(void (^)(NSError *error))failure
timeoutInterval:(CGFloat)timeoutInterval
{
    [self POST:action parameters:parameters progress:nil success:success failure:failure timeoutInterval:timeoutInterval];
}

+ (void)POST:(NSString *)action
  parameters:(NSDictionary *)parameters
    progress:(void (^)(NSProgress * _Nonnull))progress
     success:(void (^)(NSDictionary * responseObject))success
     failure:(void (^)(NSError *error))failure
timeoutInterval:(CGFloat)timeoutInterval
{
    _ytlTttp.manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    _ytlTttp.manager.requestSerializer.timeoutInterval = timeoutInterval;
    _ytlTttp.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSMutableSet *set = _ytlTttp.manager.responseSerializer.acceptableContentTypes.mutableCopy;
    [set addObject:@"text/plain"];
    _ytlTttp.manager.responseSerializer.acceptableContentTypes = set;
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",kServerAddress,action];
    
    [_ytlTttp.manager POST:urlStr parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) progress(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) failure(error);
    }];
}



@end
