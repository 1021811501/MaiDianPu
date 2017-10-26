//
//  TagExplain.m
//  WaShiKe
//
//  Created by JasonLee on 17/3/24.
//  Copyright © 2017年 JasonLee. All rights reserved.
//

#import "TagExplain.h"

@implementation TagExplain
{
    float totalHeight;
}
-(instancetype)initWithFrame:(CGRect)frame andTitleArray:(NSArray *)titleArray andContentArray:(NSArray *)contentArray{
    self = [super initWithFrame:frame];
    if (self) {
        [self.titleArray addObjectsFromArray:titleArray];
        [self.contentArray addObjectsFromArray:contentArray];
        self.backgroundColor = HexColor(@"333333", 0);
        [self createView];
        [self appearAnimation];
    }
    return self;
}
-(void)createView{
    self.table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.table registerClass:[TagExplainCell class] forCellReuseIdentifier:@"TagExplainCell"];
    self.table.tableFooterView = [UIView new];
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.table];
    self.table.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 0);
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [tableView fd_heightForCellWithIdentifier:@"TagExplainCell" configuration:^(id cell) {
         [cell updateCellWithTitle:self.titleArray[indexPath.row] andContent:self.contentArray[indexPath.row]];
    }];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TagExplainCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TagExplainCell" forIndexPath:indexPath];
    [cell updateCellWithTitle:self.titleArray[indexPath.row] andContent:self.contentArray[indexPath.row]];
    return cell;
}
- (void)showInView:(UIViewController *)Sview
{
    if(Sview==nil){
        [[UIApplication sharedApplication].delegate.window.rootViewController.view addSubview:self];
    }else{
        [Sview.view addSubview:self];
    }
}
-(void)appearAnimation{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedCancel)];
    [self addGestureRecognizer:tapGesture];
    tapGesture.delegate = self;
    for (int i = 0; i < self.contentArray.count; i++) {
        float height = [self.table fd_heightForCellWithIdentifier:@"TagExplainCell" configuration:^(id cell) {
            [cell updateCellWithTitle:self.titleArray[i] andContent:self.contentArray[i]];
        }];
        totalHeight = totalHeight + height;
    }
    if (totalHeight > kScreenHeight/2.0 + 100) {
        totalHeight = kScreenHeight/2.0 + 100;
    }
        [UIView animateWithDuration:.25 animations:^{
             self.backgroundColor = HexColor(@"333333", 0.5);
            [self.table setFrame:CGRectMake(0, kScreenHeight-totalHeight, kScreenHeight, totalHeight)];
        }];
}
-(void)tappedCancel{
    [UIView animateWithDuration:0.25 animations:^{
        self.table.frame = CGRectMake(0, kScreenHeight, kScreenWidth, totalHeight);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            self.backgroundColor = HexColor(@"333333", 0);
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }];
}
-(NSMutableArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _titleArray;
}
-(NSMutableArray *)contentArray{
    if (!_contentArray) {
        _contentArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _contentArray;
}


@end
