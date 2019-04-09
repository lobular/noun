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

@interface MyCreedViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString *score;
}

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSArray *arr;

@end

@implementation MyCreedViewController

- (NSArray *)arr{
    if (!_arr) {
        _arr = [NSArray array];
    }
    return _arr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationTitle:@"我的信条" LeftBtnHidden:NO RightBtnHidden:YES];
    self.navigationBar.backgroundColor = [UIColor colorWithHexString:@"#FFE656"];
    
    [self createTableView];
    [self getData];
    
}

- (void)leftBtnAcion:(id)sender;{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)getData{
    [SVProgressHUD showWithStatus:@"正在努力加载中..."];
    [RequestFromNet getListForCreed:ScoreAPI params:@{@"token":[KeyChain objectWithKey:@"token"]} succ:^(NSDictionary *dataDic) {
        [SVProgressHUD dismiss];
        if ([dataDic[@"status"] isEqualToString:@"success"]) {
            self.arr = dataDic[@"data"];
            self->score = [NSString stringWithFormat:@"%@",dataDic[@"score"]];
            [self createTableView];
            [self.tableView reloadData];
        }else{
            [SVProgressHUD showErrorWithStatus:dataDic[@"message"]];
        }
    } fault:^(NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"网络异常,请稍后重试"];
    }];
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
    MineModel *model = self.arr[indexPath.row - 1];
    [cell setValueForCell:model];
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 137;
    }
    return 67;
}

@end
