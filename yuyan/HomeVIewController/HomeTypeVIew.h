//
//  HomeTypeVIew.h
//  yuyan
//
//  Created by tangfeimu on 2019/4/3.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^Success)(NSInteger num);

@interface HomeTypeVIew : UIView

@property (nonatomic,strong)UIView *backView;
@property (nonatomic,strong)UIImageView *typeImage;
@property (nonatomic,strong)UILabel *typeLabel;


@property (nonatomic,copy)Success succ;

@end

