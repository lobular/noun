//
//  LoginView.h
//  yuyan
//
//  Created by tangfeimu on 2019/4/8.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^Value)(NSDictionary *dataDic);

@interface LoginView : UIView

@property (nonatomic,strong)UILabel *login;
@property (nonatomic,strong)UITextField *context;
@property (nonatomic,strong)UILabel *line;
@property (nonatomic,strong)UIImageView *secImage;
@property (nonatomic,strong)UIButton *loginBtn;
@property (nonatomic,strong)UILabel *tip;
@property (nonatomic,strong)UILabel *forget;

@property (nonatomic,copy)Value dic;

@end


