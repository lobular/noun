//
//  ClassModel.h
//  yuyan
//
//  Created by tangfeimu on 2019/4/4.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ClassModel : NSObject

@property (nonatomic,strong)NSString *cate_id;
@property (nonatomic,strong)NSArray *child;
@property (nonatomic,strong)NSString *pic;
@property (nonatomic,strong)NSString *title;

@end

@interface childModel : NSObject

@property (nonatomic,strong)NSString *creed_id;
@property (nonatomic,strong)NSString *thumb;
@property (nonatomic,strong)NSString *title;

@end

