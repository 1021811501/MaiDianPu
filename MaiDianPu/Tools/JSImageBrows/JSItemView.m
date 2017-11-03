//
//  JSItemView.m
//  JSImageBrows
//
//  Created by JasonLee on 2017/10/30.
//  Copyright © 2017年 JasonLee. All rights reserved.
//

#import "JSItemView.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"

static const CGFloat Max_Zoom_Scale = 3.0f;
static const CGFloat Min_Zoom_Scale = 1.0f;
@implementation JSItemView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame: frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.maximumZoomScale = Max_Zoom_Scale;
        self.minimumZoomScale = Min_Zoom_Scale;
        self.zoomScale = 1.0f;
        self.delegate = self;
        [self addSubview:self.itemImageView];
        [self addGuesture];
    }
    return self;
}
-(void)addGuesture{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleClick:)];
    doubleTap.numberOfTapsRequired = 2;
    [self addGestureRecognizer:tap];
    [self.itemImageView addGestureRecognizer:doubleTap];
    //这行很关键,解决点击和双击手势共存时的问题,你会发现两者共存时双击时单击方法也会执行,
    [tap requireGestureRecognizerToFail:doubleTap];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    [self addGestureRecognizer:longPress];
}
-(UIImageView *)itemImageView{
    if (!_itemImageView) {
        _itemImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        _itemImageView.center = self.center;
        _itemImageView.contentMode = UIViewContentModeScaleAspectFill;
        _itemImageView.userInteractionEnabled = YES;
        _itemImageView.clipsToBounds = YES;
        
    }
    return _itemImageView;
}
-(void)tapAction:(UITapGestureRecognizer *)guesture{
    NSLog(@"-----------");
    if (guesture.numberOfTapsRequired == 1) {
        if ([self.guestureDelegate respondsToSelector:@selector(jsItemViewSigleTapActionToHide:)]) {
            [self.guestureDelegate jsItemViewSigleTapActionToHide:self];
            NSLog(@"++++++++++");
        }
    }
}
-(void)doubleClick:(UITapGestureRecognizer *)guesture{
    if (guesture.numberOfTapsRequired == 2) {
        NSLog(@"双击放大两倍");
        if (self.zoomScale == 1) {
            float newScale = [self zoomScale] * 2;
            CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[guesture locationInView:self]];
            [self zoomToRect:zoomRect animated:YES];
        }else{
            float newScale = [self zoomScale] / 2;
            CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[guesture locationInView:self]];
            [self zoomToRect:zoomRect animated:YES];
        }
    }
}
-(void)longPressAction:(UILongPressGestureRecognizer *)guesture{
    if (guesture.state == UIGestureRecognizerStateBegan) {
        if ([self.guestureDelegate respondsToSelector:@selector(jsItemViewLongPressAction:)]) {
            [self.guestureDelegate jsItemViewLongPressAction:self ];
        }
    }
    
}
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.itemImageView;
}
-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
    
//    [scrollView setZoomScale:scale animated:NO];
}
-(void)scrollViewDidZoom:(UIScrollView *)scrollView{
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width) ? (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height) ? (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    [UIView animateWithDuration:0.2 animations:^{
        self.itemImageView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX, scrollView.contentSize.height * 0.5 + offsetY);
    }];
}
- (CGRect)zoomRectForScale:(CGFloat)scale withCenter:(CGPoint)center{
    CGRect zoomRect;
    zoomRect.size.height = [self frame].size.height / scale;
    zoomRect.size.width = [self frame].size.width / scale;
    zoomRect.origin.x = center.x - zoomRect.size.width / 2;
    zoomRect.origin.y = center.y - zoomRect.size.height / 2;
    return zoomRect;
}
-(void)updateViewWithImage:(id)image{
    self.zoomScale = 1.0f;
    if ([image isKindOfClass:[NSString class]]) {
        [self.itemImageView sd_setImageWithURL:[NSURL URLWithString:image] placeholderImage:self.placeHolderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [self calculateDestinationFrameWithImage:image];
        }];
        
    }else if ([image isKindOfClass:[UIImage class]]){
        self.itemImageView.image = image;
        [self calculateDestinationFrameWithImage:image];
    }
}
- (void)calculateDestinationFrameWithImage:(UIImage *)image{
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    if (rect.size.width > [UIScreen mainScreen].bounds.size.width) {
        rect = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width , rect.size.height *  [UIScreen mainScreen].bounds.size.width/rect.size.width);
    }
    if (rect.size.height > [UIScreen mainScreen].bounds.size.height) {
        rect = CGRectMake(0, 0, rect.size.width * [UIScreen mainScreen].bounds.size.height / rect.size.height, [UIScreen mainScreen].bounds.size.height);
    }
    [UIView animateWithDuration:0.2 delay:0 usingSpringWithDamping:0.7f initialSpringVelocity:0 options:0 animations:^{
        self.itemImageView.bounds = rect;
    } completion:nil];

}

@end
