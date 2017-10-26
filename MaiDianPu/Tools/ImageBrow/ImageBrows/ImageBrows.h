//
//  ImageBrows.h
//  warenqi
//
//  Created by 李志帅 on 16/8/10.
//  Copyright © 2016年 Mr.Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownActionSheetCell.h"
@interface ImageBrows : UIView<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
-(id)initWithImageTapWithUrlArray:(NSArray *)urlArray andIndex:(NSInteger)index;
- (void)showInView:(UIViewController *)Sview;
@end
