//
//  ClassHeaderVIew.m
//  yuyan
//
//  Created by tangfeimu on 2019/4/4.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "ClassHeaderVIew.h"
#import "UIView+CornerRadiusLayer.h"

@implementation ClassHeaderVIew

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self config];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)config{
    if (!_news) {
        _news = [UIImageView new];
        [self addSubview:_news];
        _news.userInteractionEnabled = YES;
        _news.whc_BottomSpace(13).whc_RightSpace(16).
        whc_Width(18).whc_Height(16);
        _news.image = [UIImage imageNamed:@"new_press_icon"];
    }
    if (!_backView) {
        _backView = [UIView new];
        [self addSubview:_backView];
        _backView.whc_LeftSpace(16).whc_BottomSpace(10).
        whc_Height(28).whc_RightSpaceToView(16, _news);
        [_backView setLayerCornerRadius:5];
        _backView.backgroundColor = [UIColor colorWithHexString:@"#f1f3f5"];
    }
    if (!_search) {
        _search = [UIImageView new];
        _search.userInteractionEnabled = YES;
        [_backView addSubview:_search];
        _search.whc_CenterY(0).whc_LeftSpace(12).
        whc_Height(17).whc_Width(17);
        _search.image = [UIImage imageNamed:@"system-serchbicon"];
    }
    if (!_content) {
        _content = [[UITextField alloc] init];
        [_backView addSubview:_content];
        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
        attributes[NSForegroundColorAttributeName] = [UIColor colorWithHexString:@"#bbbbbb"];
        attributes[NSFontAttributeName] = [UIFont fontWithName:@"PingFangSC-Regular" size:18];
        _content.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入搜索内容" attributes:attributes];
        _content.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
        _content.whc_CenterY(0).whc_LeftSpaceToView(5, _search).whc_TopSpace(0).whc_BottomSpace(0).whc_RightSpace(0);
    }
    
}

@end
