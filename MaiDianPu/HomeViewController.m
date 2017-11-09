//
//  HomeViewController.m
//  MaiDianPu
//
//  Created by JasonLee on 2017/10/25.
//  Copyright © 2017年 JasonLee. All rights reserved.
//

#import "HomeViewController.h"
#import "LAViewController.h"
#import "UIDevice+DGUtility.h"
@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"点击进入下一个界面" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn addTarget: self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
//    btn.center = self.view.center;
//    btn.bounds = CGRectMake(0, 0, 80, 40);
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.dg_mas_safeAreaLayoutGuideLeft);
        make.right.equalTo(self.view.dg_mas_safeAreaLayoutGuideRight);
//        make.top.equalTo(self.view.dg_mas_safeAreaLayoutGuideTop).offset(80);
        make.top.equalTo(self.mas_topLayoutGuide);
        make.bottom.equalTo(self.view.dg_mas_safeAreaLayoutGuideBottom).offset(-180);
       
    }];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear: animated];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
-(void)action{
    [self.navigationController pushViewController:[LAViewController new] animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
