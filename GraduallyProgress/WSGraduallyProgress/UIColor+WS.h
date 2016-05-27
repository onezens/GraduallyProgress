//
//  UIColor+WS.h
//  GraduallyProgress
//
//  Created by wackosix on 16/5/27.
//  Copyright © 2016年 www.wackosix.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (WS)

- (float)valueR;
- (float)valueG;
- (float)valueB;
- (float)valueAlpha;

/**
 *  获取UIColor对象的rgb值。
 *
 *  @param originColor
 *
 *  @return
 */
- (NSString *)getHexStringByColor:(UIColor *)originColor;
+ (UIColor *)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alpha;

@end
