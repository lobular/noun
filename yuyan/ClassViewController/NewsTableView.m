//
//  NewsTableView.m
//  yuyan
//
//  Created by tangfeimu on 2019/4/17.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "NewsTableView.h"
#import "HomeModel.h"


@interface NewsCell : UITableViewCell

@property (nonatomic,strong)UIImageView *image;
@property (nonatomic,strong)UILabel *title;
@property (nonatomic,strong)UILabel *content;
@property (nonatomic,strong)UILabel *time;
@property (nonatomic,strong)UILabel *line;

+ (instancetype)initWithTableView:(UITableView *)table;

@end

@implementation NewsCell

+ (instancetype)initWithTableView:(UITableView *)table{
    NewsCell *cell = [table dequeueReusableCellWithIdentifier:@"news"];
    if (!cell) {
        cell = [[NewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"news"];
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
    if (!_image) {
        _image = [UIImageView new];
        [self.contentView addSubview:_image];
        _image.whc_CenterY(0).whc_LeftSpace(16).whc_Width(48).whc_Height(48);
        _image.image = [UIImage imageNamed:@"call_icon"];
    }
    if (!_time) {
        _time = [UILabel new];
        [self.contentView addSubview:_time];
        _time.whc_TopSpace(20).whc_RightSpace(14);
        _time.textColor = [UIColor textColorWithType:1];
        _time.font = FontSize(12);
    }
    if (!_title) {
        _title = [UILabel new];
        _title.numberOfLines = 1;
        [self.contentView addSubview:_title];
        _title.whc_TopSpace(17).whc_LeftSpaceToView(19, _image).whc_Width(152 *ScaleWidth);
        _title.textColor = [UIColor textColorWithType:0];
        _title.font = FontSize(16);
    }
    if (!_content) {
        _content = [UILabel new];
        [self.contentView addSubview:_content];
        _content.numberOfLines = 1;
        _content.whc_TopSpaceToView(5, _title).whc_LeftSpaceToView(19, _image).whc_RightSpace(14);
        _content.textColor = [UIColor textColorWithType:1];
        _content.font = FontSize(12);
    }
    if (!_time) {
        _time = [UILabel new];
        [self.contentView addSubview:_time];
        _time.whc_TopSpace(20).whc_RightSpace(14);
        _time.textColor = [UIColor textColorWithType:1];
        _time.font = FontSize(12);
    }
    if (!_line) {
        _line = [UILabel new];
        [self.contentView addSubview:_line];
        _line.whc_LeftSpace(16).whc_RightSpace(16).
        whc_BottomSpace(0).whc_Height(0.5);
        _line.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    }
}

@end

@interface NewsTableView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation NewsTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
        self.rowHeight = 80;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self registerClass:NewsCell.class forCellReuseIdentifier:@"news"];
    }
    return self;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NewsCell *cell = [NewsCell initWithTableView:tableView];
    messageModel *model = self.arr[indexPath.row];
    cell.title.text = model.title;
    cell.content.text = model.des;
    cell.time.text = model.created_time;
    return cell;
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arr.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    messageModel *model = self.arr[indexPath.row];
    if (self.url) {
         self.url(model.h5_url);
    }
}

@end
