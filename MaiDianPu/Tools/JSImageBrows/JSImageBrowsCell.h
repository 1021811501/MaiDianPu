//
//  JSImageBrowsCell.h
//  JSImageBrows
//
//  Created by JasonLee on 2017/10/30.
//  Copyright © 2017年 JasonLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSItemView.h"
@interface JSImageBrowsCell : UICollectionViewCell
@property(nonatomic,strong)JSItemView * _Nonnull itemView;
//@property(nonnull,strong)id image;

-(void)updateCellWithImage:( _Nonnull id)image;
@end
