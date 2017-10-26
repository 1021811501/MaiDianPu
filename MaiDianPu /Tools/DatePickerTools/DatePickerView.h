//
//  DatePickerView.h
//  WaShiKe
//
//  Created by Mr.Lin. on 2017/2/16.
//  Copyright © 2017年 JasonLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DatePickerViewDelegate <NSObject>
@optional
- (void)datePickerDidSelected:(NSString *)dateStr;
@end

@interface DatePickerView : UIView

@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIView *datePickerBgView;
@property (nonatomic, strong) UIButton *finishBtn;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, copy) NSString *timeStr;
@property (nonatomic, weak) id<DatePickerViewDelegate>delegate;

@end
