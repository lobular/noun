//
//  NetWorkSingle.h
//  yuyan
//
//  Created by tangfeimu on 2019/3/27.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^Success)(NSDictionary *dataDic);
typedef void (^Fault)(NSError *error);

//请求超时
#define  TIMEOUT 20

/**
 * 网络请求的类型
 **/

typedef NS_ENUM(NSUInteger,HttpRequestType){
    
    //get请求
    HttpRequestTypeGet = 0,
    
    //post请求
    HttpRequestTypePost
    
};

@interface NetWorkSingle : NSObject

+ (instancetype)shareInstance;

/**
 *
 *  @param URLString  请求网址字符串
 *  @param parameters 请求参数
 *  @param success    请求成功回调
 *  @param failure    请求失败回调
 *
 **/

+ (void)getWithURLString:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;


/**
 *  post请求
 *
 *  @param URLString  请求网址字符串
 *  @param parameters 请求参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */

+ (void)postWithURLString:(NSString *)URLString parameters:(id)parameters success:(Success)success failure:(Fault)failure;

/**
 *  发送网络请求
 *
 *  @param URLString  请求的网址字符串
 *  @param parameters 请求的参数
 *  @param type       请求的类型
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */

+ (void)requestWithURLString:(NSString *)URLString parameters:(id)parameters type:(HttpRequestType)type success:(Success)success failyre:(Fault)failure;


@end

