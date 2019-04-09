//
//  HomeDetailViewController.m
//  yuyan
//
//  Created by tangfeimu on 2019/4/8.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "HomeDetailViewController.h"
#import "RequestFromNet.h"
#import <SVProgressHUD.h>
#import <UIImageView+WebCache.h>
#import "HomeModel.h"
#import "UIView+CornerRadiusLayer.h"

@interface HomeDetailViewController ()

@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UIImageView *address;
@property (nonatomic,strong)UILabel *add;
@property (nonatomic,strong)UILabel *line;
@property (nonatomic,strong)UILabel *tip;
@property (nonatomic,strong)UILabel *num;
@property (nonatomic,strong)UIButton *btn;

@property (nonatomic,strong)NSDictionary *dataDic;
@property (nonatomic,strong)detailModel *model;


@end

@implementation HomeDetailViewController

- (NSDictionary *)dataDic{
    if (!_dataDic) {
        _dataDic = [NSDictionary dictionary];
    }
    return _dataDic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationTitle:self.name LeftBtnHidden:NO RightBtnHidden:YES];
    
    [self getData];
    
}

- (void)leftBtnAcion:(id)sender;{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)getData{
    [SVProgressHUD show];
    [RequestFromNet getDetailForCreed:DetailAPI params:@{@"creed_id":self.creed_id} succ:^(NSDictionary *dataDic) {
        [SVProgressHUD dismiss];
        if ([dataDic[@"status"]isEqualToString:@"success"]) {
            self.dataDic = dataDic;
            self.model = self.dataDic[@"creed"];
            [self createConfig];
        }else{
            [SVProgressHUD showErrorWithStatus:dataDic[@"message"]];
        }
    } fault:^(NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"网络异常,请稍后重试"];
    }];
}

#pragma mark config
- (void)createConfig{
    
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        [self.view addSubview:_imageView];
        _imageView.whc_TopSpace(NavigationHeight).whc_LeftSpace(0).whc_RightSpace(0).whc_Height(257);
        [_imageView sd_setImageWithURL:[NSURL URLWithString:self.model.thumb]];
    }
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        [self.view addSubview:_titleLabel];
        _titleLabel.whc_TopSpaceToView(10, _imageView).whc_LeftSpace(16);
        _titleLabel.text = self.model.title;
        _titleLabel.textColor = [UIColor textColorWithType:0];
        _titleLabel.font = FontSize(16);
    }
    if (!_address) {
        _address = [UIImageView new];
        [self.view addSubview:_address];
        _address.whc_LeftSpace(16).whc_TopSpaceToView(10, _titleLabel).whc_Width(12).whc_Height(14);
        _address.image = [UIImage imageNamed:@"map_icon"];
    }
    if (!_add) {
        _add = [UILabel new];
        [self.view addSubview:_add];
        _add.whc_LeftSpaceToView(6, _address).whc_TopSpaceToView(10, _titleLabel);
        _add.textColor = [UIColor textColorWithType:1];
        _add.text = self.model.address;
        _add.font = FontSize(12);
    }
    if (!_line) {
        _line = [UILabel new];
        [self.view addSubview:_line];
        _line.whc_TopSpaceToView(45, _add).whc_LeftSpace(16).whc_RightSpace(16).whc_Height(0.5);
        _line.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
    }
    if (!_tip) {
        _tip = [UILabel new];
        [self.view addSubview:_tip];
        _tip.whc_LeftSpace(16).whc_TopSpaceToView(37, _line);
        _tip.textColor = [UIColor textColorWithType:0];
        _tip.text = [NSString stringWithFormat:@"答题成功将获得%@信条",self.model.creed_award];
        _tip.font = FontSize(13);
    }
    if (!_num) {
        _num = [UILabel new];
        [self.view addSubview:_num];
        _num.whc_RightSpace(15).whc_TopSpaceToView(37, _line);
        _num.textColor = [UIColor textColorWithType:0];
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"还剩%@信条",self.model.creed_remain]];
        NSRange range = NSMakeRange(2, [self.model.creed_remain length]);
        // 改变字体大小及类型
       [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#FD6D08"] range:range];
        // 为label添加Attributed
        [_num setAttributedText:noteStr];
    }
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:_btn];
        _btn.whc_BottomSpace(25).whc_LeftSpace(16).whc_RightSpace(16).whc_Height(44);
        _btn.backgroundColor = [UIColor colorWithHexString:@"#FFE656"];
        [_btn setTitle:@"答题赢信条" forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor textColorWithType:0] forState:UIControlStateNormal];
        _btn.titleLabel.font = FontSize(16);
        [_btn setLayerCornerRadius:22];
    }
}

@end
