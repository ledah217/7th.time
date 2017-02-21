//
//  STLivePlayerControl.m
//  SeventhTimeLive
//
//  Created by 刘洋  on 17/2/15.
//  Copyright © 2017年 com.217.www.SeventhTimeLive. All rights reserved.
//

#import "STLivePlayerControl.h"

@implementation STLivePlayerControl
{
    UIProgressView *_volumeProgressView;
}

#pragma mark - 重写init方法关联视频播放器
-(instancetype)initWithLivePlayerVc:(STLivePlayerController *)livePlayerVc
{
    if (self = [super init]) {
        self.livePlayController = livePlayerVc;
        [self perparePlayerControlUI];
        [self refreshMediaControl];
        [self hide];
    }
    return self;
}

//set方法赋值
-(void)setLiveTitle:(NSString *)liveTitle
{
    _liveTitle = liveTitle;
    self.liveTitleLabel.text = self.liveTitle;
}

#pragma mark - 播放器控制器UI
-(void)perparePlayerControlUI
{
    //全屏点击显示
    [self addTarget:self.livePlayController action:@selector(onClickPlayerControl) forControlEvents:UIControlEventTouchDown];
    
    //视频播放控制器创建，设置点击渐隐方法
    UIControl *overlayPanel = [[UIControl alloc]init];
    [overlayPanel addTarget:self.livePlayController action:@selector(onClickOverlayPanel) forControlEvents:UIControlEventTouchDown];
    overlayPanel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    self.overlayPanel = overlayPanel;
    [self addSubview:overlayPanel];
    
    //开始按钮
    UIButton *playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [playButton addTarget:self.livePlayController action:@selector(onClickPlay) forControlEvents:UIControlEventTouchUpInside];
    self.playButton = playButton;
    [playButton setImage:[UIImage imageNamed:@"btn_play"] forState:UIControlStateNormal];
    [overlayPanel addSubview:playButton];
    
    //暂停按钮
    UIButton *pauseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [pauseButton addTarget:self.livePlayController action:@selector(onClickPause) forControlEvents:UIControlEventTouchUpInside];
    self.pauseButton = pauseButton;
    [pauseButton setImage:[UIImage imageNamed:@"btn_pause"] forState:UIControlStateNormal];
    [overlayPanel addSubview:pauseButton];
    
    //音量控件
    UIProgressView *volumeProgressView = [[UIProgressView alloc]init];
    _volumeProgressView = volumeProgressView;
    volumeProgressView.transform = CGAffineTransformMakeRotation(-M_PI_2);
    [_volumeProgressView setProgress:self.delegatePlayer.playbackVolume / 12.0];
    volumeProgressView.trackTintColor = [UIColor lightGrayColor];
    volumeProgressView.progressTintColor = [UIColor whiteColor];
    [overlayPanel addSubview:volumeProgressView];
    
    UIButton *volumeUpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [volumeUpButton addTarget:self.livePlayController action:@selector(onClickVolumnUp) forControlEvents:UIControlEventTouchUpInside];
    [volumeUpButton setImage:[UIImage imageNamed:@"Action_Volume+_44x44_"] forState:UIControlStateNormal];
    [overlayPanel addSubview:volumeUpButton];
    
    UIButton *volumeDownButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [volumeDownButton addTarget:self.livePlayController action:@selector(onClickVolumnDown) forControlEvents:UIControlEventTouchUpInside];
    [volumeDownButton setImage:[UIImage imageNamed:@"Action_Volume-_44x44_"] forState:UIControlStateNormal];
    [overlayPanel addSubview:volumeDownButton];

    //正在直播
    UILabel *currentTimeLabel = [[UILabel alloc]init];
    currentTimeLabel.font = [UIFont systemFontOfSize:12];
    currentTimeLabel.text = @"正在直播";
    currentTimeLabel.textColor = [UIColor whiteColor];
    [overlayPanel addSubview:currentTimeLabel];
    
    //总计时间
    UILabel *totalTimeLabel = [[UILabel alloc]init];
    self.currentTimeLabel = totalTimeLabel;
    totalTimeLabel.font = [UIFont systemFontOfSize:12];
    totalTimeLabel.textColor = [UIColor whiteColor];
    totalTimeLabel.text = @"01:02";
    [overlayPanel addSubview:totalTimeLabel];
    
    //返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton addTarget:self.livePlayController action:@selector(onClickBack) forControlEvents:UIControlEventTouchUpInside];
    [backButton setImage:[UIImage imageNamed:@"Action_backward_white_44x44_"] forState:UIControlStateNormal];
    [overlayPanel addSubview:backButton];
    
    //直播间名字
    UILabel *liveTitleLabel = [[UILabel alloc]init];
    self.liveTitleLabel = liveTitleLabel;
    liveTitleLabel.font = [UIFont systemFontOfSize:14];
    liveTitleLabel.textColor = [UIColor whiteColor];
    [overlayPanel addSubview:liveTitleLabel];
    
    //收藏按钮
    UIButton *likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.likeButton = likeButton;
    [likeButton addTarget:self.livePlayController action:@selector(onClickLike) forControlEvents:UIControlEventTouchUpInside];
    [likeButton setImage:[UIImage imageNamed:@"action_ic_like_27x24_"] forState:UIControlStateNormal];
    [likeButton setImage:[UIImage imageNamed:@"action_ic_liked_27x24_"] forState:UIControlStateSelected];
    [overlayPanel addSubview:likeButton];
    
    //截屏按钮
    UIButton *screenShotButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [screenShotButton setImage:[UIImage imageNamed:@"Action_Screenshots_44x44_"] forState:UIControlStateNormal];
    [overlayPanel addSubview:screenShotButton];

    //高清图标
    UIButton *sharpnessSelectedButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [sharpnessSelectedButton setImage:[UIImage imageNamed:@"Action_HD_44x44_"] forState:UIControlStateNormal];
    [overlayPanel addSubview:sharpnessSelectedButton];
    
    //约束
    [overlayPanel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];

    [playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(overlayPanel);
    }];
    
    [pauseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(overlayPanel);
    }];
    
    [volumeProgressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(overlayPanel);
        make.left.equalTo(overlayPanel).offset(-25);
        make.size.mas_equalTo(CGSizeMake(100, 3));
    }];
    
    [volumeUpButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(volumeProgressView.mas_top).offset(-45);
        make.centerX.equalTo(volumeProgressView);
    }];
    
    [volumeDownButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(volumeProgressView.mas_bottom).offset(45);
        make.centerX.equalTo(volumeProgressView);
    }];

    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(overlayPanel).offset(8);
        make.top.equalTo(overlayPanel).offset(5);
    }];
    
    [liveTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backButton.mas_right).offset(5);
        make.centerY.equalTo(backButton);
    }];
    
    [likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(overlayPanel).offset(-16);
        make.centerY.equalTo(liveTitleLabel);
        make.size.mas_equalTo(CGSizeMake(18, 16));
    }];
    
    [screenShotButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(likeButton.mas_left).offset(-8);
        make.centerY.equalTo(likeButton);
    }];
    
    [sharpnessSelectedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(screenShotButton.mas_left).offset(-5);
        make.centerY.equalTo(screenShotButton);
    }];

}

