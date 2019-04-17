//
//  NewsViewController.m
//  yuyan
//
//  Created by tangfeimu on 2019/4/17.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsTableView.h"
#import "RequestFromNet.h"
#import "HomeModel.h"
#import <SVProgressHUD.h>
#import "ErrorView.h"
#import "Tools.h"
#import "CreedNoneView.h"
#import <AFNetworking.h>
#import "NetWorkSingle.h"
#import "CustomWebViewController.h"

@interface NewsViewController ()

@property (nonatomic,strong)NewsTableView *tableView;
@property (nonatomic,strong)NSArray *dataArr;
@property (nonatomic,strong)CreedNoneView *noneView;
@property (nonatomic,strong)ErrorView *err;

@end

@implementation NewsViewController

- (NSArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSArray array];
    }
    return _dataArr;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifi:) name:AFNetworkingReachabilityDidChangeNotification object:nil];
}

- (void)notifi:(NSNotification *)noti{
    [self getData:@"load"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationTitle:@"消息" LeftBtnHidden:NO RightBtnHidden:YES];
    [self getData:nil];
}

- (void)leftBtnAcion:(id)sender;{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)getData:(NSString *)str{
    if (![str isEqualToString:@"load"]) {
        [SVProgressHUD showWithStatus:@"正在努力加载中..."];
    }else{
        [SVProgressHUD show];
    }
    [RequestFromNet getMessageListFromNet:MessageAPI params:nil succ:^(NSDictionary *dataDic) {
        [SVProgressHUD dismiss];
        if ([dataDic[@"status"] isEqualToString:@"success"]) {
            self.dataArr = dataDic[@"data"];
            if (self.dataArr.count == 0) {
                [self.tableView removeFromSuperview];
                self.tableView = nil;
                [self createNone];
            }else{
                [self.noneView removeFromSuperview];
                self.noneView = nil;
                [self createTableView];
            }
            [self.tableView reloadData];
        }else{
            [SVProgressHUD showErrorWithStatus:dataDic[@"message"]];
        }
    } fault:^(NSError *error) {
        [SVProgressHUD dismiss];
        [self presentViewController:[Tools returnAlert] animated:YES completion:nil];
        if (self.dataArr.count > 0) {
            self.err = nil;
            [self.err removeFromSuperview];
        }else if (!self.noneView){
            [self.tableView removeFromSuperview];
            self.tableView = nil;
            [self createError];
        }
    }];
}
- (void)createNone{
    if (!_noneView) {
        self.noneView = [[CreedNoneView alloc] initWithFrame:CGRectMake(0, NavigationHeight, ScreenWidth, ScreenHeight - NavigationHeight)];
    }
    [self.view addSubview:_noneView];
}

- (void)createError{
    if (!_err) {
        _err = [[ErrorView alloc] init];
        [self.view addSubview:_err];
        _err.frame = CGRectMake(0, NavigationHeight, ScreenWidth,ScreenHeight - self.tabBarController.tabBar.frame.size.height - NavigationHeight);
        [_err addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(loan)]];
    }
}
- (void)loan{
    [NetWorkSingle new];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifi:) name:AFNetworkingReachabilityDidChangeNotification object:nil];
}

- (void)createTableView{
    if (!_tableView) {
        _tableView = [[NewsTableView alloc] initWithFrame:CGRectMake(0, NavigationHeight, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    }
    _tableView.arr = self.dataArr;
    [_tableView reloadData];
    [self.view addSubview:_tableView];
    
    [self push];
}

- (void)push{
    WEAK_SELF(weakSelf)
    _tableView.url = ^(NSString *url) {
        NSLog(@"%@",url);
        CustomWebViewController *web = [[CustomWebViewController alloc] init];
        web.url = url;
        [weakSelf.navigationController pushViewController:web animated:YES];
    };
}

@end
