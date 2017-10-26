//
//  TagExplainCell.h
//  WaShiKe
//
//  Created by JasonLee on 17/3/24.
//  Copyright © 2017年 JasonLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TagExplainCell : UITableViewCell
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *contentLabel;
-(void)updateCellWithTitle:(NSString *)title andContent:(NSString *)content;
@end
