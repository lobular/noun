//
//  BaseViewController.h
//  yuyan
//
//  Created by tangfeimu on 2019/3/27.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BaseViewController : UIViewController

#pragma mark - Hud method
- (void)showHudWithMsg:(NSString *)msg;
- (void)showHudWithMsg:(NSString *)msg inView:(UIView *)view;
- (void)showProgressHudWithMsg:(NSString *)msg precentage:(CGFloat)precentage;
- (void)hideHuds;
- (void)hideMsgHud;
- (void)hideProgressHud;

#pragma mark - Toast method
- (void)showToast:(NSString *)msg;
- (void)showErrorToast;


@end

