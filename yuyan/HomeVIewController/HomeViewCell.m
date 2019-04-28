//
//  HomeViewCell.m
//  yuyan
//
//  Created by tangfeimu on 2019/4/3.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "HomeViewCell.h"
#import "UIView+CornerRadiusLayer.h"
#import <UIImageView+WebCache.h>

@interface HomeViewCell()

@property (nonatomic,strong)UIImageView *tipImage;
@property (nonatomic,strong)UILabel *name;
@property (nonatomic,strong)UIImageView *addImage;
@property (nonatomic,strong)UILabel *addLabel;
@property (nonatomic,strong)UILabel *num;
@property (nonatomic,strong)UIButton *startBtn;
@property (nonatomic,strong)UILabel *line;

@end

@implementation HomeViewCell

+ (instancetype)cellWithTableView:(UITableView *)tabelView{
    static NSString *ID = @"homecell";
    HomeViewCell *cell = [tabelView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[HomeViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self ==  [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self config];
    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    return self;
}
- (void)config{
    if (!_tipImage){
        self.tipImage = [UIImageView new];
        [self.contentView addSubview:_tipImage];
        _tipImage.whc_CenterY(0).whc_LeftSpace(16).
        whc_Width(60).whc_Height(60);
        [_tipImage setLayerCornerRadius:4];
//        _tipImage.backgroundColor = [UIColor redColor];
    }
    if (!_name) {
        _name = [UILabel new];
        [self.contentView addSubview:_name];
        _name.whc_TopSpace(20).whc_LeftSpaceToView(10, _tipImage);
        _name.text = @"测试数据";
        _name.textColor = [UIColor textColorWithType:0];
        _name.font = FontSize(16);
    }
    if (!_addImage) {
        _addImage = [UIImageView new];
        [self.contentView addSubview:_addImage];
        _addImage.whc_LeftSpaceToView(10, _tipImage).whc_TopSpaceToView(10, _name).whc_Width(12).whc_Height(14);
        _addImage.image = [UIImage imageNamed:@"map_icon"];
//        _addImage.backgroundColor = [UIColor orangeColor];
    }
    if (!_addLabel) {
        _addLabel = [UILabel new];
        [self.contentView addSubview:_addLabel];
        _addLabel.whc_TopSpaceToView(10, _name).whc_LeftSpaceToView(5, _addImage);
        _addLabel.textColor = [UIColor textColorWithType:1];
        _addLabel.text = @"杭州市滨江区长河街道466号";
        _addLabel.font = FontSize(12);
    }
    if (!_num) {
        _num = [UILabel new];
        [self.contentView addSubview:_num];
        _num.whc_TopSpace(20).whc_RightSpace(20);
        _num.text = @"20雨燕币";
        _num.textColor = [UIColor colorWithHexString:@"#FD6D08"];
        _num.font = FontSize(16);
    }
    if (!_startBtn) {
        _startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_startBtn];
        _startBtn.whc_RightSpace(16).whc_TopSpaceToView(5, _num).whc_Width(68).whc_Height(30);
        _startBtn.backgroundColor = [UIColor colorWithHexString:@"#FFE656"];
        _startBtn.titleLabel.font = FontSize(12);
        [_startBtn setTitle:@"即将开始" forState:UIControlStateNormal];
        [_startBtn setTitleColor:[UIColor textColorWithType:0] forState:UIControlStateNormal];
        [_startBtn setLayerCornerRadius:15];
    }
    if (!_line) {
        _line = [UILabel new];
        [self.contentView addSubview:_line];
        _line.whc_LeftSpace(16).whc_RightSpace(16).
        whc_BottomSpace(0).whc_Height(0.5);
        _line.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    }
}

- (void)setValueForCell:(HomeModel *)model{
    [_tipImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.thumb]]];
    _addLabel.text = model.address;
    _name.text = model.title;
    _num.text = [NSString stringWithFormat:@"%@雨燕币",model.creed_award];
}

@end
