//
//  WellHeaderViewController.m
//  yuyan
//
//  Created by tangfeimu on 2019/4/10.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "WellHeaderView.h"
#import "KeyChain.h"
#import "Tools.h"


@implementation WellHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self config];
    }
    return self;
}

- (void)config{
    for (int i = 0; i < 2; i ++) {
        _back = [UILabel new];
        [self addSubview:_back];
        _back.whc_TopSpace(0).whc_LeftSpace(i * ScreenWidth / 2).whc_Width(ScreenWidth / 2).whc_BottomSpace(0);
        _back.tag = 10000+i;
        _back.userInteractionEnabled = YES;
        [_back addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)]];
        _back.backgroundColor = [UIColor colorWithHexString:@"#f7f7f7"];
        if (i == 0) {
            _line = [UILabel new];
            [_back addSubview:_line];
            _line.whc_RightSpaceToView(0, _back).whc_CenterY(0).whc_Height(20).whc_Width(1);
            _line.backgroundColor = [UIColor colorWithHexString:@"#e5e5e5"];
        }
        _tip = [UIImageView new];
        [_back addSubview:_tip];
        _tip.whc_CenterYToView(0, _back).whc_LeftSpace(52).whc_Width(16).whc_Height(16);
        if (i == 0) {
            _tip.image = [UIImage imageNamed:@"money_icon"];
        }else{
            _tip.image = [UIImage imageNamed:@"exchange_icon"];
        }
        _name = [UILabel new];
        _name.font = FontSize(14);
        [_back addSubview:_name];
        _name.whc_CenterY(0).whc_LeftSpaceToView(5, _tip);
        if (i == 1) {
            _name.text = @"兑换记录";
            _name.textColor = [UIColor textColorWithType:0];
        }else{
            NSString *content = [NSString stringWithFormat:@"%@",[KeyChain objectWithKey:@"score"]];
            NSRange range = NSMakeRange(2,[content length]);
          _name.attributedText =  [Tools text:[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"信条%@",[KeyChain objectWithKey:@"score"]]] fontSize:14 color:[UIColor colorWithHexString:@"#FD6D08"] rang:range];
        }
    }
}

- (void)click:(UITapGestureRecognizer *)tap{
    self.which([NSString stringWithFormat:@"%ld",tap.view.tag - 10000]);
}

@end
