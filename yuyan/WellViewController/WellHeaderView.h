//
//  WellHeaderViewController.h
//  yuyan
//
//  Created by tangfeimu on 2019/4/10.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "WellHeaderView.h"

typedef void (^Click)(NSString *which);

@interface WellHeaderView : UIView

@property (nonatomic,strong)UILabel *back;
@property (nonatomic,strong)UIImageView *tip;
@property (nonatomic,strong)UILabel *name;
@property (nonatomic,strong)UILabel *line;

@property (nonatomic,copy)Click which;

@end
