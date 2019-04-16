//
//  WellViewController.m
//  yuyan
//
//  Created by tangfeimu on 2019/3/27.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "WellViewController.h"
#import "WellHeaderView.h"
#import "WellCollectionView.h"
#import "RequestFromNet.h"
#import "KeyChain.h"
#import "YuYanLoginViewController.h"
#import <SVProgressHUD.h>
#import "CreedNoneView.h"
#import "MyCreedViewController.h"
#import "ConvertViewController.h"
#import "HomeDetailViewController.h"
#import "ErrorView.h"
#import <AFNetworking.h>
#import "NetWorkSingle.h"
#import "Tools.h"

@interface WellViewController ()<WellDelegate>

@property (nonatomic,strong)WellHeaderView *headerView;
@property (nonatomic,strong)WellCollectionView *collectionView;
@property (nonatomic,strong)NSArray *arr;
@property (nonatomic,strong)CreedNoneView *none;
@property (nonatomic,strong)ErrorView *err;

@end

@implementation WellViewController

- (NSArray *)arr{
    if (!_arr) {
        _arr = [NSArray array];
    }
    return _arr;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadAction:) name:@"isLoad" object:nil];
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadAction:) name:@"score" object:nil]; //剩余信条数
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifi:) name:AFNetworkingReachabilityDidChangeNotification object:nil];
}

#pragma mark
- (void)reloadAction:(NSNotification *)noti{
    if (noti.object) {
        [self getData:nil];
    }
}
//网络状态监听
- (void)notifi:(NSNotification *)noti{
    [self getData:@"load"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setNavigationTitle:@"福利" LeftBtnHidden:YES RightBtnHidden:NO];
    
    [self getData:nil];
}

- (void)rightBtnAcion:(id)sender;{
    NSLog(@"----");
}

- (void)createHeader{
    if (!_headerView) {
        _headerView = [[WellHeaderView alloc] initWithFrame:CGRectMake(0, NavigationHeight, ScreenWidth, 40)];
    }
    _headerView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_headerView];
    [self getWhich];
}
- (void)getWhich{
    WEAK_SELF(weakSelf);
    _headerView.which = ^(NSString *which) {
        if ([which isEqualToString:@"1"]) {
            ConvertViewController *conver = [[ConvertViewController alloc] init];
            conver.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:conver animated:YES];
        }else if ([which isEqualToString:@"0"]) {
            MyCreedViewController *conver = [[MyCreedViewController alloc] init];
            conver.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:conver animated:YES];
        }
    };
}

- (void)getData:(NSString *)status{
    if ([[KeyChain objectWithKey:@"token"] length] == 0) {
        [self.collectionView removeFromSuperview];
        self.collectionView = nil;
        [self createNone];
    }else{
        if (![status isEqualToString:@"load"]) {
            [SVProgressHUD showWithStatus:@"正在努力加载中..."];
        }else{
            [SVProgressHUD show];
        }
        [RequestFromNet getWellFromNet:WellAPI params:@{@"token":[KeyChain objectWithKey:@"token"]} succ:^(NSDictionary *dataDic) {
            [SVProgressHUD dismiss];
            if ([[NSString stringWithFormat:@"%@",dataDic[@"errcode"]] isEqualToString:@"1"]) {
                [SVProgressHUD showErrorWithStatus:@"登录失效,请重新登录"];
                YuYanLoginViewController *login = [[YuYanLoginViewController alloc] init];
                [self presentViewController:login animated:YES completion:nil];
            }
            if ([dataDic[@"status"] isEqualToString:@"success"]) {
                [KeyChain saveObject:dataDic[@"score"] Forkey:@"score" ToKeyChainStore:NO];
                self.arr = dataDic[@"data"];
                if (self.arr.count == 0) {
                    [self.collectionView removeFromSuperview];
                    self.collectionView = nil;
                    [self createNone];
                }else{
                    [self.none removeFromSuperview];
                    self.none = nil;
                    [self.headerView removeFromSuperview];
                    self.headerView = nil;
                    [self createHeader];
                    [self createCollection];
                }
                [self.collectionView reloadData];
            }
        } fault:^(NSError *error) {
            [SVProgressHUD dismiss];
            [self presentViewController:[Tools returnAlert] animated:YES completion:nil];
            if (self.arr.count > 0) {
                self.err = nil;
                [self.err removeFromSuperview];
            }else if (!self.none){
                [self.collectionView removeFromSuperview];
                self.collectionView = nil;
                [self createError];
            }
        }];
    }
}
- (void)createNone{
    if (!_none) {
        self.none = [[CreedNoneView alloc] initWithFrame:CGRectMake(0, NavigationHeight + 40, ScreenWidth, ScreenHeight - NavigationHeight - 40)];
    }
    [self.view addSubview:_none];
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

- (void)createCollection{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 9;
    flowLayout.minimumInteritemSpacing = 9;
    flowLayout.itemSize = CGSizeMake(167 *ScaleWidth, 167 *ScaleWidth);
    
    WellCollectionView *rightView = [[WellCollectionView alloc] initWithFrame:CGRectMake(16 *ScaleWidth, NavigationHeight + 40 + 16, ScreenWidth - 32 , ScreenHeight - NavigationHeight - 40) collectionViewLayout:flowLayout];
    self.collectionView = rightView;
    rightView.pagingEnabled = YES;
    self.collectionView.arr = self.arr;
    [self.view addSubview:rightView];
    self.collectionView.wellDelegate = self;
    
    
    
}
- (void)send:(NSString *)ID{
    HomeDetailViewController *home = [[HomeDetailViewController alloc] init];
    home.good_id = ID;
    home.fromWhich = @"well";
    home.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:home animated:YES];
};

@end
