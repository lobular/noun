//
//  YuYanLoginViewController.m
//  yuyan
//
//  Created by tangfeimu on 2019/4/8.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "YuYanLoginViewController.h"
#import "LoginView.h"
#import "RequestFromNet.h"
#import "RegisterView.h"
#import "Tools.h"
#import <SVProgressHUD.h>
#import "RequestFromNet.h"
#import "KeyChain.h"
#import "AppDelegate.h"
#import "MainTabBarController.h"

@interface YuYanLoginViewController ()<RegisterDelegate>
{
    BOOL isRegister;
    NSString *mobile;
    NSString *pwd;
    NSString *code;
}

@property (nonatomic,strong)UIButton *returnBtn;
@property (nonatomic,strong)LoginView *loginView;
@property (nonatomic,strong)RegisterView *registerView;

@end

@implementation YuYanLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createSub];
    
    isRegister = NO;
    
    if (!isRegister) {
        [self login];
    }
}

- (void)createSub{
    if (!_returnBtn) {
        _returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:_returnBtn];
        _returnBtn.whc_TopSpace(36).whc_LeftSpace(16).whc_Width(8).whc_Height(14);
        [_returnBtn setImage:[UIImage imageNamed:@"back_black_icon"] forState:UIControlStateNormal];
        [_returnBtn addTarget:self action:@selector(returnAction) forControlEvents:UIControlEventTouchUpInside];
    }
}

#pragma mark 登录
- (void)login{
    if (!_loginView) {
        _loginView = [[LoginView alloc] initWithFrame:CGRectMake(0, NavigationHeight, ScreenWidth, ScreenHeight)];
        [self.view addSubview:_loginView];
        _loginView.secImage.tag = 10000;
        [_loginView.secImage addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(statusAction:)]];
        [_loginView.tip addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(registerAction)]];
        [self setValue];
    }
}

- (void)returnAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)statusAction:(UITapGestureRecognizer *)tap{
    if (tap.view.tag == 10000) {
        _loginView.secImage.backgroundColor = [UIColor greenColor];
        _loginView.context.secureTextEntry = NO;
        tap.view.tag = 10001;
    }else{
        _loginView.secImage.backgroundColor = [UIColor redColor];
        tap.view.tag = 10000;
        _loginView.context.secureTextEntry = YES;
    }
}

#pragma mark 登录
- (void)setValue{
    __weak __typeof (&*self)weakSelf = self;
    self.loginView.dic = ^(NSDictionary *dataDic) {
        [SVProgressHUD showWithStatus:@"正在登录中..."];
        [RequestFromNet getDataForCustom:LoginAPI params:@{@"username":dataDic[@"phone"],@"password":dataDic[@"pwd"]} succ:^(NSDictionary *dataDic) {
            NSLog(@"%@",dataDic);
            [SVProgressHUD dismiss];
            if ([dataDic[@"status"]isEqualToString:@"success"]) {
                [KeyChain saveObject:dataDic[@"data"][@"user"][@"token"] Forkey:@"token" ToKeyChainStore:NO];
                [KeyChain saveObject:dataDic[@"data"][@"user"][@"mobile"] Forkey:@"mobile" ToKeyChainStore:NO];
                [KeyChain saveObject:dataDic[@"data"][@"user"][@"score"] Forkey:@"score" ToKeyChainStore:NO];
                [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"isLogin"];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"isLoad" object:@"YES"];
                AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                
                MainTabBarController *tabViewController = (MainTabBarController *) appDelegate.window.rootViewController;
                
                [tabViewController setSelectedIndex:0];
                [weakSelf dismissViewControllerAnimated:YES completion:nil];
            }else{
                [SVProgressHUD showErrorWithStatus:dataDic[@"message"]];
            }
        } fault:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:@"网络异常,请稍后重试"];
        }];
        
    };
}

#pragma mark 注册
- (void)registerAction{
    [_loginView removeFromSuperview];
    _loginView = nil;
    [self registe];
}
#pragma mark 登录
- (void)loginAction{
    [_registerView removeFromSuperview];
    _registerView = nil;
    [self login];
}

- (void)registe{
    if (!_registerView) {
        _registerView = [[RegisterView alloc] initWithFrame:CGRectMake(0, NavigationHeight, ScreenWidth, ScreenHeight)];
        [self.view addSubview:_registerView];
        _registerView.delegate = self;
         [_registerView.tip addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(loginAction)]];
    }
    [_registerView.code addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(codeAction)]];
}

- (void)sendValue:(NSString *)phone{
    mobile = phone;
}

- (void)send:(NSDictionary *)dic{
    mobile = dic[@"phone"];
    pwd = dic[@"pwd"];
    code = dic[@"code"];
    
    [RequestFromNet getDataForCustom:RegisterAPI params:@{@"mobile":mobile,@"vercode":code,@"password":pwd} succ:^(NSDictionary *dataDic) {
        if ([dataDic[@"status"]isEqualToString:@"success"]) {
            [SVProgressHUD showSuccessWithStatus:@"注册成功,请去登录"];
            [self loginAction];
        }else{
             [SVProgressHUD showErrorWithStatus:dataDic[@"message"]];
        }
    } fault:^(NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"网络异常,请稍后重试"];
    }];
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
    [RequestFromNet getDataForCustom:CodeAPI params:@{@"mobile":mobile} succ:^(NSDictionary *dataDic) { [SVProgressHUD dismiss];
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

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


@end
