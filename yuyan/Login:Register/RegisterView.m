//
//  RegisterView.m
//  yuyan
//
//  Created by tangfeimu on 2019/4/9.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "RegisterView.h"
#import "UIView+CornerRadiusLayer.h"
#import <SVProgressHUD.h>

@interface RegisterView ()

{
    NSString *phone;
    NSString *pwd;
    NSString *codeNum;
}

@end

@implementation RegisterView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self config];
    }
    return self;
}
- (void)config{
    if (!_registe) {
        _registe = [UILabel new];
        [self addSubview:_registe];
        _registe.whc_TopSpace(0).whc_CenterX(0);
        _registe.text = @"手机号注册";
        _registe.textColor = [UIColor textColorWithType:0];
        _registe.font = FontSize(22);
    }
    for (int i = 0; i < 3; i ++) {
        _context = [UITextField new];
        [self addSubview:_context];
        _context.whc_TopSpace(51 + i * 47).whc_LeftSpace(24).whc_RightSpace(35).whc_Height(45);
        _context.tag = 10000 + i;
        if (i == 0) {
            _num = [UILabel new];
            [self addSubview:_num];
            _num.whc_TopSpace(51).whc_LeftSpace(24).whc_Height(45);
            _num.text = @"+86";
            _num.textColor = [UIColor textColorWithType:0];
            _num.font = FontSize(15);
            _context.whc_LeftSpaceToView(5, _num);
            _context.placeholder = @"请输入手机号";
            _context.keyboardType = UIKeyboardTypeNumberPad;
        }else if (i == 1){
            _context.placeholder = @"请输入短信验证码";
        }else if ( i == 2){
            _context.placeholder = @"请设置密码";
            _context.clearButtonMode = YES;
        }
        [_context addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        _line = [UILabel new];
        [_context addSubview:_line];
        _line.whc_BottomSpaceToView (45, _context).whc_LeftSpaceToView(16, self).whc_RightSpaceToView(16, self).whc_Height(1);
        _line.backgroundColor = [UIColor colorWithHexString:@"#f1f3f5"];
        if (i == 1) {
            _code = [UILabel new];
            [self addSubview:_code];
            _code.whc_CenterYToView(0, _context).whc_RightSpace(16).whc_Width(85).whc_Height(25);
            _code.text = @"获取验证码";
            _code.textAlignment = NSTextAlignmentCenter;
            _code.textColor = [UIColor colorWithHexString:@"#FD6D08"];
            _code.font = FontSize(12);
            [_code setLayerCornerRadius:2 borderWidth:1 borderColor:[UIColor colorWithHexString:@"#FD6D08"]];
            _code.userInteractionEnabled = YES;
        }
    }
    if (!_registerBtn) {
        _registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_registerBtn];
        _registerBtn.whc_TopSpaceToView(72, _line).whc_LeftSpace(16).whc_RightSpace(16).whc_Height(44);
        [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
        [_registerBtn setTitleColor:[UIColor textColorWithType:0] forState:UIControlStateNormal];
        _registerBtn.backgroundColor = [UIColor colorWithHexString:@"#FFE656"];
        _registerBtn.titleLabel.font = FontSize(16);
        [_registerBtn setLayerCornerRadius:22];
        [_registerBtn addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    }
    if (!_tip) {
        _tip = [UILabel new];
        [self addSubview:_tip];
        _tip.userInteractionEnabled = YES;
        _tip.whc_TopSpaceToView(15, _registerBtn).whc_CenterX(0);
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"已账号去登录>"]];
        NSRange range = NSMakeRange(4, 3);
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
        if ([_delegate respondsToSelector:@selector(sendValue:)]) {
            [_delegate sendValue:phone];
        }
    }else if (textField.tag == 10002){
        pwd = textField.text;
    }
}
- (void)registerAction{
    
    if ([phone length] == 0) {
        [SVProgressHUD showErrorWithStatus:@"手机号不能为空"];
        return;
    }
    if ([pwd length] == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        return;
    }
    if ([codeNum length] == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        return;
    }
    if ([_delegate respondsToSelector:@selector(send:)]) {
        [_delegate send:@{@"phone":phone,@"pwd":pwd,@"code":codeNum}];
    }
}

@end
