//
//  HomeDetailViewController.h
//  yuyan
//
//  Created by tangfeimu on 2019/4/8.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "BaseViewController.h"


@interface HomeDetailViewController : BaseViewController

@property (nonatomic,strong)NSString *creed_id;
@property (nonatomic,strong)NSString *name;

@property (nonatomic,strong)NSString *fromWhich; //是福利详情还是其他的
@property (nonatomic,strong)NSString *good_id;

@end

