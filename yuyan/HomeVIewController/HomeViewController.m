//
//  HomeViewController.m
//  yuyan
//
//  Created by tangfeimu on 2019/3/27.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeHeaderView.h"
#import "YSBannerView.h"
#import <UIImageView+WebCache.h>
#import "HomeViewCell.h"
#import "RequestFromNet.h"
#import <SVProgressHUD.h>
#import "SelectCityViewController.h"
#import "HomeTypeViewController.h"
#import "SearchViewController.h"
#import "HomeDetailViewController.h"
#import "NewsViewController.h"
#import "AdvertiseView.h"
#import "HomeTypeViewCell.h"
#import "HomeBannerViewCell.h"

@interface HomeViewController ()<YSBannerViewDelegate,UITableViewDelegate,UITableViewDataSource,SelectCityDelegate>

@property (nonatomic,strong)HomeHeaderView *headerView;
@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)AdvertiseView *adver;
@property (nonatomic,strong)UIView *coverView;
@property (nonatomic,strong)UIWindow *window;

@property (nonatomic,strong)NSArray *bannerArr;

@property (nonatomic,strong)NSDictionary *dataDic;

@end

@implementation HomeViewController

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
}

- (NSDictionary *)dataDic{
    if (!_dataDic) {
        self.dataDic = [NSDictionary dictionary];
    }
    return _dataDic;
}
- (NSArray *)bannerArr{
    if (!_bannerArr) {
        _bannerArr = [NSArray array];
    }
    return _bannerArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.is_valid) {
        UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"screen"]];
        image.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        image.contentMode = UIViewContentModeScaleAspectFill;
        [self.view addSubview:image];
    }else{
        [self createHeader];
//        [self createBanner];
        [self createTable];
        [self prepareData:nil];
    }

 
}
- (void)prepareData:(NSDictionary *)dic{
    [SVProgressHUD show];
    [RequestFromNet getDataFromNetForHome:HomeAPI param:dic succ:^(NSDictionary *dataDic) {
        [SVProgressHUD dismiss];
        if ([dataDic[@"status"] isEqualToString:@"success"]) {
//            self.bannerView.downloadImageBlock =
//            ^(UIImageView *imageView, NSURL *url, UIImage *placeholderImage) {
//                [imageView sd_setImageWithURL:url placeholderImage:placeholderImage];
//            };
            NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
            self.dataDic = dataDic;
            for (BannerModel *model in self.dataDic[@"banner"]) {
                [arr addObject:model.pic];
            }
            self.bannerArr = arr;
//            self.bannerView.imageArray = arr;
//            [self createType];
            [self.tableView reloadData];
        }else{
            [SVProgressHUD showErrorWithStatus:dataDic[@"message"]];
        }
    } fault:^(NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"网络异常,请稍后重试"];
    }];
}

