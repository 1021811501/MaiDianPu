//
//  HomeViewController.m
//  MaiDianPu
//
//  Created by JasonLee on 2017/10/25.
//  Copyright © 2017年 JasonLee. All rights reserved.
//

#import "HomeViewController.h"
#import "LAViewController.h"
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
    btn.center = self.view.center;
    btn.bounds = CGRectMake(0, 0, 80, 40);
    // Do any additional setup after loading the view.
}
-(void)action{
    [self.navigationController pushViewController:[LAViewController new] animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
