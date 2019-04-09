//
//  JDCategoryRightCollectionView.h
//  分类列表联动
//
//  Created by yifo on 2018/8/3.
//  Copyright © 2018年 yanhaiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassModel.h"

typedef void (^ModelValue)(childModel *model);

@interface JDCategoryRightCollectionView : UICollectionView

@property (nonatomic,strong)NSArray *childArr;
@property (nonatomic,strong)NSArray *fatherArr;

@property (nonatomic,copy)ModelValue value;

@end
