//
//  LZSProgressView.m
//  warenqi
//
//  Created by 李志帅 on 16/8/5.
//  Copyright © 2016年 Mr.Lin. All rights reserved.
//

#import "LZSProgressView.h"


@implementation LZSProgressView


-(id)initWithWidth:(float)width andHeight:(float)height{
    self = [super init];
    if (self) {
        [self configurationProgressWithHeight:height];
        [self createProgressViewWithHeight:height];
    }
    return self;

}
-(void)configurationProgressWithHeight:(float)height{
    self.layer.cornerRadius = height/2.0f;
    self.backgroundColor = HexColor(@"f0eff5", 1);
}
-(void)createProgressViewWithHeight:(float)height{
    self.progressView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, height)];
    self.progressView.backgroundColor = [UIColor redColor];
    self.progressView.layer.cornerRadius = height/2.f;
    [self addSubview:self.progressView];
}
-(void)setProgress:(float)progress{
    _progress = progress;
    [self setNeedsLayout];
    [self layoutIfNeeded];
    [UIView animateWithDuration:.5 animations:^{
        self.progressView.frame = CGRectMake(0, 0, self.frame.size.width*progress, CGRectGetHeight(self.progressView.frame));
    }];
}
-(void)layoutSubviews{
    [super layoutSubviews];
}
@end
