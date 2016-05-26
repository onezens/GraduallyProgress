//
//  WSGraduallyProgress.m
//  GraduallyProgress
//
//  Created by wackosix on 16/5/25.
//  Copyright © 2016年 www.wackosix.cn. All rights reserved.
//

#import "WSGraduallyProgress.h"

@interface WSGraduallyProgress()

//@property (nonatomic, assign) NSInteger percent;

@end

@implementation WSGraduallyProgress



- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.current = 0;
    }
    return self;
}

- (void)awakeFromNib {
    self.current = 0;
}

- (void)setCurrent:(CGFloat)current {
    
    _current = current;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect{
    
    UIColor *bgColor = [self colorWithHex:0xfd9a51 alpha:0.2];
    CGFloat lineWidth = 5.0;
    CGPoint startPoint = CGPointMake(0, rect.size.height * 0.5 - lineWidth * 0.5);
    CGFloat width = rect.size.width - startPoint.x * 2;
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(ctx, startPoint.x + lineWidth * 0.5, startPoint.y);
    CGContextAddLineToPoint(ctx, rect.size.width - lineWidth * 0.5, startPoint.y);
    CGContextSetLineWidth(ctx, lineWidth);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextSetStrokeColorWithColor(ctx, bgColor.CGColor);
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

- (void)change:(CGPoint)startPoint width:(CGFloat)width percent:(CGFloat)percent ref:(CGContextRef)ref lineWidth:(CGFloat)lineWidth{
    
    if (percent == 0 || percent > 1) return;
    percent = percent - 1.0/self.total;
    
    NSInteger oriFillHex = 0xfd9a51;
    NSInteger fillHex    = 0xff6c00; //变大
    
    float OFR = ((float)((oriFillHex & 0xFF0000) >> 16));
    float OFG = ((float)((oriFillHex & 0xFF00) >> 8));
    float OFB = ((float)((oriFillHex & 0xFF)));
    
    float FR = ((float)((fillHex & 0xFF0000) >> 16));
    float FG = ((float)((fillHex & 0xFF00) >> 8));
    float FB = ((float)((fillHex & 0xFF)));
    
    //绘图（画线）
    
    CGContextSetLineWidth(ref, lineWidth);
    
    NSLog(@"%f",percent);
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
@end
