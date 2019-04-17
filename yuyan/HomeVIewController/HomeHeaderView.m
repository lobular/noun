//
//  HomeHeaderView.m
//  yuyan
//
//  Created by tangfeimu on 2019/4/3.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "HomeHeaderView.h"

@implementation HomeHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createSub];
    }
    return self;
}

- (void)createSub{
    if (!_city) {
        self.city = [UILabel new];
        [self addSubview:self.city];
        _city.userInteractionEnabled = YES;
        _city.whc_BottomSpace(27).whc_LeftSpace(16);
        _city.textColor = [UIColor colorWithHexString:@"#070707"];
        _city.text = @"全部";
        _city.font = FontSize(12);
    }
    if (!_tipImage) {
        _tipImage = [UIImageView new];
        _tipImage.userInteractionEnabled = YES;
        [self addSubview:_tipImage];
        _tipImage.whc_CenterYToView(0, _city).whc_LeftSpaceToView(8, _city).whc_Width(7).whc_Height(4);
        _tipImage.image = [UIImage imageNamed:@"systen-Triangle_press_icon"];
    }
    if (!_title) {
        _title = [UILabel new];
        [self addSubview:_title];
        _title.whc_BottomSpace(20).whc_CenterX(0);
        _title.textColor = [UIColor textColorWithType:0];
        _title.text = @"雨燕信条";
    }
    if (!_newsImage) {
        _newsImage = [UIImageView new];
        [self addSubview:_newsImage];
        _newsImage.userInteractionEnabled = YES;
        _newsImage.whc_BottomSpace(27).whc_RightSpace(16)
        .whc_Width(18).whc_Height(16);
        _newsImage.image = [UIImage imageNamed:@"new_icon"];
        
    }
    if (!_searchImage) {
        _searchImage = [UIImageView new];
        _searchImage.userInteractionEnabled = YES;
        [self addSubview:_searchImage];
        _searchImage.whc_BottomSpace(27).whc_RightSpaceToView(20, _newsImage).whc_Width(17).whc_Height(17);
        _searchImage.image = [UIImage imageNamed:@"system-serchb_press_icon"];
    }
}

@end
