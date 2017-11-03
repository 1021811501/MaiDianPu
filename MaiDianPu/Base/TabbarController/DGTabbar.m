//
//  DGTabbar.m
//  MaiDianPu
//
//  Created by JasonLee on 2017/10/25.
//  Copyright © 2017年 JasonLee. All rights reserved.
//

#import "DGTabbar.h"
#import "UIImage+Utility.h"
#define DGMagin 10
@interface DGTabbar ()
@property(nonatomic, strong)UIButton *plusBtn;
@property(nonatomic, strong)UILabel *titleLabel;
@end

@implementation DGTabbar

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
//        self.shadowImage = [UIImage imageWithColor:[UIColor clearColor]];
        self.shadowImage = [UIImage imageNamed:@"tapbar_top_line"];
        [self createPluseBtn];
        [self createTitleLabel];
    }
    return self;
}
-(void)createPluseBtn{
    UIButton *plusBtn = [[UIButton alloc] init];
    [plusBtn setBackgroundImage:[UIImage imageNamed:@"post_normal"] forState:UIControlStateNormal];
    [plusBtn setBackgroundImage:[UIImage imageNamed:@"post_normal"] forState:UIControlStateHighlighted];
    self.plusBtn = plusBtn;
    
    [plusBtn addTarget:self action:@selector(plusBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:plusBtn];
}
-(void)createTitleLabel{
    UILabel *label = [[UILabel alloc] init];
    label.text = @"pluse";
    label.font = [UIFont systemFontOfSize:11];
    [label sizeToFit];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor grayColor];
    self.titleLabel = label;
    [self addSubview:label];
}
-(void)plusBtnDidClick:(UIButton *)btn{
    NSLog(@"pluse按钮点击");
    if ([self.delegate respondsToSelector:@selector(tabbarPluseBtnClick:)]) {
        [self.delegate tabbarPluseBtnClick:self];
    }
}

// 如果中间加plusebutton则将此处解注释
-(void)layoutSubviews{
    [super layoutSubviews];
//    self.plusBtn.center = CGPointMake(self.frame.size.width*0.5,  -2*DGMagin);
    //pluse图片尺寸128/2.0*114/2.0
    self.plusBtn.bounds = CGRectMake(0, 0, self.plusBtn.currentBackgroundImage.size.width, self.plusBtn.currentBackgroundImage.size.height);
    NSLog(@"-------------%.2f,%.2f,%.2f,%.2f",self.plusBtn.frame.origin.x,self.frame.origin.y,self.plusBtn.frame.size.width,self.plusBtn.frame.size.height);
    self.titleLabel.center = CGPointMake(self.plusBtn.center.x, CGRectGetMaxY(self.plusBtn.frame) + DGMagin);
    NSLog(@"+++++++%.2f,%.2f",self.titleLabel.center.x,self.titleLabel.center.y);
    self.titleLabel.text = @"添加";
    int btnIndex = 0;
    Class class = NSClassFromString(@"UITabBarButton");
    for (UIView *btn in self.subviews) {//遍历tabbar的子控件
        if ([btn isKindOfClass:class]) {//如果是系统的UITabBarButton，那么就调整子控件位置，空出中间位置
            //每一个按钮的宽度==tabbar的五分之一
            CGRect rect = btn.frame;
            rect.size.width = self.frame.size.width / 5.0;
            rect.origin.x = rect.size.width * btnIndex;
            btn.frame = rect;
            if (btnIndex == 0) {
                self.plusBtn.center = CGPointMake(self.frame.size.width*0.5, btn.center.y - 2*DGMagin);
            }
            
            btnIndex++;
            //如果是索引是2(从0开始的)，直接让索引++，目的就是让消息按钮的位置向右移动，空出来发布按钮的位置
            if (btnIndex == 2) {
                btnIndex++;
            }
            
        }
    }
    [self bringSubviewToFront:self.plusBtn];
    [self bringSubviewToFront:self.titleLabel];
}


// 如果中间加plusebutton则将此处解注释
//重写hitTest方法，去监听发布按钮的点击，目的是为了让凸出的部分点击也有反应
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    //这一个判断是关键，不判断的话push到其他页面，点击发布按钮的位置也是会有反应的，这样就不好了
    //self.isHidden == NO 说明当前页面是有tabbar的，那么肯定是在导航控制器的根控制器页面
    //在导航控制器根控制器页面，那么我们就需要判断手指点击的位置是否在发布按钮身上
    //是的话让发布按钮自己处理点击事件，不是的话让系统去处理点击事件就可以了
    if (self.isHidden == NO) {
        
        //将当前tabbar的触摸点转换坐标系，转换到发布按钮的身上，生成一个新的点
        CGPoint newP = [self convertPoint:point toView:self.plusBtn];
        
        //判断如果这个新的点是在发布按钮身上，那么处理点击事件最合适的view就是发布按钮
        if ( [self.plusBtn pointInside:newP withEvent:event]) {
            return self.plusBtn;
        }else{//如果点不在发布按钮身上，直接让系统处理就可以了
            
            return [super hitTest:point withEvent:event];
        }
    }
    
    else {//tabbar隐藏了，那么说明已经push到其他的页面了，这个时候还是让系统去判断最合适的view处理就好了
        return [super hitTest:point withEvent:event];
    }
}

@end
