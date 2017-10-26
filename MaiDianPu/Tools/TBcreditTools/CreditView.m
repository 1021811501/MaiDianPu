//
//  CreditView.m
//  warenqi
//
//  Created by Mr.Lin. on 16/5/4.
//  Copyright © 2016年 Mr.Lin. All rights reserved.
//

#import "CreditView.h"

@implementation CreditView
{
    UITableView *_tableView;
    NSArray *_creditArray;
    UIView *_bottomView;
    UIButton *_btn;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _createCreditArray];
        [self _createBottomView];
        [self _createTableView];
        [self _show];
    }
    return self;
}

- (void)_createTableView{
    
    _btn = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - 210);
    [_btn addTarget:self action:@selector(compliteBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_btn];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 210 - 162,kScreenWidth, 162)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_bottomView addSubview:_tableView];
    
}

- (void)_createCreditArray{
    _creditArray = @[@"HEART_1",@"HEART_2",@"HEART_3",@"HEART_4",@"HEART_5",@"BRICK_1",@"BRICK_2",@"BRICK_3",@"BRICK_4",@"BRICK_5",@"CROWN_1",@"CROWN_2",@"CROWN_3",@"CROWN_4",@"CROWN_5"];
}

#pragma mark  UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 15;
}

- (void)_createBottomView{
    
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 210)];
    _bottomView.backgroundColor = [UIColor whiteColor];
    [self addSubview: _bottomView];
    float height = 50;
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.frame = CGRectMake(0, 0, height, height);
    [cancelBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(compliteBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:cancelBtn];
    
    UIButton *completeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [completeBtn setTitle:@"完成" forState:UIControlStateNormal];
    completeBtn.frame = CGRectMake(kScreenWidth - height, 0, height, height);
    [completeBtn addTarget:self action:@selector(compliteBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:completeBtn];
}

- (void)compliteBtnClick{
    [UIView animateWithDuration:.25 animations:^{
        self.backgroundColor = RGBA_COLOR(0, 0, 0, 0);
        [_bottomView setFrame:CGRectMake(0, kScreenHeight,kScreenWidth, 0)];
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

- (void)_show{
    [UIView animateWithDuration:.25 animations:^{
        self.backgroundColor = RGBA_COLOR(0, 0, 0, 0.5);
        [UIView animateWithDuration:.25 animations:^{
        [_bottomView setFrame:CGRectMake(0, kScreenHeight - 210,kScreenWidth, 210)];
        }];
    }];
}

- (void)setBlockCredit:(BlockCredit)blockCredit{
    if (_blockCredit != blockCredit) {
        _blockCredit = blockCredit;
    }
}

#pragma mark  UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"%@.gif",_creditArray[indexPath.row]]];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth / 2 - img.size.width / 2, 12, img.size.width, 16)];
    [imgView setImage:img];
    [cell.contentView addSubview:imgView];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld", indexPath.row);
    
    if (_blockCredit) {
        _blockCredit(indexPath.row);
    }
    
    [self compliteBtnClick];
}

@end
