//
//  HomeHeaderViewCell.m
//  yuyan
//
//  Created by tangfeimu on 2019/4/8.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "HomeHeaderViewCell.h"
#import "UIView+CornerRadiusLayer.h"

static NSString *ID = @"header";

@implementation HomeHeaderViewCell

+ (instancetype)initWithTable:(UITableView *)table{
    HomeHeaderViewCell *cell = [table dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[HomeHeaderViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self config];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
- (void)config{
    if (!_name) {
        _name = [UILabel new];
        [self.contentView addSubview:_name];
        _name.whc_TopSpace(19).whc_LeftSpace(16);
        _name.textColor = [UIColor textColorWithType:0];
        _name.font = FontSize(24);
        _name.text = @"欢迎来到雨燕";
    }
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_btn];
        _btn.whc_LeftSpace(16).whc_TopSpaceToView(7, _name).whc_Height(32).whc_Width(120);
        [_btn setTitle:@"马上注册/登录" forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor textColorWithType:0] forState:UIControlStateNormal];
        _btn.titleLabel.font = FontSize(12);
        _btn.backgroundColor = [UIColor colorWithHexString:@"#FFE656"];
        [_btn setLayerCornerRadius:16];
    }
    if (!_headerImage) {
        _headerImage = [UIImageView new];
        [self.contentView addSubview:_headerImage];
        _headerImage.whc_CenterY(0).whc_RightSpace(16).whc_Width(58).whc_Height(58);
        _headerImage.image = [UIImage imageNamed:@"mine_icon1"];
    }
}

@end
