//
//  BaseNavigationBar.m
//  yuyan
//
//  Created by tangfeimu on 2019/3/27.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "BaseNavigationBar.h"
#import "UIColor+Category.h"

@interface BaseNavigationBar()

@property (strong,nonatomic)UIButton * leftBtn;
@property (strong,nonatomic)UILabel * titleLabel;
@property (nonatomic, strong) UIView *bottomview;

@end

@implementation BaseNavigationBar
- (id)initWithFrame:(CGRect)frame withTitle:(NSString *)title withLeftBtnHidden:(BOOL)l_hidden withRightBtnHidden:(BOOL)r_hidden{
    if (self = [super initWithFrame:frame]) {
         self.backgroundColor = [UIColor colorWithHexString:@"#F7F7F8" alpha:0.95];
        if (title) {
            self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, frame.size.height - 44, ScreenWidth - 110, 44)];
            self.titleLabel.backgroundColor = [UIColor clearColor];
            self.titleLabel.textColor = [UIColor textColorWithType:0];
            self.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:17];
            self.titleLabel.text = title;
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:self.titleLabel];
        }
        if (!l_hidden) {
            _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [_leftBtn setTitleColor:[UIColor mainColor] forState:UIControlStateNormal];
            _leftBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
            [self.leftBtn addTarget:self action:@selector(clickLeftBtn:) forControlEvents:UIControlEventTouchUpInside];
            self.leftBtn.frame = CGRectMake(0, frame.size.height - 44, 55, 42);
            [self.leftBtn setImage:[UIImage imageNamed:@"back_black_icon"] forState:UIControlStateNormal];
            [self.leftBtn setImageEdgeInsets:UIEdgeInsetsMake(14, 15, 10, 30)];
            [self addSubview:_leftBtn];
            self.leftBtn.hidden = l_hidden;
        }
        if (!r_hidden) {
            _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [_rightBtn setTitleColor:[UIColor mainColor] forState:UIControlStateNormal];
            _rightBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
            [_rightBtn addTarget:self action:@selector(clickRightBtn:) forControlEvents:UIControlEventTouchUpInside];
            _rightBtn.frame = CGRectMake(frame.size.width - 35,frame.size.height - 30, 18, 16);
            [_rightBtn setBackgroundImage:[[UIImage imageNamed:@"new_icon"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
            _rightBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
//            [_rightBtn setImageEdgeInsets:UIEdgeInsetsMake(30, 30, 16, 12)];
            [_rightBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
            [self addSubview:_rightBtn];
            _rightBtn.hidden = r_hidden;
        }
        [self addSubview:self.bottomview];
    }
    return self;
}

- (UIView *)bottomview {
    if (!_bottomview) {
        _bottomview = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-LineHeight, ScreenWidth, LineHeight)];
        _bottomview.backgroundColor = [UIColor separationColor];
    }
    return _bottomview;
}

- (void)setLeftButtonTitle:(NSString *)title {
    [self.leftBtn setImage:nil forState:UIControlStateNormal];
    [self.leftBtn setTitle:title forState:UIControlStateNormal];
}

- (void)clickLeftBtn:(id)sender {
    if (_delegate&&[_delegate respondsToSelector:@selector(leftBtnAcion:)]) {
        [_delegate leftBtnAcion:sender];
    }
}
- (void)clickRightBtn:(id)sender {
    if (_delegate&&[_delegate respondsToSelector:@selector(rightBtnAcion:)]) {
        [_delegate rightBtnAcion:sender];
    }
}

@end
