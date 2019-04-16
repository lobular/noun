//
//  Header.h
//  yuyan
//
//  Created by tangfeimu on 2019/3/27.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#ifndef Header_h
#define Header_h


#define WEAK_SELF(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#ifdef DEBUG
#define NSLog(format, ...) printf("\n[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
#else
#define prinft(format, ...)
#endif

#pragma mark - 屏幕大小细线宽度 -- iOS11
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define LineHeight  (1 / [UIScreen mainScreen].scale)
#define iOS_11 @available(iOS 11.0,*)
#define NavigationHeight ((ScreenHeight >=  812) ? 88 : 64)
#define StatusBarHeight  (ScreenHeight >= 812 ? 44.f : 20.f)
#define ScaleWidth ScreenWidth / 375
#define ScaleHeight ScreenHeight / 667

#define TabBarHeight self.tabBarController.tabBar.frame.size.height
#define FontSize(x) [UIFont systemFontOfSize:x]

#define URL @"http://192.168.112.232/index.php"

#define HomeAPI [NSString stringWithFormat:@"%@/v1/creed/index",URL]
#define CateListAPI [NSString stringWithFormat:@"%@/v1/creed/cate-list",URL]   
#define ListAPI [NSString stringWithFormat:@"%@/v1/creed/list",URL]
#define DetailAPI [NSString stringWithFormat:@"%@/v1/creed/detail",URL]

#define LoginAPI [NSString stringWithFormat:@"%@/v1/login",URL]
#define CodeAPI  [NSString stringWithFormat:@"%@/v1/register/vercode",URL]
#define RegisterAPI [NSString stringWithFormat:@"%@/v1/register",URL]

#define ScoreAPI [NSString stringWithFormat:@"%@/v1/user/score-record",URL]
#define RecordAPI [NSString stringWithFormat:@"%@/v1/user/goods-record",URL]
#define RecordDetailAPI [NSString stringWithFormat:@"%@/v1/user/goods-record-detail",URL]
#define FeedBackAPI [NSString stringWithFormat:@"%@/v1/user/feedback",URL]

#define WellAPI [NSString stringWithFormat:@"%@/v1/goods/index",URL]
#define WellDetailAPI [NSString stringWithFormat:@"%@/v1/goods/detail",URL]
#define ExchangeAPI [NSString stringWithFormat:@"%@/v1/user/exchange-goods",URL]

#define questionAPI [NSString stringWithFormat:@"%@/v1/question",URL]
#define AnswerSuccAPI [NSString stringWithFormat:@"%@/v1/question/success",URL]

#define SearchAPI [NSString stringWithFormat:@"%@/v1/creed/search",URL]
#define VersionAPI [NSString stringWithFormat:@"%@/v1/site/app-version",URL]
#define ApnsAPI [NSString stringWithFormat:@"%@/v1/site/apns",URL]
#define ApnsReadAPI [NSString stringWithFormat:@"%@/v1/site/apns-to-readed",URL]

#define MessageAPI [NSString stringWithFormat:@"%@/v1/site/messages",URL]

#import <IQKeyboardManager.h>
#import <WHC_AutoLayout.h>
#import "UIColor+Category.h"


#endif /* Header_h */
