//
//  ImageTapView.h
//  warenqi
//
//  Created by 李志帅 on 16/5/3.
//  Copyright © 2016年 Mr.Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownActionSheetCell.h"
@interface ImageTapView : UIView<UIGestureRecognizerDelegate,UITableViewDataSource,UITableViewDelegate>
-(id)initWithImageTapWithUrl:(NSString *)url;
- (void)showInView:(UIViewController *)Sview;
@end
