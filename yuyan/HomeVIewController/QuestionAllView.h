//
//  QuestionAllView.h
//  yuyan
//
//  Created by tangfeimu on 2019/4/12.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface QuestionAllView : UIView

@property (nonatomic,strong)UIImageView *tip;
@property (nonatomic,strong)UILabel *tipLabel;
@property (nonatomic,strong)UILabel *resultLabel;

@property (nonatomic,strong)UIButton *converBtn;
@property (nonatomic,strong)UIButton *againBtn;

@property (nonatomic,assign)NSInteger num;

- (void)config:(NSArray *)arr;

@end

