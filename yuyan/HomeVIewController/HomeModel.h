//
//  HomeModel.h
//  yuyan
//
//  Created by tangfeimu on 2019/4/3.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HomeModel : NSObject

@property (nonatomic,strong)NSString *creed_id;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *thumb;
@property (nonatomic,strong)NSString *address;
@property (nonatomic,strong)NSString *creed_award;

@end

@interface BannerModel : NSObject

@property (nonatomic,strong)NSString *pic;
@property (nonatomic,strong)NSString *creed_id;

@end

@interface TypeModel : NSObject

@property (nonatomic,strong)NSString *cate_id;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *pic;

@end

@interface CityModel : NSObject

@property (nonatomic,strong)NSString *city_id;
@property (nonatomic,strong)NSString *city_name;
@property (nonatomic,strong)NSString *poster;

@end

