//
//  LZSProgressView.h
//  warenqi
//
//  Created by 李志帅 on 16/8/5.
//  Copyright © 2016年 Mr.Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LZSProgressView : UIView
@property(nonatomic,strong)UIView *progressView;
@property(nonatomic,assign)float progress;
-(id)initWithWidth:(float)width andHeight:(float)height;
@end
