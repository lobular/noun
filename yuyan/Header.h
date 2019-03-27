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


#endif /* Header_h */
