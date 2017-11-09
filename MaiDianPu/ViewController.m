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
#import "DGApiRequest.h"
#import "DGApiService.h"
#import "UIViewController+DGUtility.h"
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
//    DGApiRequest *request = [DGApiRequest requestForLoginInWithNick:@"13298330219" andPassWord:@"111111"];
//    [[DGApiService serviceWithDelegate:self] sendJSONRequest:request];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
}
@end
