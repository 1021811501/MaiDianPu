//
//  DGTabbarController.m
//  MaiDianPu
//
//  Created by JasonLee on 2017/10/25.
//  Copyright © 2017年 JasonLee. All rights reserved.
//

#import "DGTabbarController.h"
#import "DGBaseNavigationController.h"
#import "DGTabbar.h"
#import "HomeViewController.h"
#import "BViewController.h"
#import "CViewController.h"
#import "DViewController.h"
@interface DGTabbarController ()

@end

@implementation DGTabbarController
+ (void)initialize
{
    UITabBarItem *tabBarItem = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];
    
    NSMutableDictionary *dictNormal = [NSMutableDictionary dictionary];
    dictNormal[NSForegroundColorAttributeName] = [UIColor grayColor];
    dictNormal[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    
    NSMutableDictionary *dictSelected = [NSMutableDictionary dictionary];
    dictSelected[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    dictSelected[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    
    [tabBarItem setTitleTextAttributes:dictNormal forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:dictSelected forState:UIControlStateSelected];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    [self addAllChildController];
    DGTabbar *tab = [[DGTabbar alloc] init];
    [self setValue:tab forKeyPath:@"tabBar"];
    // Do any additional setup after loading the view.
}
-(void)addAllChildController{
    HomeViewController *home = [[HomeViewController alloc] init];
    [self setUpControllerWith:home andNormalImage:@"account_normal" andSelectImage:@"account_highlight" andTitle:@"首页"];
    BViewController *b = [BViewController new];
    [self setUpControllerWith:b andNormalImage:@"fish_normal" andSelectImage:@"fish_highlight" andTitle:@"大厅"];
    CViewController *c = [CViewController new];
    [self setUpControllerWith:c andNormalImage:@"message_normal" andSelectImage:@"message_highlight" andTitle:@"我的"];
    DViewController *d = [DViewController new];
    [self setUpControllerWith:d andNormalImage:@"mycity_normal" andSelectImage:@"mycity_highlight" andTitle:@"个人中心"];
}
-(void)setUpControllerWith:(UIViewController *)VC andNormalImage:(NSString *)normalImage andSelectImage:(NSString *)selectImage andTitle:(NSString *)title{
    DGBaseNavigationController *nav = [[DGBaseNavigationController alloc] initWithRootViewController:VC];
    UIImage *myImage = [UIImage imageNamed:normalImage];
    myImage = [myImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    VC.tabBarItem.image = myImage;
    UIImage *mySelectedImage = [UIImage imageNamed:selectImage];
    mySelectedImage = [mySelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    VC.tabBarItem.selectedImage = mySelectedImage;
    VC.tabBarItem.title = title;
    [self addChildViewController:nav];
}
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    NSMutableArray *arr= [NSMutableArray arrayWithCapacity:0];
    for (int  i = 0; i< self.tabBar.subviews.count; i++) {
        UIView *btn = self.tabBar.subviews[i];
        if ([btn isKindOfClass:[NSClassFromString(@"UITabBarButton") class]]) {
            [arr addObject:btn];
        }
    }
    for (int  i = 0; i<arr.count; i++) {
        if (i == self.selectedIndex) {
            UIView *btn = arr[i];
            [UIView animateWithDuration:0.2 animations:^{
                for (UIView *view in btn.subviews) {
                    if ([view isKindOfClass:[NSClassFromString(@"UITabBarSwappableImageView") class]]) {
                        view.transform = CGAffineTransformMakeScale(1.2, 1.2);
                    }
                }
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.2 animations:^{
                    for (UIView *view in btn.subviews) {
                        if ([view isKindOfClass:[NSClassFromString(@"UITabBarSwappableImageView") class]]) {
                            view.transform = CGAffineTransformMakeScale(1.2, 1.2);
                            view.transform = CGAffineTransformIdentity;
                        }
                    }
                }];
            }];
        }
    }
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
