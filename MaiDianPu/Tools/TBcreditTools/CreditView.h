//
//  CreditView.h
//  warenqi
//
//  Created by Mr.Lin. on 16/5/4.
//  Copyright © 2016年 Mr.Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^BlockCredit)(NSInteger credit);

@interface CreditView : UIView <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, copy) BlockCredit blockCredit;

@end
