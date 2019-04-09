//
//  JDCategoryLeftTableCell.m
//  分类列表联动
//
//  Created by yifo on 2018/8/3.
//  Copyright © 2018年 yanhaiqiang. All rights reserved.
//

#import "JDCategoryLeftTableCell.h"
#import "UIView+CornerRadiusLayer.h"

@interface JDCategoryLeftTableCell ()
@end

@implementation JDCategoryLeftTableCell
+ (instancetype)cellWithTableView:(UITableView *)tabelView {
    static NSString *ID = @"JDCategoryLeftTableCell";
    JDCategoryLeftTableCell *cell = [tabelView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews {
    
    _titleLabel = [UILabel new];
    [self.contentView addSubview:_titleLabel];
    _titleLabel.whc_CenterX(0).whc_CenterY(0).
    whc_LeftSpace(8).whc_RightSpace(8).whc_Height(25);
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = FontSize(12);
    [_titleLabel setLayerCornerRadius:15];
    _titleLabel.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_titleLabel];
    
    if (!_line) {
        _line = [UILabel new];
        [self.contentView addSubview:_line];
        _line.whc_TopSpace(0).whc_LeftSpace(0).whc_RightSpace(0).whc_Height(0.5);
        _line.backgroundColor = [UIColor colorWithHexString:@"#f1f3f5"];
        _line.hidden = YES;
    }
}




@end
