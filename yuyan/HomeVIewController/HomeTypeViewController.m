//
//  HomeTypeViewController.m
//  yuyan
//
//  Created by tangfeimu on 2019/4/4.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "HomeTypeViewController.h"
#import "RequestFromNet.h"
#import "HomeViewCell.h"
#import <SVProgressHUD.h>
#import "HomeModel.h"
#import "HomeDetailViewController.h"

@interface HomeTypeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *table;
@property (nonatomic,strong)NSArray *dataArr;

@end

@implementation HomeTypeViewController

- (NSArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSArray array];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationTitle:[NSString stringWithFormat:@"%@分类",self.name] LeftBtnHidden:NO RightBtnHidden:YES];
    
    [self getData];
    [self createTable];
    
}

- (void)leftBtnAcion:(id)sender;{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)getData{
    [SVProgressHUD show];
    [RequestFromNet getDataForList:ListAPI params:@{@"cate_id":self.ID} succ:^(NSDictionary *dataDic) {
        [SVProgressHUD dismiss];
        if ([dataDic[@"status"] isEqualToString:@"success"]) {
            self.dataArr = dataDic[@"list"];
            [self.table reloadData];
        }else{
            [SVProgressHUD showErrorWithStatus:dataDic[@"message"]];
        }
    } fault:^(NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"网络异常,请稍后重试"];
    }];
}

- (void)createTable{
    if (!_table) {
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NavigationHeight, ScreenWidth, ScreenHeight - NavigationHeight) style:UITableViewStylePlain];
    }
    [self.view addSubview:_table];
    _table.delegate = self;
    _table.dataSource = self;
    _table.separatorStyle = UITableViewCellSelectionStyleNone;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeViewCell *cell = [HomeViewCell cellWithTableView:tableView];
    HomeModel *model = self.dataArr[indexPath.row];
    [cell setValueForCell:model];
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeModel *model = self.dataArr[indexPath.row];
    HomeDetailViewController *detail = [[HomeDetailViewController alloc] init];
    detail.creed_id = model.creed_id;
    detail.name = model.title;
    [self.navigationController pushViewController:detail animated:YES];
}
@end
