//
//  JSImageBrowsCell.m
//  JSImageBrows
//
//  Created by JasonLee on 2017/10/30.
//  Copyright © 2017年 JasonLee. All rights reserved.
//

#import "JSImageBrowsCell.h"

@implementation JSImageBrowsCell
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.itemView];
    }
    return self;
}
-(JSItemView *)itemView{
    if (!_itemView) {
        _itemView = [[JSItemView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    }
    return _itemView;
}
//-(void)setImage:(id)image{
//    self.itemImageView.image = image;
//}
-(void)updateCellWithImage:(id)image{
    [self.itemView updateViewWithImage:image];
}
@end
