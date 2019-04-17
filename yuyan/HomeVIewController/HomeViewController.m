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
#import "HomeTypeVIew.h"
#import "HomeViewCell.h"
#import "RequestFromNet.h"
#import <SVProgressHUD.h>
#import "SelectCityViewController.h"
#import "HomeTypeViewController.h"
#import "SearchViewController.h"
#import "HomeDetailViewController.h"
#import "NewsViewController.h"

@interface HomeViewController ()<YSBannerViewDelegate,UITableViewDelegate,UITableViewDataSource,SelectCityDelegate>

@property (nonatomic,strong)HomeHeaderView *headerView;
@property (nonatomic,strong)HomeTypeVIew *typeView;
@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)YSBannerView *bannerView;

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

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.is_valid) {
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"screen"]];
    }else{
        [self createHeader];
        [self createBanner];
        [self createTable];
        [self prepareData:nil];
    }

 
}
- (void)prepareData:(NSDictionary *)dic{
    [SVProgressHUD show];
    [RequestFromNet getDataFromNetForHome:HomeAPI param:dic succ:^(NSDictionary *dataDic) {
        [SVProgressHUD dismiss];
        if ([dataDic[@"status"] isEqualToString:@"success"]) {
            self.bannerView.downloadImageBlock =
            ^(UIImageView *imageView, NSURL *url, UIImage *placeholderImage) {
                [imageView sd_setImageWithURL:url placeholderImage:placeholderImage];
            };
            NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
            self.dataDic = dataDic;
            for (BannerModel *model in self.dataDic[@"banner"]) {
                [arr addObject:model.pic];
            }
            self.bannerView.imageArray = arr;
            [self createType];
            [self.tableView reloadData];
        }else{
            [SVProgressHUD showErrorWithStatus:dataDic[@"message"]];
        }
    } fault:^(NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"网络异常,请稍后重试"];
    }];

}
#pragma mark --lazy
- (void)createBanner{
    if (!_bannerView) {
        _bannerView = [YSBannerView bannerViewWithFrame:CGRectMake(20, NavigationHeight, ScreenWidth - 40, 140)];
        [_bannerView disableScrollGesture];
        _bannerView.autoScrollTimeInterval = 2;
        _bannerView.pageControlStyle = YSPageControlHollow;
//        _bannerView.currentPageDotImage = [UIImage imageNamed:@"pageControlS"];
//        _bannerView.pageDotImage = [UIImage imageNamed:@"pageControlN"];
        _bannerView.pageControlBottomMargin = -10.0f;
        _bannerView.delegate = self;
        [self.view addSubview:_bannerView];
    }
}
#pragma mark 分类
- (void)createType{
    if (!_typeView) {
        _typeView = [[HomeTypeVIew alloc] initWithFrame:CGRectMake(0, NavigationHeight + 160, ScreenWidth, 107)];
    }
    for (UIView *back in _typeView.subviews) {
        TypeModel *model = self.dataDic[@"type"][back.tag - 10000];
        if ([back isKindOfClass:[UIView class]]) {
            for (id temp in back.subviews) {
                if ([temp isKindOfClass:[UIImageView class]]) {
                    UIImageView *image = temp;
//                    image.backgroundColor = [UIColor blueColor];
                    [image sd_setImageWithURL:[NSURL URLWithString:model.pic]];
                }
                if ([temp isKindOfClass:[UILabel class]]) {
                    UILabel *label = temp;
                    label.text = model.title;
                }
            }
        }
    }
    _typeView.userInteractionEnabled = YES;
    [self clickAction];
    [self.view addSubview:_typeView];
}
#pragma mark type点击事件
- (void)clickAction{
    __weak typeof(self)weakSelf = self;
    _typeView.succ = ^(NSInteger num) {
        TypeModel *model = weakSelf.dataDic[@"type"][num - 10000];
        HomeTypeViewController *type = [[HomeTypeViewController alloc] init];
        type.ID = model.cate_id;
        type.name = model.title;
        type.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:type animated:YES];
    };
}
#pragma mark tableView
- (void)createTable{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavigationHeight + 277, ScreenWidth, ScreenHeight - 287 - TabBarHeight - NavigationHeight ) style:UITableViewStylePlain];
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
    HomeViewCell *cell = [HomeViewCell cellWithTableView:tableView];
    HomeModel *model = self.dataDic[@"creeds"][indexPath.row];
    [cell setValueForCell:model];
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataDic[@"creeds"] count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
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
