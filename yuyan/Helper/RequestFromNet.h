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

//信条详情
+ (void)getDataForList:(NSString *)url params:(NSDictionary *)params succ:(Succ)succ fault:(Fault)fault;

@end

