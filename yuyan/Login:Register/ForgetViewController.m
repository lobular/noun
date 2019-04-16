//
//  ForgetViewController.m
//  yuyan
//
//  Created by tangfeimu on 2019/4/16.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "ForgetViewController.h"
#import "RegisterView.h"
#import "Tools.h"
#import "SVProgressHUD.h"
#import "RequestFromNet.h"
#import "RequestFromNet.h"

@interface ForgetViewController ()<RegisterDelegate>
{
    NSString *mobile;
}

@property (nonatomic,strong)RegisterView *registerView;

@end

@implementation ForgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavigationTitle:@"忘记密码" LeftBtnHidden:NO RightBtnHidden:YES];
    
    [self createSub];
}

- (void)createSub{
    if (!_registerView) {
        _registerView = [RegisterView new];
        _registerView.delegate = self;
        _registerView.userInteractionEnabled = YES;
        [self.view addSubview:_registerView];
        _registerView.frame = CGRectMake(0, NavigationHeight, ScreenWidth, ScreenHeight);
    }
    _registerView.registe.hidden = YES;
    _registerView.tips.hidden = YES;
    _registerView.url.hidden = YES;
    _registerView.tip.hidden = YES;
    [_registerView.registerBtn setTitle:@"重置密码" forState:UIControlStateNormal];
    [_registerView.code addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(codeAction)]];

}

- (void)sendValue:(NSString *)phone{
    mobile = phone;
}

#pragma mark 获取验证码
- (void)codeAction{
    if ([mobile length] == 0) {
        [SVProgressHUD showErrorWithStatus:@"请先输入手机号"];
        return;
    }
    __weak __typeof(self)weakSelf = self;
    [Tools startWithTime:59 label:weakSelf.registerView.code title:@"重新获取验证码" countDownTitle:@"s" mainColor:[UIColor colorWithHexString:@"#EB4B2B"] countColor:[UIColor colorWithHexString:@"#bbbbbb"]];
    
    [SVProgressHUD show];
    [RequestFromNet getDataForCustom:ForgetCodeAPI params:@{@"mobile":mobile} succ:^(NSDictionary *dataDic) { [SVProgressHUD dismiss];
        if ([dataDic[@"status"] isEqualToString:@"success"]) {
            [SVProgressHUD showSuccessWithStatus:@"验证码获取成功"];
        }else{
            [SVProgressHUD showErrorWithStatus:dataDic[@"message"]];
        }
    } fault:^(NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"网络异常,请稍后重试"];
    }];
}

#pragma 重置密码
- (void)send:(NSDictionary *)dic{
    if ([dic[@"phone"] length] == 0) {
        [self showToast:@"请输入手机号"];
        return;
    }
    if ([dic[@"pwd"] length] == 0) {
        [self showToast:@"请输入密码"];
        return;
    }
    if ([dic[@"code"] length] == 0) {
        [self showToast:@"请输入验证码"];
        return;
    }
    [SVProgressHUD show];
    NSDictionary *dics = @{@"mobile":dic[@"phone"],@"password":dic[@"pwd"],@"vercode":dic[@"code"]};
    [RequestFromNet getDataForCustom:ResetPwdAPI params:dics succ:^(NSDictionary *dataDic) {
        [SVProgressHUD dismiss];
        if ([dataDic[@"status"] isEqualToString:@"success"]) {
            [SVProgressHUD showSuccessWithStatus:@"密码重置成功"];
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            [SVProgressHUD showErrorWithStatus:dataDic[@"message"]];
        }
    } fault:^(NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"网络异常,请稍后重试"];
    }];
}

@end
