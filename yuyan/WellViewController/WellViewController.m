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

@interface WellViewController ()<WellDelegate>

@property (nonatomic,strong)WellHeaderView *headerView;
@property (nonatomic,strong)WellCollectionView *collectionView;
@property (nonatomic,strong)NSArray *arr;
@property (nonatomic,strong)CreedNoneView *none;

@end

@implementation WellViewController

- (NSArray *)arr{
    if (!_arr) {
        _arr = [NSArray array];
    }
    return _arr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setNavigationTitle:@"福利" LeftBtnHidden:YES RightBtnHidden:NO];
    
    [self createHeader];
    [self getData];
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
            [weakSelf.navigationController pushViewController:conver animated:YES];
        }else if ([which isEqualToString:@"0"]) {
            MyCreedViewController *conver = [[MyCreedViewController alloc] init];
            [weakSelf.navigationController pushViewController:conver animated:YES];
        }
    };
}

- (void)getData{
    [SVProgressHUD showWithStatus:@"加载中..."];
    [RequestFromNet getWellFromNet:WellAPI params:@{@"token":[KeyChain objectWithKey:@"token"]} succ:^(NSDictionary *dataDic) {
        [SVProgressHUD dismiss];
        if ([[NSString stringWithFormat:@"%@",dataDic[@"errcode"]] isEqualToString:@"1"]) {
            [SVProgressHUD showErrorWithStatus:@"登录失效,请重新登录"];
            YuYanLoginViewController *login = [[YuYanLoginViewController alloc] init];
            [self presentViewController:login animated:YES completion:nil];
        }
        if ([dataDic[@"status"] isEqualToString:@"success"]) {
            self.arr = dataDic[@"data"];
            if (self.arr.count == 0) {
                [self.collectionView removeFromSuperview];
                self.collectionView = nil;
                [self createNone];
            }else{
                [self.none removeFromSuperview];
                self.none = nil;
                [self createCollection];
            }
            [self.collectionView reloadData];
        }
    } fault:^(NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"网络异常,请稍后重试"];
    }];
}
- (void)createNone{
    if (!_none) {
        self.none = [[CreedNoneView alloc] initWithFrame:CGRectMake(0, NavigationHeight + 40, ScreenWidth, ScreenHeight - NavigationHeight - 40)];
    }
    [self.view addSubview:_none];
}

- (void)createCollection{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.itemSize = CGSizeMake(167 *ScaleWidth, 167 *ScaleWidth);
    
    WellCollectionView *rightView = [[WellCollectionView alloc] initWithFrame:CGRectMake(16, NavigationHeight + 40 + 16, ScreenWidth - 32 , ScreenHeight - NavigationHeight - 40) collectionViewLayout:flowLayout];
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
