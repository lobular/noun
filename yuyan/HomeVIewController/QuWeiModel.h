//
//  QuestionModel.h
//  yuyan
//
//  Created by tangfeimu on 2019/4/12.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AnswersModel : NSObject

@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *is_true;

@end

@interface QuWeiModel : NSObject

@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSArray *answers;

@end

