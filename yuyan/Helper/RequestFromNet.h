//
//  RequestFromNet.h
//  yuyan
//
//  Created by tangfeimu on 2019/3/27.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^Succ)(NSDictionary *dataDic);
typedef void (^Fault)(NSError *error);


@interface RequestFromNet : NSObject

//首页
+ (void)getDataFromNetForHome:(NSString *)url param:(NSDictionary *)params succ:(Succ)succ fault:(Fault)fault;

//分类列表
+ (void)getDataForCateList:(NSString *)url succ:(Succ)succ fault:(Fault)fault;

//信条列表
+ (void)getDataForList:(NSString *)url params:(NSDictionary *)params succ:(Succ)succ fault:(Fault)fault;
//信条详情
+ (void)getDetailForCreed:(NSString *)url params:(NSDictionary *)params succ:(Succ)succ fault:(Fault)fault;

//通用接口
+ (void)getDataForCustom:(NSString *)url params:(NSDictionary *)params succ:(Succ)succ fault:(Fault)fault;

//我的信条
+ (void)getListForCreed:(NSString *)url params:(NSDictionary *)params succ:(Succ)succ fault:(Fault)fault;
//兑换记录
+ (void)getRecordForGoods:(NSString *)url params:(NSDictionary *)params succ:(Succ)succ fault:(Fault)fault;

//福利
+ (void)getWellFromNet:(NSString *)url params:(NSDictionary *)params succ:(Succ)succ fault:(Fault)fault;

//福利
+ (void)getWellDetailFromNet:(NSString *)url params:(NSDictionary *)params succ:(Succ)succ fault:(Fault)fault;

//获取答题列表
+ (void)getQuestionListForNet:(NSString *)url params:(NSDictionary *)params succ:(Succ)succ fault:(Fault)fault;

//搜索
+ (void)getSearchListForNet:(NSString *)url params:(NSDictionary *)params succ:(Succ)succ fault:(Fault)fault;

//消息列表
+ (void)getMessageListFromNet:(NSString *)url params:(NSDictionary *)params succ:(Succ)succ fault:(Fault)fault;

@end

