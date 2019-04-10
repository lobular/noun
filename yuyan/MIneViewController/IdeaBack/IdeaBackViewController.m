//
//  IdeaBackViewController.m
//  yuyan
//
//  Created by tangfeimu on 2019/4/10.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "IdeaBackViewController.h"
#import "IdeaBackView.h"
#import <SVProgressHUD.h>
#import "KeyChain.h"
#import "RequestFromNet.h"
#import "YuYanLoginViewController.h"

@interface IdeaBackViewController ()<IdeaViewDelegate>

@property (nonatomic,strong)IdeaBackView *backView;

@end

@implementation IdeaBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationTitle:@"意见反馈" LeftBtnHidden:NO RightBtnHidden:YES];
    
    [self createFeed];
}

- (void)leftBtnAcion:(id)sender;{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)createFeed{
    if (!_backView) {
        _backView = [IdeaBackView new];
        [self.view addSubview:_backView];
        _backView.whc_TopSpace(15 + NavigationHeight).whc_LeftSpace(0).whc_RightSpace(0).whc_Height(ScreenHeight);
    }
    _backView.backgroundColor = [UIColor whiteColor];
    _backView.delegate = self;
}

- (void)sendValueForText:(NSString *)text{
    if ([text length] == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入您宝贵的意见"];
        return;
    }
    [SVProgressHUD showWithStatus:@"正在提交..."];
    NSDictionary *dic = @{@"content":text,@"token":[KeyChain objectWithKey:@"token"]};
    [RequestFromNet getDataForCustom:FeedBackAPI params:dic succ:^(NSDictionary *dataDic) {
        [SVProgressHUD dismiss];
        if ([[NSString stringWithFormat:@"%@",dataDic[@"errcode"]] isEqualToString:@"1"]) {
            [SVProgressHUD showErrorWithStatus:@"登录失效,请重新登录"];
            YuYanLoginViewController *login = [[YuYanLoginViewController alloc] init];
            [self presentViewController:login animated:YES completion:nil];
        }
        if ([dataDic[@"status"] isEqualToString:@"success"]) {
            [SVProgressHUD showSuccessWithStatus:@"意见反馈成功"];
        }else{
            [SVProgressHUD showErrorWithStatus:dataDic[@"message"]];
        }
    } fault:^(NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"网络异常,请稍后重试"];
    }];
}

@end
