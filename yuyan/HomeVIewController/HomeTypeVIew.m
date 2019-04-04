//
//  HomeTypeVIew.m
//  yuyan
//
//  Created by tangfeimu on 2019/4/3.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "HomeTypeVIew.h"
#import "HomeModel.h"
#import <UIImageView+WebCache.h>

@implementation HomeTypeVIew

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createConfig];
    }
    return self;
}

- (void)createConfig{
    for (int i = 0; i < 5; i ++) {
        _backView = [UIView new];
        _backView.tag = 10000 + i;
        [self addSubview:_backView];
        _backView.whc_TopSpace(0).whc_BottomSpace(0).whc_LeftSpace(i *ScreenWidth / 5).whc_Width(ScreenWidth / 5);
        _typeImage = [UIImageView new];
        [_backView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)]];
        [_backView addSubview:_typeImage];
        _typeImage.whc_CenterX(0).whc_TopSpaceToView(27, _backView).whc_Width(30).whc_Height(30);
        _typeImage.backgroundColor = [UIColor orangeColor];
        _typeLabel = [UILabel new];
        [_backView addSubview:_typeLabel];
        _typeLabel.whc_CenterX(0).whc_TopSpaceToView(15, _typeImage);
        _typeLabel.textColor = [UIColor textColorWithType:0];
        _typeLabel.font = FontSize(12);
    }
}

- (void)click:(UITapGestureRecognizer *)tap{
    _succ(tap.view.tag);
}

@end
