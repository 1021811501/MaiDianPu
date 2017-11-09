//
//  ViewController.h
//  MaiDianPu
//
//  Created by JasonLee on 2017/10/25.
//  Copyright © 2017年 JasonLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DGApiService.h"
@interface ViewController : DGBaseViewController<DGApiServiceDelegate>
@property (weak, nonatomic) IBOutlet UIButton *actionBtn;
@end

