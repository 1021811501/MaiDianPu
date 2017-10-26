//
//  TagExplainCell.m
//  WaShiKe
//
//  Created by JasonLee on 17/3/24.
//  Copyright © 2017年 JasonLee. All rights reserved.
//

#import "TagExplainCell.h"

@implementation TagExplainCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)createView{
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = HexColor(@"333333", 1);
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15 + 4 + 5);
        make.top.mas_equalTo(25);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(100);
    }];
    UIView *pointView = [[UIView alloc] init];
    pointView.backgroundColor = HexColor(@"ca242f", 1);
    pointView.layer.cornerRadius = 2;
    [self.contentView addSubview:pointView];
    kWeakSelf
    [pointView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.width.height.mas_equalTo(4);
        make.centerY.equalTo(weakself.titleLabel.mas_centerY);
    }];
    
    self.contentLabel = [[UILabel alloc] init];
    self.contentLabel.textColor = HexColor(@"7f7f7f", 1);
    self.contentLabel.font = [UIFont systemFontOfSize:13];
    self.contentLabel.numberOfLines = 0;
    [self.contentView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.titleLabel.mas_left);
        make.right.mas_equalTo(-15);
        make.top.equalTo(weakself.titleLabel.mas_bottom).offset(10);
        make.bottom.mas_equalTo(-5);
    }];
}

-(void)updateCellWithTitle:(NSString *)title andContent:(NSString *)content{
    self.titleLabel.text = title;
    self.contentLabel.text = content;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
