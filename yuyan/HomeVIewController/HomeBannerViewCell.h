//
//  HomeBannerViewCell.h
//  yuyan
//
//  Created by tangfeimu on 2019/4/19.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YSBannerView.h"


@interface HomeBannerViewCell : UITableViewCell<YSBannerViewDelegate>

@property (nonatomic,strong)YSBannerView *bannerView;


+ (instancetype)initWithTable:(UITableView *)table;

- (void)setValueForCell:(NSArray *)arr;

@end

