//
//  LoginView.m
//  yuyan
//
//  Created by tangfeimu on 2019/4/8.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "LoginView.h"
#import "UIView+CornerRadiusLayer.h"
#import <SVProgressHUD.h>

@interface LoginView ()

{
    NSString *phone;
    NSString *pwd;
}

@end

@implementation LoginView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self config];
    }
    return self;
}
- (void)config{
    if (!_login) {
        _login = [UILabel new];
        [self addSubview:_login];
        _login.whc_TopSpace(0).whc_CenterX(0);
        _login.text = @"登录";
        _login.textColor = [UIColor textColorWithType:0];
        _login.font = FontSize(22);
    }
    for (int i = 0; i < 2; i ++) {
        _context = [UITextField new];
        [self addSubview:_context];
        _context.whc_TopSpace(51 + i * 47).whc_LeftSpace(24).whc_RightSpace(35).whc_Height(45);
        _context.tag = 10000 + i;
        if (i == 0) {
            _context.placeholder = @"请输入手机号";
            _context.keyboardType = UIKeyboardTypeNumberPad;
        }else{
            _context.placeholder = @"请输入密码";
            _context.clearButtonMode = YES;
            _context.secureTextEntry = YES;
        }
         [_context addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        _line = [UILabel new];
        [_context addSubview:_line];
        _line.whc_BottomSpaceToView (45, _context).whc_LeftSpaceToView(16, self).whc_RightSpaceToView(16, self).whc_Height(1);
        _line.backgroundColor = [UIColor colorWithHexString:@"#f1f3f5"];
        if (i == 1) {
            _secImage = [UIImageView new];
            [self addSubview:_secImage];
            _secImage.whc_CenterYToView(0, _context).whc_RightSpace(16).whc_Width(19).whc_Height(8);
//            _secImage.image = [UIImage imageNamed:@""];
            _secImage.image = [UIImage imageNamed:@"close_press_icon"];
            _secImage.userInteractionEnabled = YES;
        }
    }
    if (!_forget) {
        _forget = [UILabel new];
        [self addSubview:_forget];
        _forget.whc_TopSpaceToView(13, _line).whc_RightSpace(16);
        _forget.text = @"忘记密码";
        _forget.userInteractionEnabled = YES;
        _forget.textColor = [UIColor textColorWithType:1];
        _forget.font = FontSize(12);
    }
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_loginBtn];
        _loginBtn.whc_TopSpaceToView(72, _line).whc_LeftSpace(16).whc_RightSpace(16).whc_Height(44);
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor textColorWithType:0] forState:UIControlStateNormal];
        _loginBtn.backgroundColor = [UIColor colorWithHexString:@"#FFE656"];
        _loginBtn.titleLabel.font = FontSize(16);
        [_loginBtn setLayerCornerRadius:22];
        [_loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    }
    if (!_tip) {
        _tip = [UILabel new];
        [self addSubview:_tip];
        _tip.userInteractionEnabled = YES;
        _tip.whc_TopSpaceToView(15, _loginBtn).whc_CenterX(0);
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"没有账号去注册>"]];
        NSRange range = NSMakeRange(5, 3);
        // 改变字体大小及类型
        [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#FD6D08"] range:range];
        // 为label添加Attributed
        [_tip setAttributedText:noteStr];
        _tip.font = FontSize(12);
    }
}

- (void)textFieldDidChange:(UITextField *)textField{
    if (textField.tag == 10000) {
        phone = textField.text;
    }else if (textField.tag == 10001){
        pwd = textField.text;
    }
}

- (void)loginAction{

    if ([phone length] == 0) {
        [SVProgressHUD showErrorWithStatus:@"手机号不能为空"];
        return;
    }
    if ([pwd length] == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        return;
    }
    self.dic(@{@"phone":phone,@"pwd":pwd});
}

@end
