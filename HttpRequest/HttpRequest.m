//
//  HttpRequest.m
//  02-爱限免首页
//
//  Created by vera on 16/9/2.
//  Copyright © 2016年 deli. All rights reserved.
//

#import "HttpRequest.h"
#import "AFNetworking.h"

@implementation HttpRequest

/**
 *  get请求
 *
 *  @param urlstring url
 *  @param paramters 参数
 *  @param success   成功回调
 *  @param failure   失败回调
 */
+ (void)GET:(NSString *)urlstring paramters:(NSDictionary *)paramters success:(HttpRequestSuccessCallBack)success failure:(HttpRequestFailureCallBack)failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //发送异步请求
    /**
     发送异步请求：
     参数1：url
     参数2：参数
     参数3：进度回调
     参数4：请求成功的回调
     参数5：请求失败的回调
     */
    [manager GET:urlstring parameters:paramters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success)
        {
            //成功的回调
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure)
        {
            //失败回调
            failure(error);
        }
    }];
    
}

@end
