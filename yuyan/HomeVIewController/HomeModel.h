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
@property (nonatomic,strong)NSString *title;

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

@interface detailModel : NSObject

@property (nonatomic,strong)NSString *address;
@property (nonatomic,strong)NSString *creed_award;
@property (nonatomic,strong)NSString *creed_remain;
@property (nonatomic,strong)NSString *thumb;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSArray *questions;
@property (nonatomic,strong)NSString *creed_id;

@end

@interface questionModel : NSObject

@property (nonatomic,strong)NSArray *answers;
@property (nonatomic,strong)NSString *name;

@end

@interface isRightModel: NSObject

@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *is_true;

@end

@interface messageModel : NSObject

@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *des;
@property (nonatomic,strong)NSString *created_time;
@property (nonatomic,strong)NSString *h5_url;

@end

