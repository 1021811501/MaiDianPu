//
//  ImageTapView.h
//  warenqi
//
//  Created by 李志帅 on 16/5/3.
//  Copyright © 2016年 Mr.Lin. All rights reserved.
//

#import "PopupView.h"
#import "AppDelegate.h"
@implementation PopupView
-(id)initWithTitle:(NSString *)title
{
    self = [super init];
    if (self) {
        UIFont *font = [UIFont boldSystemFontOfSize:15];;
        NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        paragraphStyle.lineBreakMode=NSLineBreakByWordWrapping;
        NSDictionary* attributes =@{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphStyle.copy};
        
        CGSize labelSize = [title boundingRectWithSize:CGSizeMake(kScreenWidth-50, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
        
        labelSize.height=ceil(labelSize.height);
        labelSize.width=ceil(labelSize.width);

        self.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0  blue:244/255.0  alpha:1];
        self.layer.cornerRadius = 3;
        self.layer.masksToBounds = YES;
        self.center = CGPointMake(kScreenWidth/2, kScreenHeight-90);
        self.bounds = CGRectMake(0, 0, labelSize.width+20, labelSize.height+5);
        UILabel *label = [[UILabel alloc]initWithFrame:self.bounds];
        label.font = font;
        label.textAlignment = NSTextAlignmentCenter;
        label.layer.cornerRadius = 10;
        label.numberOfLines = 0;
        label.backgroundColor =[UIColor colorWithRed:192/255.0 green:182/255.0  blue:170/255.0  alpha:1];
        label.textColor = [UIColor colorWithRed:77/255.0 green:77/255.0 blue:77/255.0 alpha:1];
        label.text = title;
        [self addSubview:label];
    }
    return self;
}
-(void)show
{
    AppDelegate *app = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    [app.window addSubview:self];
    [UIView animateWithDuration:2 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
