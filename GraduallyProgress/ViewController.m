//
//  ViewController.m
//  GraduallyProgress
//
//  Created by wackosix on 16/5/25.
//  Copyright © 2016年 www.wackosix.cn. All rights reserved.
//

#import "ViewController.h"
#import "WSGraduallyProgress.h"
#import "UIColor+WS.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet WSGraduallyProgress *preview;

@end

@implementation ViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    self.preview.total = 20;
    self.preview.current += 1;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.preview.bgColor = [UIColor colorWithHex:0xfd9a51 alpha:0.2];
    self.preview.startColor = [UIColor colorWithHex:0xfd9a51 alpha:1];
    self.preview.endColor = [UIColor colorWithHex:0xff6c00 alpha:1];
}


@end
