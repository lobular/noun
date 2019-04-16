//
//  MineViewController.m
//  yuyan
//
//  Created by tangfeimu on 2019/3/27.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "MineViewController.h"
#import "HomeHeaderViewCell.h"
#import "HomeCustomViewCell.h"
#import "YuYanLoginViewController.h"
#import "KeyChain.h"
#import <SVProgressHUD.h>
#import "MyCreed/MyCreedViewController.h"
#import "ConvertViewController.h"
#import "IdeaBack/IdeaBackViewController.h"
#import "Set/SetViewController.h"

@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;

@end

@implementation MineViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadAction:) name:@"isLoad" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadAction:) name:@"score" object:nil]; //剩余信条数
}

#pragma mark
- (void)reloadAction:(NSNotification *)noti{
    if (noti.object) {
        [self.tableView reloadSections:[[NSIndexSet alloc]initWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationTitle:@"我的" LeftBtnHidden:YES RightBtnHidden:YES];
    
    [self createTable];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)createTable{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavigationHeight, ScreenWidth, ScreenHeight - NavigationHeight) style:UITableViewStylePlain];
    }
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 0 ? 1 : 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        HomeCustomViewCell *cell = [HomeCustomViewCell initWithTable:tableView];
        [cell setValueForCell:indexPath.row];
        return cell;
    }
    HomeHeaderViewCell *cell = [HomeHeaderViewCell initWithTable:tableView];
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"isLogin"] isEqualToString:@"YES"]) {
        cell.name.text = [KeyChain objectWithKey:@"mobile"];
        cell.btn.userInteractionEnabled = NO;
        cell.btn.backgroundColor = [UIColor clearColor];
        [cell.btn setTitleColor:[UIColor textColorWithType:1] forState:UIControlStateNormal];
        [cell.btn setTitle:[NSString stringWithFormat:@"当前信条：%@",[KeyChain objectWithKey:@"score"]] forState:UIControlStateNormal];
    }else{
        cell.name.text = @"欢迎来到雨燕";
        cell.btn.userInteractionEnabled = YES;
    }
    [cell.btn addTarget:self action:@selector(handleAction) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.section == 0 ? 114 : 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section == 0 ? 0 : 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"isLogin"] isEqualToString:@"YES"]) {
            if (indexPath.row == 0) {
                MyCreedViewController *creed = [[MyCreedViewController alloc] init];
                creed.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:creed animated:YES];
            }else if (indexPath.row == 1){
                ConvertViewController *creed = [[ConvertViewController alloc] init];
                creed.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:creed animated:YES];
            }else if (indexPath.row == 2){
                SetViewController *set = [[SetViewController alloc] init];
                set.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:set animated:YES];
            }
            else if (indexPath.row == 3){
                IdeaBackViewController *back = [[IdeaBackViewController alloc] init];
                back.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:back animated:YES];
            }
            
        }else{
            [SVProgressHUD showErrorWithStatus:@"请您先登录"];
        }
    }
}

#pragma mark 注册/登录
- (void)handleAction{
    YuYanLoginViewController *login = [[YuYanLoginViewController alloc] init];
    [self.navigationController presentViewController:login animated:YES completion:nil];
}


@end
