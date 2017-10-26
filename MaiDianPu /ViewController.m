//
//  ViewController.m
//  MaiDianPu
//
//  Created by JasonLee on 2017/10/25.
//  Copyright © 2017年 JasonLee. All rights reserved.
//

#import "ViewController.h"
#import "BViewController.h"
#import "DGTabbarController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)action:(id)sender {
//    [self.navigationController pushViewController:[BViewController new] animated:YES];
    self.view.window.rootViewController = [DGTabbarController new];
}
@end
