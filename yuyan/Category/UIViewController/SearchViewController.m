//
//  SearchViewController.m
//  yuyan
//
//  Created by tangfeimu on 2019/4/8.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "SearchViewController.h"

@interface HeaderView : UIView

@property (nonatomic,strong)UITextField *text;
@property (nonatomic,strong)UIButton *tipBtn;
@property (nonatomic,strong)UILabel *line;
@property (nonatomic,strong)UIButton *returnBtn;

@end
@implementation HeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createHeader];
    }
    return self;
}

- (void)createHeader{
    if (!_returnBtn) {
        _returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_returnBtn];
        self.returnBtn.frame = CGRectMake(0,NavigationHeight - 44, 55, 42);
        [self.returnBtn setImage:[UIImage imageNamed:@"back_black_icon"] forState:UIControlStateNormal];
        [self.returnBtn setImageEdgeInsets:UIEdgeInsetsMake(14, 0, 10, 30)];
    }
    if (!_text) {
        _text = [UITextField new];
        [self addSubview:_text];
        _text.font = FontSize(13);
        _text.backgroundColor = [UIColor colorWithHexString:@"#f1f3f5"];
        _text.placeholder = @"请输入要搜索的内容";
        _text.whc_BottomSpace(6).whc_LeftSpace(25).whc_RightSpace(50).whc_Height(28);
    }
    if (!_tipBtn) {
        _tipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_tipBtn];
        [_tipBtn setTitle:@"搜索" forState:UIControlStateNormal];
        _tipBtn.titleLabel.font = FontSize(12);
        [_tipBtn setTitleColor:[UIColor textColorWithType:0] forState:UIControlStateNormal];
        _tipBtn.whc_CenterYToView(0, _text).whc_RightSpace(0).whc_LeftSpaceToView(2, _text).whc_Height(28);
    }
    if (!_line) {
        _line = [UILabel new];
        [self addSubview:_line];
        _line.whc_BottomSpace(0).whc_LeftSpace(0).whc_RightSpace(0).whc_Height(0.5);
        _line.backgroundColor = [UIColor colorWithHexString:@"#f1f3f5"];
    }
}

@end

@interface cell : UITableViewCell

@property (nonatomic,strong)UILabel *text;
@property (nonatomic,strong)UILabel *line;

+ (instancetype)initWithTable:(UITableView *)table;

@end

static NSString *ID = @"cell";
@implementation cell

+ (instancetype)initWithTable:(UITableView *)table{
    cell *cells = [table dequeueReusableCellWithIdentifier:ID];
    if (!cells) {
        cells = [[cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cells;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self config];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)config{
    if (!_text) {
        _text = [UILabel new];
        _text.textColor = [UIColor colorWithHexString:@"#333333"];
        _text.font = FontSize(15);
        _text.text = @"787878";
        [self.contentView addSubview:_text];
        _text.whc_CenterY(0).whc_LeftSpace(16);
    }
    if (!_line) {
        _line = [UILabel new];
        _line.textColor = [UIColor colorWithHexString:@"#f1f3f5"];
        [self.contentView addSubview:_line];
        _line.whc_BottomSpace(0).whc_LeftSpace(16).whc_RightSpace(0).whc_Height(0.5);
    }
}

@end

@interface SearchViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic,strong)HeaderView *header;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)cell *cells;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self headerView];
    [self createTableView];
    
}

- (void)headerView{
    if (!_header) {
        _header = [[HeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, NavigationHeight)];
        [self.view addSubview:_header];
    }
    _header.text.delegate = self;
    _header.tipBtn.tag = 10000 + 1;
    [_header.tipBtn addTarget:self action:@selector(search:) forControlEvents:UIControlEventTouchUpInside];
     [_header.returnBtn addTarget:self action:@selector(clickLeftBtn) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)clickLeftBtn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)createTableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavigationHeight, ScreenWidth, ScreenHeight - NavigationHeight) style:UITableViewStylePlain];
    }
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   return [cell initWithTable:tableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

#pragma mark
- (void)search:(UIButton *)btn{
    if (btn.tag - 10000 == 1) {
        [_header.tipBtn setTitle:@"取消" forState:UIControlStateNormal];
        _header.tipBtn.tag = 10000 + 2;
    }else{
        [_header.tipBtn setTitle:@"搜索" forState:UIControlStateNormal];
        _header.tipBtn.tag = 10000 + 1;
    }
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [_header.tipBtn setTitle:@"取消" forState:UIControlStateNormal];
    _header.tipBtn.tag = 10000 + 2;
    
}

@end
