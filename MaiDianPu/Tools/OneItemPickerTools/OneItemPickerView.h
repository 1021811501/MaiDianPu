//
//  OneItemPickerView.h
//  WaShiKe
//
//  Created by Mr.Lin. on 2017/2/16.
//  Copyright © 2017年 JasonLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OneItemPickerViewDelegate <NSObject>

- (void)oneItemPickerViewDidSelectedRows:(NSInteger )type AndPickerView:(UIPickerView *)pickrView;

@end

@interface OneItemPickerView : UIView <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIView *pickerBgView;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIButton *finishBtn;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, copy) NSArray *dataSourceArray;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, weak) id<OneItemPickerViewDelegate>delegate;

@end
