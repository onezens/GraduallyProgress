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

//- (void)setFrame:(CGRect)frame {
//    
//    [super setFrame: CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, self.height)];
//}

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
    _current = current > _total ? _total : current;
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
    [self drawBackGround:ctx startPoint:startPoint lineWidth:lineWidth width:width];
    
    if (self.total != 0) {
        for (NSInteger i=0; i<=self.current; i++) {
            [self change:startPoint width:width percent:i / self.total ref:ctx lineWidth:lineWidth isFirst:i==0 isLast:i==self.current];
        }
    }
}

- (void)drawBackGround:(CGContextRef)ctx startPoint:(CGPoint)startPoint lineWidth:(CGFloat)lineWidth width:(CGFloat)width{
    
    CGContextMoveToPoint(ctx, startPoint.x + lineWidth * 0.5, startPoint.y);
    CGContextAddLineToPoint(ctx, width - lineWidth * 0.5, startPoint.y);
    CGContextSetLineWidth(ctx, lineWidth);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextSetStrokeColorWithColor(ctx, self.bgColor.CGColor);
    CGContextStrokePath(ctx);
}


- (void)change:(CGPoint)startPoint width:(CGFloat)width percent:(CGFloat)percent ref:(CGContextRef)ctx lineWidth:(CGFloat)lineWidth isFirst:(BOOL)isFirst isLast:(BOOL)isLast {
    
    if (percent == 0 || percent > 1) return;
    percent = percent - 1.0/self.total;
    
    float OFR = [self.startColor valueR];
    float OFG = [self.startColor valueG];
    float OFB = [self.startColor valueB];
    
    float FR = [self.endColor valueR];
    float FG = [self.endColor valueG];
    float FB = [self.endColor valueB];
    
    //绘图（画线）
    CGContextSetLineWidth(ctx, lineWidth);
    if (isFirst || isLast) {
        CGContextSetLineCap(ctx, kCGLineCapRound);
    }else {
        CGContextSetLineCap(ctx, kCGLineCapSquare);
    }
    
    if (percent == 0.0000000 || percent == 1 - 1/self.total) {
        
        CGFloat first = width * percent + lineWidth * 0.5;
        CGFloat second =  width * percent + width * (1/_total) - lineWidth * 0.5;
        CGContextMoveToPoint(ctx,  first, startPoint.y );
        CGContextAddLineToPoint(ctx, first < second ? second : first, startPoint.y);
    }else{
        CGFloat first = width * percent;
        CGFloat second = width * percent + width * (1/_total);
        CGContextMoveToPoint(ctx, first, startPoint.y);
        CGContextAddLineToPoint(ctx, second, startPoint.y);
    }
    CGContextSetStrokeColorWithColor(ctx, [UIColor colorWithRed:(OFR+(FR-OFR)*percent) / 255.0 green:(OFG+(FG-OFG)*percent) / 255.0 blue:(OFB+(FB-OFB)*percent) / 255.0 alpha:1].CGColor);
    
    //渲染
    CGContextStrokePath(ctx);
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
