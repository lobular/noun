//
//  ConverDetailViewController.m
//  yuyan
//
//  Created by tangfeimu on 2019/4/9.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "ConverDetailViewController.h"
#import "NetWorkSingle.h"
#import "KeyChain.h"
#import "ConverDetailTable.h"
#import <SVProgressHUD.h>
#import "CustomWebViewController.h"

@interface ConverDetailViewController ()

@property (nonatomic,strong)NSDictionary *dic;
@property (nonatomic,strong)ConverDetailTable *detailTable;
@property (nonatomic,strong)ConverBtn *conver;

@property (nonatomic,strong)UIButton *userBtn;

@end

@implementation ConverDetailViewController

- (NSDictionary *)dic{
    if (!_dic) {
        self.dic = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    return _dic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationTitle:@"兑换详情" LeftBtnHidden:NO RightBtnHidden:YES];
    [self getData];
}

- (void)leftBtnAcion:(id)sender;{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)getData{
    [SVProgressHUD showWithStatus:@"正在努力加载中..."];
    [NetWorkSingle getWithURLString:RecordDetailAPI parameters:@{@"token":[KeyChain objectWithKey:@"token"],@"rec_id":self.rec_id} success:^(NSDictionary *dataDic) {
        [SVProgressHUD dismiss];
        if ([dataDic[@"status"] isEqualToString:@"success"]) {
            self.dic = dataDic[@"data"][@"record"];
            [self createTable];
            [self.detailTable reloadData];
        }else{
            [SVProgressHUD showErrorWithStatus:dataDic[@"message"]];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"网络异常,请稍后重试"];
    }];
}

- (void)createTable{
    if (!_detailTable) {
        _detailTable = [[ConverDetailTable alloc] initWithFrame:CGRectMake(0, NavigationHeight, ScreenWidth, ScreenHeight - NavigationHeight) style:UITableViewStylePlain];
    }
    _detailTable.dic = self.dic;
    [_detailTable reloadData];
    [self.view addSubview:_detailTable];
    WEAK_SELF(weakSelf);
    _detailTable.block = ^(NSString *str) {
        if ([str isEqualToString:@"0000"]) {
            CustomWebViewController *web = [[CustomWebViewController alloc] init];
            web.url = weakSelf.dic[@"h5_href"];
            [weakSelf.navigationController pushViewController:web animated:YES];
        }
    };
}





@end
