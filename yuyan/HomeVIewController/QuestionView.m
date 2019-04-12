//
//  QuestionView.m
//  yuyan
//
//  Created by tangfeimu on 2019/4/12.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "QuestionView.h"
#import "UIView+CornerRadiusLayer.h"

@interface QuestionView ()

{
    NSInteger num;
}

@end

@implementation QuestionView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self config];
    }
    return self;
}

- (void)config{
    if (!_title) {
        _title = [[UILabel alloc] init];
        [self addSubview:_title];
        _title.whc_TopSpace(22).whc_LeftSpace(24).whc_RightSpace(24);
        _title.textColor = [UIColor textColorWithType:0];
        _title.font = [UIFont systemFontOfSize:16];
        _title.textAlignment = NSTextAlignmentLeft;
        _title.numberOfLines = 0;
    }
    for (int i = 0; i < 4; i++) {
        _questionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_questionBtn];
        _questionBtn.whc_TopSpaceToView(23 + i * 55, self.title).whc_RightSpace(16).whc_HeightAuto().whc_LeftSpace(16);
        _questionBtn.tag = 10000+ i ;
        _questionBtn.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
        [_questionBtn setLayerCornerRadius:18 borderWidth:1 borderColor:[UIColor colorWithHexString:@"#dcdcdc"]];
        [_questionBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        
        _flagImage = [[UIImageView alloc] init];
        [_questionBtn addSubview:_flagImage];
        _flagImage.image = [UIImage imageNamed:@"Circle"];
        _flagImage.tag = 10000+i;
        [_flagImage setLayerCornerRadius:15 / 2];
        _flagImage.whc_CenterY(0).whc_LeftSpace(16).whc_Width(15).whc_Height(15);
        
        _content = [[UILabel alloc] init];
        [_questionBtn addSubview:_content];
        _content.whc_CenterY(0).whc_LeftSpace(40).whc_HeightAuto();
        _content.tag = 30000+i;
        _content.numberOfLines = 0;
        _content.font = [UIFont systemFontOfSize:16];
        _content.textColor = [UIColor colorWithHexString:@"#666666"];
    }
    if (!_nextBtn) {
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_nextBtn];
        _nextBtn.whc_TopSpaceToView(44 *ScaleHeight, _questionBtn).whc_LeftSpace(24).whc_RightSpace(24).whc_Height(40);
        _nextBtn.backgroundColor = [UIColor colorWithHexString:@"#FFE656"];
        [_nextBtn setTitle:@"下一题" forState:UIControlStateNormal];
        [_nextBtn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        _nextBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_nextBtn setLayerCornerRadius:20];
    }
}

- (void)sendValue:(ClickSucc)value{
    value(num);
}

- (void)clickAction:(UIButton *)btn{
    num = btn.tag;
    UIButton *btn0 = [(UIButton *)self viewWithTag:10000];
    UIButton *btn1 = [(UIButton *)self viewWithTag:10001];
    UIButton *btn2 = [(UIButton *)self viewWithTag:10002];
    UIButton *btn3 = [(UIButton *)self viewWithTag:10003];
    if (btn.tag == 10000) {
        for (UIImageView *tmp in btn0.subviews) {
            if ([tmp isKindOfClass:[UIImageView class]]) {
                tmp.image = [UIImage imageNamed:@"Circle_press"];
            }
        }
        for (UIImageView *tmp in btn1.subviews) {
            if ([tmp isKindOfClass:[UIImageView class]]) {
                tmp.image = [UIImage imageNamed:@"Circle"];
            }
        }
        for (UIImageView *tmp in btn2.subviews) {
            if ([tmp isKindOfClass:[UIImageView class]]) {
                tmp.image = [UIImage imageNamed:@"Circle"];
            }
        }
        for (UIImageView *tmp in btn3.subviews) {
            if ([tmp isKindOfClass:[UIImageView class]]) {
                tmp.image = [UIImage imageNamed:@"Circle"];
            }
        }
    }else if (btn.tag == 10001){
        for (UIImageView *tmp in btn1.subviews) {
            if ([tmp isKindOfClass:[UIImageView class]]) {
                tmp.image = [UIImage imageNamed:@"Circle_press"];
            }
        }
        for (UIImageView *tmp in btn0.subviews) {
            if ([tmp isKindOfClass:[UIImageView class]]) {
                tmp.image = [UIImage imageNamed:@"Circle"];
            }
        }
        for (UIImageView *tmp in btn2.subviews) {
            if ([tmp isKindOfClass:[UIImageView class]]) {
                tmp.image = [UIImage imageNamed:@"Circle"];
            }
        }
        for (UIImageView *tmp in btn3.subviews) {
            if ([tmp isKindOfClass:[UIImageView class]]) {
                tmp.image = [UIImage imageNamed:@"Circle"];
            }
        }
    }else if (btn.tag == 10002){
        for (UIImageView *tmp in btn2.subviews) {
            if ([tmp isKindOfClass:[UIImageView class]]) {
                tmp.image = [UIImage imageNamed:@"Circle_press"];
            }
        }
        for (UIImageView *tmp in btn1.subviews) {
            if ([tmp isKindOfClass:[UIImageView class]]) {
                tmp.image = [UIImage imageNamed:@"Circle"];
            }
        }
        for (UIImageView *tmp in btn0.subviews) {
            if ([tmp isKindOfClass:[UIImageView class]]) {
                tmp.image = [UIImage imageNamed:@"Circle"];
            }
        }
        for (UIImageView *tmp in btn3.subviews) {
            if ([tmp isKindOfClass:[UIImageView class]]) {
                tmp.image = [UIImage imageNamed:@"Circle"];
            }
        }
    }else if (btn.tag == 10003){
        for (UIImageView *tmp in btn3.subviews) {
            if ([tmp isKindOfClass:[UIImageView class]]) {
                tmp.image = [UIImage imageNamed:@"Circle_press"];
            }
        }
        for (UIImageView *tmp in btn1.subviews) {
            if ([tmp isKindOfClass:[UIImageView class]]) {
                tmp.image = [UIImage imageNamed:@"Circle"];
            }
        }
        for (UIImageView *tmp in btn2.subviews) {
            if ([tmp isKindOfClass:[UIImageView class]]) {
                tmp.image = [UIImage imageNamed:@"Circle"];
            }
        }
        for (UIImageView *tmp in btn0.subviews) {
            if ([tmp isKindOfClass:[UIImageView class]]) {
                tmp.image = [UIImage imageNamed:@"Circle"];
            }
        }
    }
}


@end
