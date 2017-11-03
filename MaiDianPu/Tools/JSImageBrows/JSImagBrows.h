//
//  JSImagBrows.h
//  JSImageBrows
//
//  Created by JasonLee on 2017/10/30.
//  Copyright © 2017年 JasonLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSImagBrows : UIViewController
/**
 *存放图片的数组
 */
@property(nonatomic, strong)NSArray *imageArray;
/**
 *当前图片的index
 */
@property(nonatomic, assign)NSInteger currentIndex;
/**
 *当前图片的index
 */
@property(nonatomic,strong)UIViewController *parentVC;
-(id)initWithParentController:(UIViewController *)VC images:(NSArray *)imageArray andCurrentIndex:(NSInteger)currentIndex andPlaceHolderImage:(UIImage *)placeHolderImage;
-(void)show;
@end

@interface JSPopUpView : UIView

@property(nonatomic,assign)int dismissTime;
-(id)initWithTitle:(NSString *)title andDisMissTime:(int)dismissTime;
-(id)initWithTitle:(NSString *)title;
-(void)show;

@end
