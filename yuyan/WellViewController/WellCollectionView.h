//
//  WellCollectionView.h
//  yuyan
//
//  Created by tangfeimu on 2019/4/10.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WellDelegate <NSObject>

- (void)send:(NSString *)ID;

@end

@interface WellCollectionView : UICollectionView

@property (nonatomic,strong)NSArray *arr;

@property (nonatomic,weak)id<WellDelegate>wellDelegate;

//@property (nonatomic,weak)id<WellDelegate>delegate;

@end




