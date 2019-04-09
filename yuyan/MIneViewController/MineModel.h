//
//  MineModel.h
//  yuyan
//
//  Created by tangfeimu on 2019/4/9.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MineModel : NSObject

@property (nonatomic,strong)NSString *desc;
@property (nonatomic,strong)NSString *note;
@property (nonatomic,strong)NSString *opt;
@property (nonatomic,strong)NSString *time;

@end

@interface RecordModel : NSObject

@property (nonatomic,strong)NSString *rec_id;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *thumb;
@property (nonatomic,strong)NSString *valid_date;

@end

