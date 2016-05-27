//
//  UIColor+WS.m
//  GraduallyProgress
//
//  Created by wackosix on 16/5/27.
//  Copyright © 2016年 www.wackosix.cn. All rights reserved.
//

#import "UIColor+WS.h"

@implementation UIColor (WS)


- (float)valueAlpha {
    
    NSDictionary *dict = [self getRGB];
    return [dict[@"A"] floatValue];
}

- (float)valueR {
    
    NSDictionary *dict = [self getRGB];
    return [dict[@"R"] floatValue] * 255;
}

- (float)valueG {
    NSDictionary *dict = [self getRGB];
    return [dict[@"G"] floatValue] * 255;
}

-(float)valueB {
    
    NSDictionary *dict = [self getRGB];
    return [dict[@"B"] floatValue] * 255;
    
}


- (NSDictionary *)getRGB
{
    CGFloat r=0,g=0,b=0,a=0;
    if ([self respondsToSelector:@selector(getRed:green:blue:alpha:)]) {
        [self getRed:&r green:&g blue:&b alpha:&a];
    }
    else {
        const CGFloat *components = CGColorGetComponents(self.CGColor);
        r = components[0];
        g = components[1];
        b = components[2];
        a = components[3];
    }
    
    return @{@"R":@(r),
             @"G":@(g),
             @"B":@(b),
             @"A":@(a)};
}


/**
 *  获取UIColor对象的rgb值。
 *
 *  @param originColor
 *
 *  @return
 */
- (NSString *)getHexStringByColor:(UIColor *)originColor
{
    NSDictionary *colorDic
    = [self getRGBDictionaryByColor:originColor];
    int r = [colorDic[@"R"] floatValue] * 255;
    int g = [colorDic[@"G"] floatValue] * 255;
    int b = [colorDic[@"B"] floatValue] * 255;
    NSString *red = [NSString stringWithFormat:@"%02x", r];
    NSString *green = [NSString stringWithFormat:@"%02x", g];
    NSString *blue = [NSString stringWithFormat:@"%02x", b];
    
    return [NSString stringWithFormat:@"#%@%@%@", red, green, blue];
}

- (NSDictionary *)getRGBDictionaryByColor:(UIColor *)originColor
{
    CGFloat r=0,g=0,b=0,a=0;
    if ([self respondsToSelector:@selector(getRed:green:blue:alpha:)]) {
        [originColor getRed:&r green:&g blue:&b alpha:&a];
    }
    else {
        const CGFloat *components = CGColorGetComponents(originColor.CGColor);
        r = components[0];
        g = components[1];
        b = components[2];
        a = components[3];
    }
    
    return @{@"R":@(r),
             @"G":@(g),
             @"B":@(b),
             @"A":@(a)};
}


+(UIColor *)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0
                           green:((float)((hexValue & 0xFF00) >> 8)) / 255.0
                            blue:((float)(hexValue & 0xFF))/255.0
                           alpha:alpha];
}

@end
