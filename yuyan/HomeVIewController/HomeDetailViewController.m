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
#import "Tools.h"
#import "ExchangeViewController.h"
#import "QuestionViewController.h"
#import "KeyChain.h"

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
    

    if ([self.fromWhich isEqualToString:@"well"]) {
        [self setNavigationTitle:@"奖品名称" LeftBtnHidden:NO RightBtnHidden:YES];
        [self getData:WellDetailAPI params:@{@"goods_id":self.good_id}];
    }else{
         [self setNavigationTitle:self.name LeftBtnHidden:NO RightBtnHidden:YES];
         [self getData:DetailAPI params:@{@"creed_id":self.creed_id}];
    }
    
}

- (void)leftBtnAcion:(id)sender;{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)getData:(NSString *)url params:(NSDictionary *)params{
    [SVProgressHUD show];
    if ([self.fromWhich isEqualToString:@"well"]) {
        [RequestFromNet getWellDetailFromNet:url params:params succ:^(NSDictionary *dataDic) {
            [SVProgressHUD dismiss];
            self.dataDic = dataDic[@"data"];
            [self createConfig];
        } fault:^(NSError *error) {
            [SVProgressHUD dismiss];
            [SVProgressHUD showErrorWithStatus:@"网络异常,请稍后重试"];
        }];
    }else{
        [RequestFromNet getDetailForCreed:url params:params succ:^(NSDictionary *dataDic) {
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
}

#pragma mark config
- (void)createConfig{
    
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        [self.view addSubview:_imageView];
        _imageView.whc_TopSpace(NavigationHeight).whc_LeftSpace(0).whc_RightSpace(0).whc_Height(257);
        if ([self.fromWhich isEqualToString:@"well"]) {
            [_imageView sd_setImageWithURL:[NSURL URLWithString:self.dataDic[@"thumb"]]];
        }else{
            [_imageView sd_setImageWithURL:[NSURL URLWithString:self.model.thumb]];
        }
    }
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        [self.view addSubview:_titleLabel];
        _titleLabel.whc_TopSpaceToView(10, _imageView).whc_LeftSpace(16);
        if ([self.fromWhich isEqualToString:@"well"]) {
            _titleLabel.text = self.dataDic[@"title"];
        }else{
            _titleLabel.text = self.model.title;
        }
        _titleLabel.textColor = [UIColor textColorWithType:0];
        _titleLabel.font = FontSize(16);
    }
    if (!_address) {
        _address = [UIImageView new];
        [self.view addSubview:_address];
        _address.whc_LeftSpace(16).whc_TopSpaceToView(10, _titleLabel).whc_Width(12).whc_Height(14);
        if ([self.fromWhich isEqualToString:@"well"]) {
            _address.hidden = YES;
        }else{
           _address.image = [UIImage imageNamed:@"map_icon"];
        }
        
    }
    if (!_add) {
        _add = [UILabel new];
        [self.view addSubview:_add];
        _add.whc_LeftSpaceToView(6, _address).whc_TopSpaceToView(10, _titleLabel);
        _add.textColor = [UIColor textColorWithType:1];
        if ([self.fromWhich isEqualToString:@"well"]) {
            _add.text = self.dataDic[@"detail"];
        }else{
            _add.text = self.model.address;
        }
        
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
        if ([self.fromWhich isEqualToString:@"well"]) {
            _tip.text = [NSString stringWithFormat:@"%@信条",self.dataDic[@"creed_price"]];
        }else{
            _tip.text = [NSString stringWithFormat:@"答题成功将获得%@信条",self.model.creed_award];
        }
        _tip.font = FontSize(13);
    }
    if (!_num) {
        _num = [UILabel new];
        [self.view addSubview:_num];
        _num.whc_RightSpace(15).whc_TopSpaceToView(37, _line);
        _num.textColor = [UIColor textColorWithType:0];
        if ([self.fromWhich isEqualToString:@"well"]) {
            NSRange range = NSMakeRange(2, [self.dataDic[@"num"] length]);
           _num.attributedText = [Tools text:[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"还剩%@个",self.dataDic[@"num"]]] fontSize:13 color:[UIColor colorWithHexString:@"#FD6D08"] rang:range];
        }else{
            NSRange range = NSMakeRange(2, [self.model.creed_remain length]);
        _num.attributedText = [Tools text:[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"还剩%@信条",self.model.creed_remain]] fontSize:13 color:[UIColor colorWithHexString:@"#FD6D08"] rang:range];
        }
    }
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:_btn];
        _btn.whc_BottomSpace(25).whc_LeftSpace(16).whc_RightSpace(16).whc_Height(44);
        _btn.backgroundColor = [UIColor colorWithHexString:@"#FFE656"];
        if ([self.fromWhich isEqualToString:@"well"]) {
            _btn.tag = 10000;
            if ([self.dataDic[@"creed_price"] integerValue] > [[KeyChain objectWithKey:@"score"] integerValue]) {
                _btn.backgroundColor = [UIColor colorWithHexString:@"#f1f3f5"];
            }else{
                _btn.userInteractionEnabled = YES;
            }
            [_btn setTitle:@"马上兑换" forState:UIControlStateNormal];
            [_btn addTarget:self action:@selector(exchangeAction:) forControlEvents:UIControlEventTouchUpInside];
        }else{
            _btn.tag = 10001;
            [_btn setTitle:@"答题赢信条" forState:UIControlStateNormal];
        }
        [_btn setTitleColor:[UIColor textColorWithType:0] forState:UIControlStateNormal];
        _btn.titleLabel.font = FontSize(16);
        [_btn setLayerCornerRadius:22];
        [_btn addTarget:self action:@selector(exchangeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
}

#pragma mark 兑换奖品/答题赢信条
- (void)exchangeAction:(UIButton *)btn{
    if (btn.tag == 10000) {
         if ([self.dataDic[@"creed_price"] integerValue] > [[KeyChain objectWithKey:@"score"] integerValue]) {
             UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"当前信条数不够" preferredStyle:UIAlertControllerStyleAlert];
             UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
             [alertController addAction:cancelAction];
             [self presentViewController:alertController animated:YES completion:nil];
         }else{
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"确定使用%@信条兑换",self.dataDic[@"creed_price"]] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"是的" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                ExchangeViewController *exchange = [[ExchangeViewController alloc] init];
                exchange.good_id = self.good_id;
                [self.navigationController pushViewController:exchange animated:YES];
            }];
            [alertController addAction:cancelAction];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
         }
        
    }else if(btn.tag == 10001){
         if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"isLogin"] isEqualToString:@"YES"]) {
            QuestionViewController *question = [[QuestionViewController alloc] init];
            question.creed_id = self.model.creed_id;
            [self.navigationController pushViewController:question animated:YES];
         }else{
             [SVProgressHUD showErrorWithStatus:@"登录后才可以答题哦"];
         }
    }
}


@end
