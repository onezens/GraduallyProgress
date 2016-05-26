//
//  WSGraduallyProgress.h
//  GraduallyProgress
//
//  Created by wackosix on 16/5/25.
//  Copyright © 2016年 www.wackosix.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSGraduallyProgress : UIView

@property (nonatomic, assign) CGFloat total;
@property (nonatomic, assign) CGFloat current;
@property (nonatomic, assign) NSInteger startHex;
@property (nonatomic, assign) NSInteger endHex;

@end
