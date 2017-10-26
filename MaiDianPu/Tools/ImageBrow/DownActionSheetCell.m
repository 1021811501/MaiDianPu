//
//  DownSheetCell.m
//  WaShiKe
//
//  Created by JasonLee on 17/1/10.
//  Copyright © 2017年 JasonLee. All rights reserved.
//

#import "DownActionSheetCell.h"

@implementation DownActionSheetCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.infoLabel = [[UILabel alloc]init];
        self.infoLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.infoLabel];
        self.selectionStyle = UITableViewCellSelectionStyleGray;
        self.infoLabel.frame = CGRectMake(0, 0, kScreenWidth, 43);
        self.infoLabel.font = [UIFont systemFontOfSize:17];
        self.infoLabel.textAlignment = NSTextAlignmentCenter;
        self.infoLabel.textColor = [UIColor blackColor];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if(selected){
        self.backgroundColor = [UIColor grayColor];
    }else{
        self.backgroundColor = [UIColor whiteColor];
        self.infoLabel.textColor = [UIColor blackColor];
    }

    // Configure the view for the selected state
}

@end
