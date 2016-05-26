//
//  ViewController.m
//  GraduallyProgress
//
//  Created by wackosix on 16/5/25.
//  Copyright © 2016年 www.wackosix.cn. All rights reserved.
//

#import "ViewController.h"
#import "WSGraduallyProgress.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet WSGraduallyProgress *preview;

@end

@implementation ViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    self.preview.total = 118;
    self.preview.current += 1;
}

//
//- (void)drawLinearGradient:(CGContextRef)context
//
//                      path:(CGPathRef)path
//
//                startColor:(CGColorRef)startColor
//
//                  endColor:(CGColorRef)endColor
//
//{
//    
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    
//    CGFloat locations[] = { 0.0, 1.0 };
//    
//    NSArray *colors = @[(__bridge id) startColor, (__bridge id) endColor];
//    
//    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
//    
//    CGRect pathRect = CGPathGetBoundingBox(path);
//    
//    //具体方向可根据需求修改
//    
//    CGPoint startPoint = CGPointMake(CGRectGetMidX(pathRect), CGRectGetMinY(pathRect));
//    
//    CGPoint endPoint = CGPointMake(CGRectGetMidX(pathRect), CGRectGetMaxY(pathRect));
//    
//    CGContextSaveGState(context);
//    
//    CGContextAddPath(context, path);
//    
//    CGContextClip(context);
//    
//    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
//    
//    CGContextRestoreGState(context);
//    
//    CGGradientRelease(gradient);
//    
//    CGColorSpaceRelease(colorSpace);
//    
//}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
//    //创建CGContextRef
//    
//    UIGraphicsBeginImageContext(self.view.bounds.size);
//    
//    CGContextRef gc = UIGraphicsGetCurrentContext();
//    
//    //创建CGMutablePathRef
//    
//    CGMutablePathRef path = CGPathCreateMutable();
//    
//    //绘制Path
//    
//    CGRect rect = CGRectInset(self.view.bounds, 30, 30);
//    
//    CGPathMoveToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMinY(rect));
//    
//    CGPathAddLineToPoint(path, NULL, CGRectGetMidX(rect), CGRectGetHeight(rect));
//    
//    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(rect), CGRectGetHeight(rect) * 2 / 3);
//    
//    CGPathCloseSubpath(path);
//    
//    //绘制渐变
//    
//    [self drawLinearGradient:gc path:path startColor:[UIColor greenColor].CGColor endColor:[UIColor redColor].CGColor];
//    
//    //注意释放CGMutablePathRef
//    
//    CGPathRelease(path);
//    
//    //从Context中获取图像，并显示在界面上
//    
//    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
//    
//    UIGraphicsEndImageContext();
//    
//    UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
//    
//    [self.view addSubview:imgView];
    
}


@end
