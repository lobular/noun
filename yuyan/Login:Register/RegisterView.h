//
//  RegisterView.h
//  yuyan
//
//  Created by tangfeimu on 2019/4/9.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RegisterDelegate <NSObject>

- (void)sendValue:(NSString *)phone;
- (void)send:(NSDictionary *)dic;

@end


@interface RegisterView : UIView

@property (nonatomic,strong)UILabel *registe;
@property (nonatomic,strong)UITextField *context;
@property (nonatomic,strong)UILabel *line;
@property (nonatomic,strong)UILabel *code;
@property (nonatomic,strong)UIButton *registerBtn;
@property (nonatomic,strong)UILabel *tip;
@property (nonatomic,strong)UILabel *num;


@property (nonatomic,strong)UILabel *tips;
@property (nonatomic,strong)UILabel *url;

@property (nonatomic,strong)NSString *fromWhich;


@property (nonatomic,weak)id<RegisterDelegate>delegate;


@end

