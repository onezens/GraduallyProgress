//
//  WSGraduallyProgress.m
//  GraduallyProgress
//
//  Created by wackosix on 16/5/25.
//  Copyright © 2016年 www.wackosix.cn. All rights reserved.
//

#import "WSGraduallyProgress.h"
#import "UIColor+WS.h"

@implementation WSGraduallyProgress

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.current = 0;
        self.backgroundColor = [UIColor whiteColor];
        self.bgColor = [UIColor whiteColor];
    }
    return self;
}

- (void)awakeFromNib {
    self.current = 0;
    self.bgColor = [UIColor whiteColor];
}

- (void)setCurrent:(CGFloat)current {
    _current = current;
    [self setNeedsDisplay];
}

- (void)setBgColor:(UIColor *)bgColor {
    
    _bgColor = bgColor;
    [self setNeedsDisplay];
}

#pragma mark - draw

- (void)drawRect:(CGRect)rect{
    
    CGFloat lineWidth = 5.0;
    CGPoint startPoint = CGPointMake(0, rect.size.height * 0.5 - lineWidth * 0.5);
    CGFloat width = rect.size.width - startPoint.x * 2;
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(ctx, startPoint.x + lineWidth * 0.5, startPoint.y);
    CGContextAddLineToPoint(ctx, rect.size.width - lineWidth * 0.5, startPoint.y);
    CGContextSetLineWidth(ctx, lineWidth);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextSetStrokeColorWithColor(ctx, self.bgColor.CGColor);
    CGContextStrokePath(ctx);
    
    if (self.total != 0) {
        for (NSInteger i=0; i<=self.current; i++) {
            if (self.total == i) {
                break;
            }
            [self change:startPoint width:width percent:i / self.total ref:ctx lineWidth:lineWidth];
        }
    }
}


- (void)change:(CGPoint)startPoint width:(CGFloat)width percent:(CGFloat)percent ref:(CGContextRef)ref lineWidth:(CGFloat)lineWidth{
    
    if (percent == 0 || percent > 1) return;
    percent = percent - 1.0/self.total;
    
    float OFR = [self.startColor valueR];
    float OFG = [self.startColor valueG];
    float OFB = [self.startColor valueB];
    
    float FR = [self.endColor valueR];
    float FG = [self.endColor valueG];
    float FB = [self.endColor valueB];
    
    //绘图（画线）
    CGContextSetLineWidth(ref, lineWidth);
    CGContextSetLineCap(ref, kCGLineCapRound);
    if (percent == 0.0000000 || percent == 1 - 1/self.total) {
        CGFloat first = width * percent + lineWidth * 0.5;
        CGFloat second =  width * percent + width * (1/_total) - lineWidth * 0.5;
        CGContextMoveToPoint(ref,  first, startPoint.y );
        CGContextAddLineToPoint(ref, first < second ? second : first, startPoint.y);
    }else{
        CGFloat first = width * percent;
        CGFloat second = width * percent + width * (1/_total);
        CGContextMoveToPoint(ref, first, startPoint.y);
        CGContextAddLineToPoint(ref, second, startPoint.y);
    }
    CGContextSetStrokeColorWithColor(ref, [UIColor colorWithRed:(OFR+(FR-OFR)*percent) / 255.0 green:(OFG+(FG-OFG)*percent) / 255.0 blue:(OFB+(FB-OFB)*percent) / 255.0 alpha:1].CGColor);
    
    //渲染
    CGContextStrokePath(ref);
}


- (UIColor *)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0
                           green:((float)((hexValue & 0xFF00) >> 8)) / 255.0
                            blue:((float)(hexValue & 0xFF))/255.0
                           alpha:alpha];
}



- (void)drawLinearGradient:(CGContextRef)context

                      path:(CGPathRef)path

                startColor:(CGColorRef)startColor

                  endColor:(CGColorRef)endColor

{
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGFloat locations[] = { 0.0, 1.0 };
    
    NSArray *colors = @[(__bridge id) startColor, (__bridge id) endColor];
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
    
    CGRect pathRect = CGPathGetBoundingBox(path);
    
    //具体方向可根据需求修改
    
    CGPoint startPoint = CGPointMake(CGRectGetMidX(pathRect), CGRectGetMinY(pathRect));
    
    CGPoint endPoint = CGPointMake(CGRectGetMidX(pathRect), CGRectGetMaxY(pathRect));
    
    CGContextSaveGState(context);
    
    CGContextAddPath(context, path);
    
    CGContextClip(context);
    
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    
    CGContextRestoreGState(context);
    
    CGGradientRelease(gradient);
    
    CGColorSpaceRelease(colorSpace);
    
}
@end
