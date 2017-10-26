//
//  CityPickerView.h
//  warenqi
//
//  Created by 李志帅 on 16/4/8.
//  Copyright © 2016年 Mr.Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProvinceModel.h"
#import "CityModel.h"
@protocol CityPickDelegate <NSObject>
@optional
-(void)didSelectProvince:(ProvinceModel *)province andCity:(CityModel *)city andArea:(CityModel *)area;
@end
@interface CityPickerView : UIView<UIGestureRecognizerDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic , weak)id<CityPickDelegate>delegate;
-(id)initWithPickerView;
- (void)showInView:(UIViewController *)Sview;
@end
