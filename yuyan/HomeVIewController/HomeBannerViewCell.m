//
//  HomeBannerViewCell.m
//  yuyan
//
//  Created by tangfeimu on 2019/4/19.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "HomeBannerViewCell.h"
#import <UIImageView+WebCache.h>

@implementation HomeBannerViewCell

+ (instancetype)initWithTable:(UITableView *)table{
    HomeBannerViewCell *cell = [table dequeueReusableCellWithIdentifier:@"banner"];
    if (!cell) {
        cell = [[HomeBannerViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"banner"];
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self config];
    }
    return self;
}

- (void)config{
    if (!_bannerView) {
        _bannerView = [[YSBannerView alloc] init];
        [self.contentView addSubview:_bannerView];
        _bannerView.whc_LeftSpace(0).whc_RightSpace(0)
        .whc_TopSpace(0).whc_BottomSpace(0);
    }
}

- (void)setValueForCell:(NSArray *)arr{
        self.bannerView.downloadImageBlock =
        ^(UIImageView *imageView, NSURL *url, UIImage *placeholderImage) {
            [imageView sd_setImageWithURL:url placeholderImage:placeholderImage];
        };
    self.bannerView.imageArray = arr;
}

@end
