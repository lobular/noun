//
//  IdeaBackView.h
//  yuyan
//
//  Created by tangfeimu on 2019/4/10.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IdeaViewDelegate <NSObject>

- (void)sendValueForText:(NSString *)text;

@end

@interface IdeaBackView : UIView

@property (nonatomic,weak)id<IdeaViewDelegate>delegate;

@end

