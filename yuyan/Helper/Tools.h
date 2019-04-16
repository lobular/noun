//
//  Tools.h
//  yuyan
//
//  Created by tangfeimu on 2019/3/27.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface Tools : NSObject


#pragma mark 获取当前视图
+ (UIViewController *)getCurrentViewController;

+ (void)startWithTime:(NSInteger)timeLine label:(UILabel *)label title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color;

+ (NSAttributedString *)text:(NSMutableAttributedString *)text fontSize:(CGFloat)fontSize color:(UIColor *)color rang:(NSRange)rang;

+ (UIAlertController *)returnAlert;


@end

