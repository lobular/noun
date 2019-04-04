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
        _city.whc_CenterY(0).whc_LeftSpace(16);
        _city.textColor = [UIColor colorWithHexString:@"#070707"];
        _city.text = @"全部";
        _city.font = FontSize(12);
    }
    if (!_tipImage) {
        _tipImage = [UIImageView new];
        _tipImage.userInteractionEnabled = YES;
        [self addSubview:_tipImage];
        _tipImage.whc_CenterY(0).whc_LeftSpaceToView(8, _city).whc_Width(7).whc_Height(4);
        _tipImage.backgroundColor = [UIColor redColor];
    }
    if (!_title) {
        _title = [UILabel new];
        [self addSubview:_title];
        _title.whc_CenterY(0).whc_CenterX(0);
        _title.textColor = [UIColor textColorWithType:0];
        _title.text = @"雨燕信条";
    }
    if (!_newsImage) {
        _newsImage = [UIImageView new];
        [self addSubview:_newsImage];
        _newsImage.whc_CenterY(0).whc_RightSpace(16)
        .whc_Width(18).whc_Height(16);
        _newsImage.backgroundColor = [UIColor blueColor];
        
    }
    if (!_searchImage) {
        _searchImage = [UIImageView new];
        [self addSubview:_searchImage];
        _searchImage.whc_CenterY(0).whc_RightSpaceToView(20, _newsImage).whc_CenterY(0).whc_Width(17).whc_Height(17);
        _searchImage.backgroundColor = [UIColor orangeColor];
    }
}

@end
