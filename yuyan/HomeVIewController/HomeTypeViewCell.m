//
//  HomeTypeViewCell.m
//  yuyan
//
//  Created by tangfeimu on 2019/4/19.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "HomeTypeViewCell.h"
#import "HomeModel.h"
#import <UIImageView+WebCache.h>

@implementation HomeTypeViewCell

+ (instancetype)initWithTable:(UITableView *)table;{
    HomeTypeViewCell *cell = [table dequeueReusableCellWithIdentifier:@"type"];
    if (!cell) {
        cell = [[HomeTypeViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self config:nil];
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
    return self;
}
- (void)config:(NSArray *)arr{
    for (int i = 0; i < 5; i ++) {
        _backView = [UIView new];
        _backView.tag = 10000 + i;
        [self addSubview:_backView];
        _backView.whc_TopSpace(0).whc_BottomSpace(0).whc_LeftSpace(i *ScreenWidth / 5).whc_Width(ScreenWidth / 5);
        _typeImage = [UIImageView new];
        [_backView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)]];
        [_backView addSubview:_typeImage];
        _typeImage.whc_CenterX(0).whc_TopSpaceToView(27, _backView).whc_Width(30).whc_Height(30);
        TypeModel *model = arr[i];
        [_typeImage sd_setImageWithURL:[NSURL URLWithString:model.pic]] ;
        _typeLabel = [UILabel new];
        [_backView addSubview:_typeLabel];
        _typeLabel.whc_CenterX(0).whc_TopSpaceToView(15, _typeImage);
        _typeLabel.textColor = [UIColor textColorWithType:0];
        _typeLabel.font = FontSize(12);
        _typeLabel.text = model.title;
    }
}

- (void)click:(UITapGestureRecognizer *)tap{
    if (self.succ) {
         self.succ(tap.view.tag);
    }
}

@end
