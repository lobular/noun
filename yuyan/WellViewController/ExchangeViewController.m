//
//  ExchangeViewController.m
//  yuyan
//
//  Created by tangfeimu on 2019/4/11.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "ExchangeViewController.h"
#import "ExchangeTableView.h"
#import "UIView+CornerRadiusLayer.h"
#import "RequestFromNet.h"
#import "KeyChain.h"
#import <SVProgressHUD.h>
#import "AppDelegate.h"
#import "MainTabBarController.h"
#import "CustomWebViewController.h"

@interface ExchangeViewController ()

@property (nonatomic,strong)ExchangeTableView *tableView;

@property (nonatomic,strong)UIButton *againBtn;
@property (nonatomic,strong)UIButton *useBtn;

@property (nonatomic,strong)NSDictionary *dataDic;

@end

@implementation ExchangeViewController

- (NSDictionary *)dataDic{
    if (!_dataDic) {
        _dataDic = [NSDictionary dictionary];
    }
    return _dataDic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setNavigationTitle:@"兑换结果" LeftBtnHidden:NO RightBtnHidden:YES];
    [self createBottom];
    [self getData];
}

- (void)leftBtnAcion:(id)sender;{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)getData{
    [SVProgressHUD showWithStatus:@"加载中..."];
    [RequestFromNet getDataForCustom:ExchangeAPI params:@{@"token":[KeyChain objectWithKey:@"token"],@"goods_id":self.good_id} succ:^(NSDictionary *dataDic) {
        [SVProgressHUD dismiss];
        if ([dataDic[@"status"] isEqualToString:@"success"]) {
            self.dataDic = dataDic;
            [self createTable];
            [self.tableView reloadData];
        }
    } fault:^(NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"网络异常,请稍后重试"];
    }];
}

- (void)createTable{
    if (!_tableView) {
        _tableView = [[ExchangeTableView alloc] initWithFrame:CGRectMake(0, NavigationHeight, ScreenWidth, ScreenHeight - NavigationHeight - 80) style:UITableViewStylePlain];
    }
    _tableView.dataDic = self.dataDic[@"data"];
    [_tableView reloadData];
    [self.view addSubview:_tableView];
}

- (void)createBottom{
    if (!_againBtn) {
        _againBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:_againBtn];
        _againBtn.whc_BottomSpace(28).whc_LeftSpace(16).whc_Width(166).whc_Height(44);
        [_againBtn setTitle:@"继续兑换" forState:UIControlStateNormal];
        [_againBtn setLayerCornerRadius:22 borderWidth:1 borderColor:[UIColor colorWithHexString:@"#E3A984"]];
        [_againBtn setTitleColor:[UIColor textColorWithType:0] forState:UIControlStateNormal];
        _againBtn.backgroundColor = [UIColor whiteColor];
        _againBtn.titleLabel.font = FontSize(16);
        [_againBtn addTarget:self action:@selector(againAction) forControlEvents:UIControlEventTouchUpInside];
    }
    if (!_useBtn) {
        _useBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:_useBtn];
        _useBtn.whc_BottomSpace(28).whc_RightSpace(16).whc_Width(166).whc_Height(44);
        [_useBtn setTitle:@"去使用" forState:UIControlStateNormal];
        [_useBtn setLayerCornerRadius:22 borderWidth:1 borderColor:[UIColor colorWithHexString:@"#FFE656"]];
        [_useBtn setTitleColor:[UIColor textColorWithType:0] forState:UIControlStateNormal];
        _useBtn.backgroundColor = [UIColor colorWithHexString:@"#FFE656"];
        _useBtn.titleLabel.font = FontSize(16);
        [_useBtn addTarget:self action:@selector(useAction) forControlEvents:UIControlEventTouchUpInside];
    }
}

#pragma mark 继续兑换
- (void)againAction{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    MainTabBarController *tabViewController = (MainTabBarController *) appDelegate.window.rootViewController;
    [tabViewController setSelectedIndex:2];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark 去使用
- (void)useAction{
    CustomWebViewController *web = [[CustomWebViewController alloc] init];
    web.url = self.dataDic[@"data"][@"href"];
    [self.navigationController pushViewController:web animated:YES];
}

@end
