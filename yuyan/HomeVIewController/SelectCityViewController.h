//
//  SelectCityViewController.h
//  yuyan
//
//  Created by tangfeimu on 2019/4/3.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "BaseViewController.h"

@protocol SelectCityDelegate <NSObject>

- (void)sendValueToHome:(NSDictionary *)dic;

@end

@interface SelectCityViewController : BaseViewController

@property (nonatomic,strong)NSArray *openCity;
@property (nonatomic,strong)NSArray *featureCity;

@property (nonatomic,weak)id <SelectCityDelegate>delegate;


@end

