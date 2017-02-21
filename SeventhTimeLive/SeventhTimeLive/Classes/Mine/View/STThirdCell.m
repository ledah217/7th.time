




//
//  STThirdCell.m
//  SeventhTimeLive
//
//  Created by 刘洋  on 17/2/17.
//  Copyright © 2017年 com.217.www.SeventhTimeLive. All rights reserved.
//

#import "STThirdCell.h"

@interface STThirdCell()

@end
@implementation STThirdCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self perpareUI];
    }
    return self;
}

-(void)perpareUI
{
    UIImageView *logoView = [[UIImageView alloc] init];
    logoView.image = [UIImage imageNamed:@"subscription"];
    [self.contentView addSubview:logoView];
    
    UILabel *verlabel = [[UILabel alloc] init];
    verlabel.text = @"夜间模式";
    [verlabel setTextColor:[UIColor darkGrayColor]];
    [verlabel setFont:[UIFont systemFontOfSize:10]];
    [verlabel setTextAlignment:NSTextAlignmentCenter];
    [self.contentView addSubview:verlabel];
    
    
    [logoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(5);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.height.mas_equalTo(20);
    }];
    
    [verlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(logoView.mas_right).offset(5);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
    UISwitch *switchView = [[UISwitch alloc] init];
    [self.contentView addSubview:switchView];
    [switchView setOn:NO animated:NO];
    [switchView addTarget:self action:@selector(switchClick:) forControlEvents:UIControlEventValueChanged];
    
    [switchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
}

-(void)switchClick:(UISwitch *)sender
{
    if ([sender isOn]) {
        self.dk_manager.themeVersion = DKThemeVersionNight;
    }
    else
    {
        self.dk_manager.themeVersion = DKThemeVersionNormal;
    }
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
