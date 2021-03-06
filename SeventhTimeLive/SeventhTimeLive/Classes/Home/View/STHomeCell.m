//
//  STHomeCell.m
//  SeventhTimeLive
//
//  Created by 刘洋  on 17/2/17.
//  Copyright © 2017年 com.217.www.SeventhTimeLive. All rights reserved.
//

#import "STHomeCell.h"
#import <UIImageView+WebCache.h>
@interface STHomeCell()

@property (weak, nonatomic) UIImageView *liveImageView;
@property (weak, nonatomic) UILabel *liveNameLabel;
@property (weak, nonatomic) UIImageView *iconView;
@property (weak, nonatomic) UILabel *userNameLabel;

@end
@implementation STHomeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUI];
    }
    return self;
}

- (void)setRoomListModel:(STHomeRoomListModel *)roomListModel {
    _roomListModel = roomListModel;
    [self.liveImageView sd_setImageWithURL:[NSURL URLWithString:roomListModel.live_img]];
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:roomListModel.live_userimg]];
    self.liveNameLabel.text = roomListModel.live_title;
    self.userNameLabel.text = roomListModel.live_nickname;
}

- (void)setUI {
    UIImageView *liveImageView = [[UIImageView alloc]init];
    self.liveImageView = liveImageView;
    liveImageView.image = [UIImage imageNamed:@"loading"];
    [self.contentView addSubview:liveImageView];
    
    UIView *overLayView = [[UIView alloc]init];
    overLayView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    [self.contentView addSubview:overLayView];
    
    UILabel *liveNameLabel = [[UILabel alloc]init];
    self.liveNameLabel = liveNameLabel;
    liveNameLabel.font = [UIFont fontWithName:@"FZLTZCHJW--GB1-0" size:16];
    liveNameLabel.text = @"暴雨将至的山间骑行";
    liveNameLabel.textColor = [UIColor whiteColor];
    liveNameLabel.textAlignment = NSTextAlignmentCenter;
    [overLayView addSubview:liveNameLabel];
    
    UIImageView *iconView = [[UIImageView alloc]init];
    self.iconView = iconView;
    iconView.image = [UIImage imageNamed:@"dota2"];
    iconView.layer.cornerRadius = 10;
    iconView.layer.masksToBounds = YES;
    [overLayView addSubview:iconView];
    
    UILabel *separateLabel = [[UILabel alloc]init];
    separateLabel.text = @"/";
    separateLabel.textColor = [UIColor whiteColor];
    [overLayView addSubview:separateLabel];
    
    UILabel *userNameLabel = [[UILabel alloc]init];
    self.userNameLabel = userNameLabel;
    userNameLabel.text = @"小满";
    userNameLabel.textColor = [UIColor whiteColor];
    userNameLabel.font = [UIFont systemFontOfSize:10];
    [overLayView addSubview:userNameLabel];
    
    //MARK:- autoLayout
    [liveImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    [overLayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    [liveNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView).offset(-20);
        make.centerX.equalTo(self.contentView);
    }];
    
    [separateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView).offset(10);
        make.centerX.equalTo(self.contentView);
    }];
    
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(separateLabel);
        make.right.equalTo(separateLabel.mas_left).offset(-5);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    [userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(separateLabel);
        make.left.equalTo(separateLabel.mas_right).offset(5);
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
