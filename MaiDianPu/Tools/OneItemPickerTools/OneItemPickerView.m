//
//  OneItemPickerView.m
//  WaShiKe
//
//  Created by Mr.Lin. on 2017/2/16.
//  Copyright © 2017年 JasonLee. All rights reserved.
//

#import "OneItemPickerView.h"

@implementation OneItemPickerView

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
    if (!_pickerBgView) {
        _pickerBgView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 210)];
        _pickerBgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_pickerBgView];
    }
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 210)];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        [_pickerBgView addSubview:_pickerView];
    }
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _cancelBtn.frame = CGRectMake(0, 0, 50, 50);
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_cancelBtn addTarget:self action:@selector(tapCancel) forControlEvents:UIControlEventTouchUpInside];
        [_pickerBgView addSubview:_cancelBtn];
    }
    if (!_finishBtn) {
        _finishBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _finishBtn.frame = CGRectMake(kScreenWidth - 50, 0, 50, 50);
        [_finishBtn setTitle:@"完成" forState:UIControlStateNormal];
        _finishBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_finishBtn addTarget:self action:@selector(completeBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [_pickerBgView addSubview:_finishBtn];
    }
}

- (void)animate{
    [UIView animateWithDuration:0.25 animations:^{
        self.backgroundColor =RGBA_COLOR (0, 0, 0, 0.5);
        _pickerBgView.frame = CGRectMake(0, kScreenHeight - 210, kScreenWidth, 210);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)tapCancel{
    [UIView animateWithDuration:0.25 animations:^{
        self.backgroundColor = RGBA_COLOR(160, 160, 160, 0);
        _pickerBgView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 210);
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

- (void)completeBtnAction{
    [self.delegate oneItemPickerViewDidSelectedRows:_type AndPickerView:_pickerView];
    [self tapCancel];
}

- (void)setDataSourceArray:(NSArray *)dataSourceArray{
    if (dataSourceArray != _dataSourceArray) {
        _dataSourceArray = dataSourceArray;
        [_pickerView reloadAllComponents];
    }
}

#pragma mark UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _dataSourceArray.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component __TVOS_PROHIBITED{
    return kScreenWidth - 30;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component __TVOS_PROHIBITED{
    return 35;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view {
    UILabel *label = (UILabel *)view;
    label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:16];
    label.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return label;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component __TVOS_PROHIBITED{
    return _dataSourceArray[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component __TVOS_PROHIBITED{
    _type = row;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
