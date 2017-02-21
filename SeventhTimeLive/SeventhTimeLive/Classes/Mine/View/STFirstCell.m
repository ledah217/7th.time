//
//  STFirstCell.m
//  SeventhTimeLive
//
//  Created by 刘洋  on 17/2/17.
//  Copyright © 2017年 com.217.www.SeventhTimeLive. All rights reserved.
//

#import "STFirstCell.h"

@implementation STFirstCell
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
    logoView.image = [UIImage imageNamed:@"logo_no"];
    [self.contentView addSubview:logoView];
    
    UILabel *namelabel = [[UILabel alloc] init];
    namelabel.text = @"217丶";
    [namelabel setFont:[UIFont systemFontOfSize:10]];
    [namelabel setTextColor:[UIColor darkGrayColor]];
    [namelabel setTextAlignment:NSTextAlignmentCenter];
    [self.contentView addSubview:namelabel];
    
    UILabel *infolabel = [[UILabel alloc] init];
    infolabel.text = @"7th.time直播应用，感谢您的关注~";
    [infolabel setTextColor:[UIColor darkGrayColor]];
    [infolabel setFont:[UIFont systemFontOfSize:10]];
    [infolabel setTextAlignment:NSTextAlignmentCenter];
    [self.contentView addSubview:infolabel];
    
    UILabel *alterlabel = [[UILabel alloc] init];
    alterlabel.text = @"免责声明：直播流来源网络，版权归原作者所有，如涉及版权问题，请及时联系";
    [alterlabel setTextColor:[UIColor darkGrayColor]];
    [alterlabel setFont:[UIFont systemFontOfSize:8]];
    [alterlabel setTextAlignment:NSTextAlignmentCenter];
    [self.contentView addSubview:alterlabel];
    
    
    [logoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.top.equalTo(self.contentView.mas_top).offset(20);
        make.width.height.mas_equalTo(100);
    }];
    
    [namelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(logoView.mas_centerX);
        make.top.equalTo(logoView.mas_bottom).offset(5);
    }];
    
    [infolabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(namelabel.mas_centerX);
        make.top.equalTo(namelabel.mas_bottom).offset(5);
    }];
    
    [alterlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(infolabel.mas_centerX);
        make.top.equalTo(infolabel.mas_bottom).offset(5);
    }];
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