#pragma mark 弹窗请求
- (void)getContentFromNet{
    [RequestFromNet getDataForCustom:VersionAPI params:nil succ:^(NSDictionary *dataDic) {
        if ([dataDic[@"status"] isEqualToString:@"success"]) {
            if ([dataDic[@"data"][@"home_popup"][@"is_open"] isEqualToString:@"1"]) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self createAdvertise];
                    self->_adver.title.text = dataDic[@"data"][@"home_popup"][@"title"];
                    self->_adver.contentLabel.text = dataDic[@"data"][@"home_popup"][@"content"];
                    self->_adver.backView.whc_Height(self->_adver.title.frame.size.height + self->_adver.contentLabel.frame.size.height + 300);
                });
            }
        }
    } fault:^(NSError *error) {
        
    }];
}
- (void)createAdvertise{
    if (!_adver) {
        
        _window  = [UIApplication sharedApplication].keyWindow;//注：keyWindow当前显示界面的window
        if (!_adver) {
            _coverView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        }
        _coverView.backgroundColor = [UIColor blackColor];
        _coverView.alpha = 0.7;
        _coverView.userInteractionEnabled = YES;
        [_window addSubview:_coverView];
        _adver = [[AdvertiseView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        [_adver.closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
        _adver.userInteractionEnabled = YES;
        [_window addSubview:_adver];
        
    }
}
- (void)closeAction{
    [_coverView removeFromSuperview];
    [_adver removeFromSuperview];
    _coverView = nil;
    _adver = nil;
}
#pragma mark type点击事件
- (void)clickAction:(NSInteger)num{
    __weak typeof(self)weakSelf = self;
    TypeModel *model = weakSelf.dataDic[@"type"][num];
    HomeTypeViewController *type = [[HomeTypeViewController alloc] init];
    type.ID = model.cate_id;
    type.name = model.title;
    type.hidesBottomBarWhenPushed = YES;
    [weakSelf.navigationController pushViewController:type animated:YES];
}
#pragma mark tableView
- (void)createTable{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavigationHeight, ScreenWidth, ScreenHeight - TabBarHeight - NavigationHeight ) style:UITableViewStylePlain];
    }
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
}
#pragma mark tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        HomeBannerViewCell *cell = [HomeBannerViewCell initWithTable:tableView];
        [cell setValueForCell:self.bannerArr];
        cell.bannerView.delegate = self;
        return cell;
    }
    if (indexPath.row == 1) {
        HomeTypeViewCell *cell = [HomeTypeViewCell initWithTable:tableView];
        NSArray *arr = self.dataDic[@"type"];
        [cell config:arr];
        cell.succ = ^(NSInteger num) {
            [self clickAction:num - 10000];
        };
        return cell;
    }
    HomeViewCell *cell = [HomeViewCell cellWithTableView:tableView];
    HomeModel *model = self.dataDic[@"creeds"][indexPath.row - 2];
    [cell setValueForCell:model];
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataDic[@"creeds"] count] + 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1) {
        return 107;
    }
    if (indexPath.row == 0) {
        return 140;
    }
    return 90;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeModel *model = self.dataDic[@"creeds"][indexPath.row];
    HomeDetailViewController *detail = [[HomeDetailViewController alloc] init];
    detail.creed_id = model.creed_id;
    detail.name = model.title;
    detail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detail animated:YES];
}
#pragma mark 轮播图delegate
- (void)bannerView:(YSBannerView *)bannerView didSelectItemAtIndex:(NSInteger)index{
    BannerModel *model = self.dataDic[@"banner"][index];
    HomeDetailViewController *detail = [[HomeDetailViewController alloc] init];
    detail.creed_id = model.creed_id;
    detail.name = model.title;
    detail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detail animated:YES];
}
#pragma mark 导航栏
- (void)createHeader{
    if (!_headerView) {
        _headerView = [[HomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, NavigationHeight)];
    }
     [self.view addSubview:_headerView];
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"city"] length] > 0) {
        _headerView.city.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"city"];
    }else{
        _headerView.city.text = @"all";
    }
    [_headerView.city addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cityAction)]];
    [_headerView.tipImage addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cityAction)]];
    [_headerView.searchImage addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(searchAction)]];
    [_headerView.newsImage addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(newAction)]];
}
#pragma mark 选择城市
- (void)cityAction{
    SelectCityViewController *city = [[SelectCityViewController alloc] init];
    city.openCity = self.dataDic[@"openCity"];
    city.featureCity = self.dataDic[@"featureCity"];
    city.delegate = self;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:city];
    [self presentViewController:nav animated:YES completion:nil];
}
#pragma mark 选择城市代理
- (void)sendValueToHome:(NSDictionary *)dic{
    NSLog(@"======%@",dic);
    _headerView.city.text = dic[@"city_name"];
    [self prepareData:@{@"city_id":dic[@"city_id"]}];
}

#pragma mark 搜索
- (void)searchAction{
    SearchViewController *search = [[SearchViewController alloc] init];
    search.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:search animated:YES];
}
#pragma mark 消息
- (void)newAction{
    NewsViewController *new = [[NewsViewController alloc] init];
    new.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:new animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

@end