#pragma mark - 按键点击触发事件
//显示然后延迟隐藏
- (void)showNoFade
{
    self.overlayPanel.hidden = NO;
    [self cancelDelayedHide];
    [self refreshMediaControl];
}
//显示然后延迟隐藏
- (void)showAndFade
{
    [self showNoFade];
    [self performSelector:@selector(hide) withObject:nil afterDelay:5];
}
//隐藏
- (void)hide
{
    self.overlayPanel.hidden = YES;
    [self cancelDelayedHide];
}

- (void)cancelDelayedHide
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hide) object:nil];
}
//音量增大
- (void)volumeUp {
    if (self.delegatePlayer.playbackVolume > 12.0f) {
        return;
    }
    self.delegatePlayer.playbackVolume += 0.1;
    float currentVolume = self.delegatePlayer.playbackVolume;
    [_volumeProgressView setProgress:currentVolume / 12.0 animated:YES];
}
//音量减小
- (void)volumeDown {
    if (self.delegatePlayer.playbackVolume< 0.0f) {
        return;
    }
    self.delegatePlayer.playbackVolume -= 0.1;
    [_volumeProgressView setProgress:self.delegatePlayer.playbackVolume / 12.0 animated:YES];
}

- (void)refreshMediaControl
{
    // status
    BOOL isPlaying = [self.delegatePlayer isPlaying];
    self.playButton.hidden = isPlaying;
    self.pauseButton.hidden = !isPlaying;
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(refreshMediaControl) object:nil];
    if (!self.overlayPanel.hidden) {
        [self performSelector:@selector(refreshMediaControl) withObject:nil afterDelay:0.5];
    }
}

//避免警告，空写
- (void)onClickPlayerControl{}
- (void)onClickBack{}
- (void)onClickPlay{}
- (void)onClickPause{}
- (void)onClickNext{}
- (void)onClickOverlayPanel{}
- (void)onClickVolumnUp{}
- (void)onClickVolumnDown{}
- (void)onClickLike{}
@end
