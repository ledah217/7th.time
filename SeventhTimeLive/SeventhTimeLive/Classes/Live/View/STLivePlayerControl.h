//
//  STLivePlayerControl.h
//  SeventhTimeLive
//
//  Created by 刘洋  on 17/2/15.
//  Copyright © 2017年 com.217.www.SeventhTimeLive. All rights reserved.
//

/**
 视频播放器控制器
 */

#import <UIKit/UIKit.h>
#import <IJKMediaFramework/IJKMediaFramework.h>
@class STLivePlayerController;

@interface STLivePlayerControl : UIControl
//关联视频播放器
@property (strong, nonatomic) STLivePlayerController *livePlayController;
//设置代理
@property (weak, nonatomic) id<IJKMediaPlayback> delegatePlayer;
//直播标题属性关联
@property (copy, nonatomic) NSString *liveTitle;
//子控件
@property (weak, nonatomic) UIView *overlayPanel;
@property (weak, nonatomic) UISlider *mediaProgressSlider;
@property (weak, nonatomic) UILabel *currentTimeLabel;
@property (weak, nonatomic) UIButton *playButton;
@property (weak, nonatomic) UIButton *pauseButton;
@property (weak, nonatomic) UILabel *liveTitleLabel;
@property (weak, nonatomic) UIButton *likeButton;




//重写init方法，关联视频播放器
- (instancetype)initWithLivePlayerVc:(STLivePlayerController *)livePlayerVc;

//需要视频播放器实现的代理方法
- (void)showAndFade;
- (void)hide;
- (void)refreshMediaControl;
- (void)volumeUp;
- (void)volumeDown;

@end
