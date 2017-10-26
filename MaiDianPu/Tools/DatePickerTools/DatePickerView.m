//
//  DatePickerView.m
//  WaShiKe
//
//  Created by Mr.Lin. on 2017/2/16.
//  Copyright © 2017年 JasonLee. All rights reserved.
//

#import "DatePickerView.h"

@implementation DatePickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGBA_COLOR(160, 160, 160, 0);
        [self createViews];
        [self animate];
    }
    return self;
}

- (void)createViews{
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCancel)];
    [self addGestureRecognizer:singleTap];
    if (!_datePickerBgView) {
        _datePickerBgView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 210)];
        _datePickerBgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_datePickerBgView];
    }
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 210)];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        _datePicker.maximumDate = [NSDate date];
        _datePicker.timeZone = [NSTimeZone systemTimeZone];
        [_datePicker addTarget:self action:@selector(datePickerAction:) forControlEvents:UIControlEventValueChanged];
        [_datePickerBgView addSubview:_datePicker];
    }
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _cancelBtn.frame = CGRectMake(0, 0, 50, 50);
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_cancelBtn addTarget:self action:@selector(tapCancel) forControlEvents:UIControlEventTouchUpInside];
        [_datePickerBgView addSubview:_cancelBtn];
    }
    if (!_finishBtn) {
        _finishBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _finishBtn.frame = CGRectMake(kScreenWidth - 50, 0, 50, 50);
        [_finishBtn setTitle:@"完成" forState:UIControlStateNormal];
        _finishBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_finishBtn addTarget:self action:@selector(completeBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [_datePickerBgView addSubview:_finishBtn];
    }
}

- (void)animate{
    [UIView animateWithDuration:0.25 animations:^{
        self.backgroundColor =RGBA_COLOR (0, 0, 0, 0.5);
        _datePickerBgView.frame = CGRectMake(0, kScreenHeight - 210, kScreenWidth, 210);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)tapCancel{
    [UIView animateWithDuration:0.25 animations:^{
        self.backgroundColor = RGBA_COLOR(160, 160, 160, 0);
        _datePickerBgView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 210);
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

- (void)completeBtnAction{
    if (_timeStr == nil) {
        NSDate *date = [NSDate date];
        _timeStr = [self dateStr:date];
    }
    [self.delegate datePickerDidSelected:_timeStr];
    [self tapCancel];
}

- (void)datePickerAction:(UIDatePicker *)datePicker{
    NSDate *date = datePicker.date;
    _timeStr = [self dateStr:date];
}

- (NSString *)dateStr:(NSDate *)myDate{
    NSDate *date = myDate;
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    //    formatter.dateFormat=@"yy-MM-dd HH:mm:ss";
    formatter.dateFormat=@"yyyy-MM-dd";
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    NSString *timeStr = [formatter stringFromDate:date];
    NSLog(@"date-----%@",date);
    NSLog(@"timeStr-------%@",timeStr);
    
    //    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    //    NSInteger seconds = [timeZone secondsFromGMTForDate:date];
    //    NSDate *newDate = [date dateByAddingTimeInterval:seconds];
    //    NSString *newTimeStr = [formatter stringFromDate:newDate];
    //    NSLog(@"newDate----%@",newDate);
    //    NSLog(@"newTimeStr-------%@",newTimeStr);
    
    return timeStr;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
