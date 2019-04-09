//
//  JDCategoryRightCollectionCell.h
//  分类列表联动
//
//  Created by yifo on 2018/8/3.
//  Copyright © 2018年 yanhaiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassModel.h"

@protocol rightDelegate <NSObject>

- (void)sendWhich:(childModel *)model;

@end

@interface JDCategoryRightCollectionCell : UICollectionViewCell
@property (nonatomic, strong) NSString *sectionTitle;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic,strong)NSArray *arr;

@property (nonatomic,weak)id<rightDelegate>delegate;

@end
