//
//  QuestionView.h
//  yuyan
//
//  Created by tangfeimu on 2019/4/12.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^ClickSucc)(NSInteger num);

@interface QuestionView : UIView

@property (nonatomic,strong)UILabel *title;
@property (nonatomic,strong)UIButton *questionBtn;
@property (nonatomic,strong)UIImageView *flagImage;
@property (nonatomic,strong)UILabel *content;
@property (nonatomic,strong)UIButton *nextBtn;

- (void)sendValue:(ClickSucc)value;


@end

