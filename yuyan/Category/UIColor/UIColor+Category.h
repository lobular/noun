//
//  UIColor+Category.h
//  yuyan
//
//  Created by tangfeimu on 2019/3/27.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Category)

+ (UIColor *)mainColor;
+ (UIColor *)secondMainColor;
+ (UIColor *)backgroundColor;
+ (UIColor *)separationColor;
+ (UIColor *)searchViewBackgroundColor;
+ (UIColor *)textColorWithType:(NSInteger )type;

+ (UIColor *)colorWithHexString:(NSString *)color;
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end

