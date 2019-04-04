//
//  RequestFromNet.m
//  yuyan
//
//  Created by tangfeimu on 2019/3/27.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "RequestFromNet.h"
#import "NetWorkSingle.h"
#import <MJExtension.h>
#import "HomeModel.h"
#import "ClassModel.h"

@implementation RequestFromNet

//首页
+ (void)getDataFromNetForHome:(NSString *)url param:(NSDictionary *)params succ:(Succ)succ fault:(Fault)fault;{
    [NetWorkSingle getWithURLString:url parameters:nil success:^(id responseObject) {
        NSArray *banner = [BannerModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"banners"]];
        NSArray *creeds = [HomeModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"creeds"]];
        NSArray *type = [TypeModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"cate_list"]];
        NSArray *openCity = [CityModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"open_city"]];
        NSArray *featureCity = [CityModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"feature_city"]];
        NSDictionary *dic = @{@"banner":banner,@"creeds":creeds,@"type":type,@"openCity":openCity,@"featureCity":featureCity,@"status":responseObject[@"status"],@"message":responseObject[@"message"]};
        succ(dic);
    } failure:^(NSError *error) {
        fault(error);
    }];
}

//分类列表
+ (void)getDataForCateList:(NSString *)url succ:(Succ)succ fault:(Fault)fault;{
    [NetWorkSingle getWithURLString:url parameters:nil success:^(id responseObject) {
        NSArray *fatherArr = [ClassModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        NSMutableArray *all = [NSMutableArray arrayWithCapacity:0];
        NSArray *arr;
        for (NSDictionary *dic in responseObject[@"data"]) {
            arr = [childModel mj_objectArrayWithKeyValuesArray:dic[@"child"]];
         [all addObject:arr];
        }
        NSDictionary *dic = @{@"father":fatherArr,@"child":all,@"status":responseObject[@"status"],@"message":responseObject[@"message"]};
        succ(dic);
    } failure:^(NSError *error) {
        fault(error);
    }];
}

//信条详情
+ (void)getDataForList:(NSString *)url params:(NSDictionary *)params succ:(Succ)succ fault:(Fault)fault;{
    [NetWorkSingle getWithURLString:url parameters:params success:^(NSDictionary *dataDic) {
        NSArray *creeds = [HomeModel mj_objectArrayWithKeyValuesArray:dataDic[@"data"][@"creeds"]];
        NSDictionary *dic = @{@"list":creeds,@"status":dataDic[@"status"],@"message":dataDic[@"message"]};
        succ(dic);
    } failure:^(NSError *error) {
        fault(error);
    }];
}

@end
