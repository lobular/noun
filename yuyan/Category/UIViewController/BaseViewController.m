//
//  BaseViewController.m
//  yuyan
//
//  Created by tangfeimu on 2019/3/27.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "BaseViewController.h"
#import <JGProgressHUD/JGProgressHUD.h>
#import "UIView+Toast.h"
#import "UIColor+Category.h"

@interface BaseViewController ()

@property (nonatomic, strong) JGProgressHUD *hud;
@property (nonatomic, strong) JGProgressHUD *prototypeHud;

@end

@implementation BaseViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
}

#pragma mark - Hud method
- (void)showHudWithMsg:(NSString *)msg {
    self.hud.textLabel.text = msg;
    [self.hud showInView:[UIApplication sharedApplication].keyWindow animated:YES];
}

- (void)showHudWithMsg:(NSString *)msg inView:(UIView *)view {
    self.hud.textLabel.text = msg;
    [self.hud showInView:view animated:YES];
}

- (void)showProgressHudWithMsg:(NSString *)msg precentage:(CGFloat)precentage {
    if (precentage>1) {
        precentage = 1;
    }else if (precentage<=0.01) {
        precentage = 0;
    }
    JGProgressHUD *hud = self.prototypeHud;
    if(precentage != 1) {
        hud.textLabel.text = msg;
        hud.indicatorView = [[JGProgressHUDRingIndicatorView alloc] init];
        [hud setProgress:precentage animated:NO];
        hud.detailTextLabel.text = [NSString stringWithFormat:@"%@: %.f%% ",@"完成", precentage*100];
    } else {
        hud.textLabel.text = @"成功";
        hud.detailTextLabel.text = nil;
        hud.indicatorView = [[JGProgressHUDSuccessIndicatorView alloc] init];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud dismiss];
        });
    }
    
    if (!hud.isVisible){
        [hud showInView:self.view];
    }
}

- (void)hideHuds {
    [self hideMsgHud];
    [self hideProgressHud];
}

- (void)hideMsgHud {
    if (self.hud.isVisible) {
        [self.hud dismiss];
    }
}

- (void)hideProgressHud {
    if (self.prototypeHud.isVisible) {
        [self.prototypeHud dismiss];
    }
}

#pragma mark - Toast method
- (void)showToast:(NSString *)msg {
    [[UIApplication sharedApplication].keyWindow makeToast:msg];
}
- (void)showErrorToast{
    //    [self showToast:ERRORTOAST];
}

#pragma mark - lazy load
- (JGProgressHUD *)hud {
    if (!_hud) {
        _hud = [[JGProgressHUD alloc] initWithStyle:JGProgressHUDStyleDark];
    }
    return _hud;
}

- (JGProgressHUD *)prototypeHud {
    if (!_prototypeHud){
        _prototypeHud = [[JGProgressHUD alloc] initWithStyle:JGProgressHUDStyleDark];
        _prototypeHud.interactionType = JGProgressHUDInteractionTypeBlockNoTouches;
    }
    return _prototypeHud;
}

@end
