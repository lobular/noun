//
//  BaseNavigationBar.h
//  yuyan
//
//  Created by tangfeimu on 2019/3/27.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyNavigationBarDelegate <NSObject>

@optional
- (void)leftBtnAcion:(id)sender;
- (void)rightBtnAcion:(id)sender;

@end

@interface BaseNavigationBar : UIView

@property(weak,nonatomic)id<MyNavigationBarDelegate> delegate;

@property (strong,nonatomic)UIButton * rightBtn;

- (id)initWithFrame:(CGRect)frame withTitle:(NSString *)title withLeftBtnHidden:(BOOL)l_hidden withRightBtnHidden:(BOOL)r_hidden;

- (void)setLeftButtonTitle:(NSString *)title;

@end

