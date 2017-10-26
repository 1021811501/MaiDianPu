//
//  CityPickerView.m
//  warenqi
//
//  Created by 李志帅 on 16/4/8.
//  Copyright © 2016年 Mr.Lin. All rights reserved.
//

#import "CityPickerView.h"
#import "ProvinceHttpManager.h"

@implementation CityPickerView{
    UIView *downView;
    NSMutableArray *provinceArray;
    NSMutableArray *cityArray;
    NSMutableArray *areaArray;
    UIPickerView *picker;
    NSInteger provinceRow;
    NSInteger cityRow;
    NSInteger areaRow;

}
-(id)initWithPickerView{
    self = [super init];
    if(self){
        self.frame = CGRectMake(0, 0, kScreenWidth , kScreenHeight);
        self.backgroundColor = RGBA_COLOR(160, 160, 160, 0);
        [self createView];
        [self animeData];
        [self requestProvince];
    }
    return self;
}
-(void)createView{
    float height = 50;
    downView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 210)];
    downView.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:downView];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"完成" forState:UIControlStateNormal];
//    [btn setTitleColor:kLoginBtnColor forState:UIControlStateNormal];
    btn.frame = CGRectMake(kScreenWidth - height, 0, height, height);
    [btn addTarget:self action:@selector(compliteBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [downView addSubview:btn];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn1 setTitle:@"取消" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btn1.frame = CGRectMake(0, 0, height, height);
    [btn1 addTarget:self action:@selector(tappedCancel) forControlEvents:UIControlEventTouchUpInside];
    [downView addSubview:btn1];
    
    [self createPickerView];
}
-(void)createPickerView{
    picker = [[UIPickerView alloc] init];
    picker.bounds = CGRectMake(0, 0, kScreenHeight, 162);
    picker.center = CGPointMake(kScreenWidth/2, (CGRectGetHeight(downView.frame) + 35)/2);
    picker.dataSource=self;
    picker.delegate = self;
    [downView addSubview:picker];
}
-(void)animeData{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedCancel)];
    [self addGestureRecognizer:tapGesture];
    tapGesture.delegate = self;
    [UIView animateWithDuration:.25 animations:^{
        self.backgroundColor =RGBA_COLOR (0, 0, 0, .5);
        [UIView animateWithDuration:.25 animations:^{
            [downView setFrame:CGRectMake(0, kScreenHeight-210, kScreenHeight, 210)];
        }];
    } completion:^(BOOL finished) {
    }];
}
-(void)compliteBtnClick{
    [self tappedCancel];
    ProvinceModel *model = provinceArray[provinceRow];
    CityModel *cityModel = cityArray[cityRow];
    CityModel *areaModel = areaArray[areaRow];
    [self.delegate didSelectProvince:model andCity:cityModel andArea:areaModel];
}   
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return provinceArray.count;
    }else if(component ==1){
        return cityArray.count;
    }else{
        return areaArray.count;
    }
}
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
         ProvinceModel *model = provinceArray[row];
        return model.name;
    }else if(component == 1){
        CityModel *model = cityArray[row];
        return model.name;
    }else{
        CityModel *model = areaArray[row];
        return model.name;
    }
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view {
    UILabel *label = (UILabel *)view;
    label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:14];
    label.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        provinceRow = row;
        ProvinceModel *model = provinceArray[row];
        [self requestCityWith:model.id];
        if (cityArray.count !=0 ) {
            [picker selectRow:0 inComponent:1 animated:YES];
        }
        if (areaArray.count != 0) {
            [picker selectRow:0 inComponent:2 animated:YES];
        }
    }else if (component == 1){
        cityRow = row;
        CityModel *model = cityArray[row];
        [self requestAreaWith:model.id];
        if (areaArray.count != 0) {
            [picker selectRow:0 inComponent:2 animated:YES];
        }
    }
    else{
        areaRow = row;
    }
}
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return kScreenWidth/3;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30;
}

-(void)requestProvince{
    __weak typeof(self) weakself = self;
    [ProvinceHttpManager requestProvince:^(NSMutableArray *provinceArr) {
        provinceArray = [NSMutableArray arrayWithArray:provinceArr];
        [picker reloadComponent:0];
        if (provinceArr.count != 0) {
            ProvinceModel *model = provinceArray[0];
            [weakself requestCityWith:model.id];
        }
    } andFaile:^(id error) {
        
    }];
}

-(void)requestCityWith:(int )cityId{
    __weak typeof(self) weakself = self;
    [ProvinceHttpManager requestCityWithId:[NSString stringWithFormat:@"%d",cityId] andWith:^(NSMutableArray *cityArr) {
        cityArray = [NSMutableArray arrayWithArray:cityArr];
        [picker reloadComponent:1];
        if (cityArray.count != 0) {
            CityModel *model = cityArray[0];
            [weakself requestAreaWith:model.id];
        }
    } andFaile:^(id error) {
        
    }];
}

-(void)requestAreaWith:(int )areaId{
    [ProvinceHttpManager requestCityWithId:[NSString stringWithFormat:@"%d",areaId] andWith:^(NSMutableArray *cityArr) {
        areaArray = [NSMutableArray arrayWithArray:cityArr];
        [picker reloadComponent:2];
    } andFaile:^(id error) {
        
    }];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if([touch.view isKindOfClass:[self class]]){
        return YES;
    }
    return NO;
}

-(void)tappedCancel{
    [UIView animateWithDuration:.25 animations:^{
        [downView setFrame:CGRectMake(0, kScreenHeight,kScreenWidth, 0)];
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished)
        {
            [self removeFromSuperview];
        }
    }];
}
- (void)showInView:(UIViewController *)Sview
{
    if(Sview==nil){
        [[UIApplication sharedApplication].delegate.window.rootViewController.view addSubview:self];
    }else{
        //[view addSubview:self];
        [Sview.view addSubview:self];
    }
}
@end
