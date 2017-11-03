//
//  JSItemView.h
//  JSImageBrows
//
//  Created by JasonLee on 2017/10/30.
//  Copyright © 2017年 JasonLee. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JSItemView;
@protocol JSItemViewDelegate <NSObject>
-(void)jsItemViewSigleTapActionToHide:(JSItemView *)itemView;
-(void)jsItemViewLongPressAction:(JSItemView *)itemView;

@end
@interface JSItemView : UIScrollView<UIScrollViewDelegate>
@property(nonatomic,strong)UIImageView *itemImageView;
@property(nonatomic, weak)id <JSItemViewDelegate>guestureDelegate;
@property(nonatomic,strong)id image;
@property(nonatomic,strong)UIImage *placeHolderImage;
-(void)updateViewWithImage:(id)image;
@end
