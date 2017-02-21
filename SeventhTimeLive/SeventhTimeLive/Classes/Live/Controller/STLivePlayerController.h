//
//  STLivePlayerController.h
//  SeventhTimeLive
//
//  Created by 刘洋  on 17/2/15.
//  Copyright © 2017年 com.217.www.SeventhTimeLive. All rights reserved.
//



/**
 视频播放器
 */

#import <UIKit/UIKit.h>
#import <IJKMediaFramework/IJKMediaFramework.h>
#import "STLivePlayerControl.h"
#import "STPandaLiveListModel.h"
#import "STZhanqiLiveListModel.h"
#import "STQuanMinLiveListModel.h"

@interface STLivePlayerController : UIViewController

//接收传进来的属性
@property(atomic,strong) NSURL *url;
@property (copy, nonatomic) NSString *liveTitle;
@property (strong, nonatomic) NSArray *roomList;
@property (strong, nonatomic) NSIndexPath *indexPath;

//关联播放器控制器
@property (strong, nonatomic) STLivePlayerControl *playerControl;

//ijkplayer对象
@property(atomic, retain) id<IJKMediaPlayback> player;



/**
 跳转视频播放控制器

 @param viewController 上级控制器
 @param liveTitle live_title
 @param url streamUrl
 @param roomList roomList数组
 @param indexPath indexPath
 @param completion Block块
 */
+ (void)presentFromViewController:(UIViewController *)viewController withLiveTitle:(NSString *)liveTitle URL:(NSURL *)url andRoomList:(NSArray *)roomList andIndexPath:(NSIndexPath *)indexPath completion:(void(^)())completion;

@end
