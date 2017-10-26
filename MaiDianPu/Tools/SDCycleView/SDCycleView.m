//
//  SDCycleView.m
//  WaShiKe
//
//  Created by JasonLee on 17/2/4.
//  Copyright © 2017年 JasonLee. All rights reserved.
//

#import "SDCycleView.h"

@implementation SDCycleView

-(id)initWithFrame:(CGRect)frame andDelegate:(id)delegate andUrlGroup:(NSArray *)urlArray andTitleGroup:(NSArray *)titleArray andPageControlAliment:(SDCycleScrollViewPageContolAliment)aliment andBannerImageViewContentMode:(UIViewContentMode)contentMode andCurrentPageDotColor:(UIColor *)dotColor andPageControlStyle:(SDCycleScrollViewPageContolStyle)pageControlStyle{
   self =  [super initWithFrame:frame];
    if (self) {
        [self createViewWithDelegate:delegate andUrlGroup:urlArray andTitleGroup:titleArray andPageControlAliment:SDCycleScrollViewPageContolAlimentCenter andBannerImageViewContentMode:contentMode andCurrentPageDotColor:dotColor andPageControlStyle:pageControlStyle];
    }
    return self;
}
-(void)createViewWithDelegate:(id)delegate andUrlGroup:(NSArray *)urlArray andTitleGroup:(NSArray *)titleArray andPageControlAliment:(SDCycleScrollViewPageContolAliment)aliment andBannerImageViewContentMode:(UIViewContentMode)contentMode andCurrentPageDotColor:(UIColor *)dotColor andPageControlStyle:(SDCycleScrollViewPageContolStyle)pageControlStyle{
    SDCycleScrollView *view = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:delegate placeholderImage:[UIImage imageNamed:@""]];
    [self addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    view.delegate = delegate;
    view.imageURLStringsGroup = urlArray;
    view.titlesGroup = titleArray;
    view.pageControlStyle = pageControlStyle;
    view.currentPageDotColor = dotColor;
    view.pageDotColor = [UIColor redColor];
    view.pageControlAliment = aliment;
    view.pageControlDotSize = CGSizeMake(6, 6);
    view.placeholderImage = [UIImage imageNamed:@""];
    view.autoScrollTimeInterval = 2;
    view.contentMode = UIViewContentModeScaleAspectFill;
}
@end
