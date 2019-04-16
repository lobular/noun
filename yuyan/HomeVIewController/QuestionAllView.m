//
//  QuestionAllView.m
//  yuyan
//
//  Created by tangfeimu on 2019/4/12.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "QuestionAllView.h"
#import "UIView+CornerRadiusLayer.h"
#import "Tools.h"

@implementation QuestionAllView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self config:nil];
    }
    return self;
}

- (void)config:(NSArray *)arr{
    if (!_tip) {
        _tip = [UIImageView new];
        [self addSubview:_tip];
        _tip.whc_CenterX(0).whc_TopSpace(50).whc_Width(66).whc_Height(66);
        _tip.image = [UIImage imageNamed:@"exchange_success_icon"];
    }
    if (!_tipLabel) {
        _tipLabel = [UILabel new];
        [self addSubview:_tipLabel];
        _tipLabel.text = @"恭喜你答题完成";
        _tipLabel.font = FontSize(16);
        _tipLabel.whc_CenterX(0).whc_TopSpaceToView(18, _tip);
        _tipLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    }
    for (int i = 0; i < arr.count; i ++) {
        _resultLabel = [UILabel new];
        [self addSubview:_resultLabel];
        _resultLabel.whc_TopSpaceToView(i * 22 + 4, _tipLabel).whc_CenterX(0).whc_Height(22);
        _resultLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _resultLabel.font = FontSize(12);
        NSDictionary *dic = arr[i];
        NSString *key = [dic allKeys][i];
        if ([key integerValue] == 1 ||[key integerValue] == 2 || [key integerValue] == 3 ||[key integerValue] == 4) {
            NSInteger num = [key integerValue] + 1;
            NSString *str;
            switch ([[dic[key] allKeys][0] integerValue]) {
                case 1:
                    str = @"A";
                    break;
                case 2:
                    str = @"B";
                    break;
                case 3:
                    str = @"C";
                    break;
                case 4:
                    str = @"D";
                    break;
                default:
                    break;
            }
            _resultLabel.text = [NSString stringWithFormat:@"第%ld道题的正确答案为:%@ .%@",num,str,[dic[key] allValues][0]];
        }else{
            NSRange range = NSMakeRange(4, [[NSString stringWithFormat:@"%@",dic[key]] length]);
            _resultLabel.attributedText = [Tools text:[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"您将获得%@信条",dic[key]]] fontSize:16 color:[UIColor colorWithHexString:@"#FD6D08"] rang:range];
        }
        
    }
    if (!_converBtn) {
        _converBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_converBtn];
        _converBtn.whc_TopSpace(310 *ScaleHeight).whc_LeftSpace(16).whc_Width(166).whc_Height(44);
        [_converBtn setTitle:@"兑换奖品" forState:UIControlStateNormal];
        [_converBtn setTitleColor:[UIColor textColorWithType:0] forState:UIControlStateNormal];
        [_converBtn setLayerCornerRadius:22 borderWidth:1 borderColor:[UIColor textColorWithType:0]];
        _converBtn.titleLabel.font = FontSize(16);
    }
    if (!_againBtn) {
        _againBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_againBtn];
        _againBtn.whc_TopSpace(310 *ScaleHeight).whc_RightSpace(16).whc_Width(166).whc_Height(44);
        [_againBtn setTitle:@"继续答题" forState:UIControlStateNormal];
        [_againBtn setTitleColor:[UIColor textColorWithType:0] forState:UIControlStateNormal];
        [_againBtn setLayerCornerRadius:22];
        _againBtn.backgroundColor = [UIColor colorWithHexString:@"#FFE656"];
        _againBtn.titleLabel.font = FontSize(16);
    }
}

@end
