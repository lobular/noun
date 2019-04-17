//
//  NewsTableView.h
//  yuyan
//
//  Created by tangfeimu on 2019/4/17.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "BaseTableView.h"

typedef void (^JumpWhich)(NSString *url);

@interface NewsTableView : BaseTableView

@property (nonatomic,strong)NSArray *arr;

@property (nonatomic,copy)JumpWhich url;

@end


