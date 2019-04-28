//
//  SelectCityViewController.m
//  yuyan
//
//  Created by tangfeimu on 2019/4/3.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "SelectCityViewController.h"
#import "HomeModel.h"
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>

@interface SelectCityViewController ()

@property (nonatomic,strong)UILabel *open;
@property (nonatomic,strong)UIImageView *backImage;
@property (nonatomic,strong)UILabel *cityName;

@property (nonatomic,strong)UILabel *feature;
@property (nonatomic,strong)UIImageView *featureImage;
@property (nonatomic,strong)UILabel *featureName;

@end

@implementation SelectCityViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
     [self setNavigationTitle:@"选择城市" LeftBtnHidden:NO RightBtnHidden:YES];
    
    [self createSub];
}

- (void)leftBtnAcion:(id)sender;{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)createSub{
    if (!_open) {
        _open = [UILabel new];
        [self.view addSubview:_open];
        _open.whc_LeftSpace(16).whc_TopSpace(10 + NavigationHeight);
        _open.text = @"已上线城市";
        _open.textColor = [UIColor colorWithHexString:@"#9f9f9f"];
        _open.font = FontSize(13);
    }
    NSInteger num;
    if (self.openCity.count / 3 > 0 && self.openCity.count > 3) {
        if (self.openCity.count % 3 == 0) {
            num = self.openCity.count / 3;
        }else{
            num = (self.openCity.count / 3 + 1 );
        }
    }else{
        num = 1 ;
    }
    for (int i = 0; i < num ; i ++) {
        NSInteger p;
        if (self.openCity.count != 3) {
            p = (i == num - 1 ? self.openCity.count % 3 : 3);
        }else{
            p = 3;
        }
        for (int j = 0; j < p ; j ++) {
            CityModel *model = self.openCity[i * 3 + j ];
            _backImage = [UIImageView new];
            [self.view addSubview:_backImage];
            _backImage.frame = CGRectMake(16 + (10 + (ScreenWidth - 32 - 20) / 3) *j, 40 + 170 * i + NavigationHeight, (ScreenWidth - 16 *2 - 20)/3, 160);
            _backImage.userInteractionEnabled = YES;
            _backImage.tag = 10000 + i * 3 + j;
            [_backImage addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openAction:)]];
            [_backImage sd_setImageWithURL:[NSURL URLWithString:model.poster]];
            _cityName = [UILabel new];
            [self.backImage addSubview:_cityName];
            _cityName.whc_CenterX(0).whc_BottomSpace(17);
            _cityName.textColor = [UIColor whiteColor];
            _cityName.font = FontSize(14);
            _cityName.text = model.city_name;
        }
    }
    if (!_feature) {
        _feature = [UILabel new];
        [self.view addSubview:_feature];
        _feature.whc_LeftSpace(16).whc_TopSpaceToView(20, _backImage);
        _feature.text = @"待上线城市";
        _feature.textColor = [UIColor colorWithHexString:@"#9f9f9f"];
        _feature.font = FontSize(13);
    }
    NSInteger count;
    if (self.featureCity.count / 3 > 0) {
        count = (self.featureCity.count / 3 + self.featureCity.count %3 );
    }else{
        count = 1 ;
    }
    for (int i = 0; i < count ; i ++) {
        NSInteger p = (i == count - 1 ? self.featureCity.count % 3 : 3);
        for (int j = 0; j < p ; j ++) {
            CityModel *model = self.featureCity[i * 3 + j ];
            _featureImage = [UIImageView new];
            [self.view addSubview:_featureImage];
            _featureImage.frame = CGRectMake(16 + (10 + (ScreenWidth - 32 - 20) / 3) *j, 160 * num +(num - 1) *10 + 90 + 170 * i + NavigationHeight, (ScreenWidth - 16 *2 - 20)/3, 160);
            _featureImage.userInteractionEnabled = YES;
            _featureImage.tag = 10000 + i * 3 + j;
            [_featureImage addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(featureAction:)]];
            [_featureImage sd_setImageWithURL:[NSURL URLWithString:model.poster]];
            _featureName = [UILabel new];
            [self.featureImage addSubview:_featureName];
            _featureName.whc_CenterX(0).whc_BottomSpace(17);
            _featureName.textColor = [UIColor whiteColor];
            _featureName.font = FontSize(14);
            _featureName.text = model.city_name;
        }
    }
}

- (void)openAction:(UITapGestureRecognizer *)tap{
    CityModel *model = self.openCity[tap.view.tag - 10000];
    [[NSUserDefaults standardUserDefaults]setObject:model.city_name forKey:@"city"];
    if ([_delegate respondsToSelector:@selector(sendValueToHome:)]) {
        NSDictionary *dic = @{@"city_id":model.city_id,@"city_name":model.city_name};
        [_delegate sendValueToHome:dic];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)featureAction:(UITapGestureRecognizer *)tap{
    [SVProgressHUD showErrorWithStatus:@"还没开放哟,敬请期待"];
//    CityModel *model = self.featureCity[tap.view.tag - 10000];
//    self.value(model.city_name);
}


@end
