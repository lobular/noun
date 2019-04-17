//
//  MyCreedViewController.m
//  yuyan
//
//  Created by tangfeimu on 2019/4/9.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "MyCreedViewController.h"
#import "CreedHeaderViewCell.h"
#import "CreedDetailViewCell.h"
#import "RequestFromNet.h"
#import "KeyChain.h"
#import <SVProgressHUD.h>
#import "MineModel.h"
#import "CreedNoneView.h"
#import "YuYanLoginViewController.h"
#import <AFNetworking.h>
#import "ErrorView.h"
#import "Tools.h"
#import "NetWorkSingle.h"

@interface MyCreedViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString *score;
}

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSArray *arr;

@property (nonatomic,strong)CreedNoneView *noneView;
@property (nonatomic,strong)ErrorView *err;

@end

@implementation MyCreedViewController

- (NSArray *)arr{
    if (!_arr) {
        _arr = [NSArray array];
    }
    return _arr;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifi:) name:AFNetworkingReachabilityDidChangeNotification object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationTitle:@"我的信条" LeftBtnHidden:NO RightBtnHidden:YES];
    self.navigationBar.backgroundColor = [UIColor colorWithHexString:@"#FFE656"];
    
    self.navigationBar.bottomview.backgroundColor = [UIColor clearColor];
    
    [self createTableView];
    [self getData:nil];
    
}

- (void)notifi:(NSNotification *)noti{
    [self getData:@"load"];
}

- (void)leftBtnAcion:(id)sender;{
    [self.navigationController popViewControllerAnimated:YES];
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

- (void)getData:(NSString *)status{
    if (![status isEqualToString:@"load"]) {
        [SVProgressHUD showWithStatus:@"正在努力加载中..."];
    }else{
        [SVProgressHUD show];
    }
    [RequestFromNet getListForCreed:ScoreAPI params:@{@"token":[KeyChain objectWithKey:@"token"]} succ:^(NSDictionary *dataDic) {
        [SVProgressHUD dismiss];
        if ([[NSString stringWithFormat:@"%@",dataDic[@"errcode"]] isEqualToString:@"1"]) {
            [SVProgressHUD showErrorWithStatus:@"登录失效,请重新登录"];
            YuYanLoginViewController *login = [[YuYanLoginViewController alloc] init];
            [self presentViewController:login animated:YES completion:nil];

        }
        if ([dataDic[@"status"] isEqualToString:@"success"]) {
            self.arr = dataDic[@"data"];
            if (self.arr.count == 0) {
                [self.tableView removeFromSuperview];
                self.tableView = nil;
                [self createNone];
            }else{
                [self.noneView removeFromSuperview];
                self.noneView = nil;
                [self createTableView];
            }
            self->score = [NSString stringWithFormat:@"%@",dataDic[@"score"]];
            [self.tableView reloadData];
        }else{
            [SVProgressHUD showErrorWithStatus:dataDic[@"message"]];
        }
    } fault:^(NSError *error) {
        [SVProgressHUD dismiss];
        [self presentViewController:[Tools returnAlert] animated:YES completion:nil];
        if (self.arr.count > 0) {
            self.err = nil;
            [self.err removeFromSuperview];
        }else if (!self.noneView){
            [self.tableView removeFromSuperview];
            self.tableView = nil;
            [self createError];
        }
    }];
}

- (void)createTableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavigationHeight, ScreenWidth, ScreenHeight - NavigationHeight) style:UITableViewStylePlain];
        [self.view addSubview:_tableView];
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arr.count + 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        CreedHeaderViewCell *cell = [CreedHeaderViewCell initWithTableView:tableView];
        cell.score.text = score;
        return cell;
    }
    CreedDetailViewCell *cell = [CreedDetailViewCell initWithTableView:tableView];
    if (self.arr.count > 0) {
        MineModel *model = self.arr[indexPath.row - 1];
        [cell setValueForCell:model];
    }
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 137;
    }
    return 67;
}

@end
