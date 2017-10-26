//
//  TagExplain.h
//  WaShiKe
//
//  Created by JasonLee on 17/3/24.
//  Copyright © 2017年 JasonLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TagExplainCell.h"
@interface TagExplain : UIView<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)NSMutableArray *titleArray;
@property(nonatomic,strong)NSMutableArray *contentArray;
-(instancetype)initWithFrame:(CGRect)frame andTitleArray:(NSArray *)titleArray andContentArray:(NSArray *)contentArray;
- (void)showInView:(UIViewController *)Sview;
@end
