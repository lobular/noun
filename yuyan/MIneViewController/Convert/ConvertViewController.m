//
//  ConvertViewController.m
//  yuyan
//
//  Created by tangfeimu on 2019/4/9.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "ConvertViewController.h"
#import "ConverViewCell.h"
#import "RequestFromNet.h"
#import "KeyChain.h"
#import <SVProgressHUD.h>
#import "MineModel.h"
#import "ConverDetailViewController.h"
#import <UIImageView+WebCache.h>
#import "CreedNoneView.h"
#import "YuYanLoginViewController.h"

@interface ConvertViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSArray *arr;

@property (nonatomic,strong)CreedNoneView *noneView;

@end

@implementation ConvertViewController

- (NSArray *)arr{
    if (!_arr) {
        _arr = [NSArray array];
    }
    return _arr;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavigationTitle:@"兑换记录" LeftBtnHidden:NO RightBtnHidden:YES];
    [self getData];
    
}

- (void)leftBtnAcion:(id)sender;{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)getData{
    [SVProgressHUD showWithStatus:@"正在努力加载中..."];
    [RequestFromNet getRecordForGoods:RecordAPI params:@{@"token":[KeyChain objectWithKey:@"token"]} succ:^(NSDictionary *dataDic) {
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
            [self.tableView reloadData];
        }else{
            [SVProgressHUD showErrorWithStatus:dataDic[@"message"]];
        }
    } fault:^(NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"网络异常,请稍后重试"];
    }];
}
- (void)createNone{
    if (!_noneView) {
        self.noneView = [[CreedNoneView alloc] initWithFrame:CGRectMake(0, NavigationHeight, ScreenWidth, ScreenHeight - NavigationHeight)];
    }
    [self.view addSubview:_noneView];
}

- (void)createTableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavigationHeight, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    }
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arr.count ;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ConverViewCell *cell = [ConverViewCell initWithTableView:tableView];
    RecordModel *model = self.arr[indexPath.row];
    [cell setValueForCell:model];
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ConverDetailViewController *detail = [[ConverDetailViewController alloc] init];
    RecordModel *model = self.arr[indexPath.row];
    detail.rec_id = model.rec_id;
    [self.navigationController pushViewController:detail animated:YES];
}

@end
