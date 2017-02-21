//
//  STLivePlayerController.m
//  SeventhTimeLive
//
//  Created by 刘洋  on 17/2/15.
//  Copyright © 2017年 com.217.www.SeventhTimeLive. All rights reserved.
//

#import "STLivePlayerController.h"
#import "AppDelegate.h"
#import "STNetworkManager.h"
#import "STCollectonManager.h"


@interface STLivePlayerController ()

@end

@implementation STLivePlayerController
#pragma mark - 执行通知方法，准备播放
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self installMovieNotificationObservers];
    [self.player prepareToPlay];
}

#pragma mark - 移除通知方法，结束播放
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.player shutdown];
    [self removeMovieNotificationObservers];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self perparePlayerUI];
    [self perparePlayerControlUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 创建播放器
-(void)perparePlayerUI
{
    //横屏切换
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appdelegate.allowRotation = 1;
    
    //根据当前环境设置日志报告
    //如果是debug状态
    #ifdef DEBUG
        //设置报告日志，级别为Debug
        [IJKFFMoviePlayerController setLogReport:YES];
        [IJKFFMoviePlayerController setLogLevel:k_IJK_LOG_DEBUG];
    #else
        //否则不报告，设置日志级别为信息
        [IJKFFMoviePlayerController setLogReport:NO];
        [IJKFFMoviePlayerController setLogLevel:k_IJK_LOG_INFO];
    #endif
    
    //检测版本是否匹配
    [IJKFFMoviePlayerController checkIfFFmpegVersionMatch:YES];
    
    //默认选项配置
    IJKFFOptions *options = [IJKFFOptions optionsByDefault];
    
    //创建播放器
    self.player = [[IJKFFMoviePlayerController alloc] initWithContentURL:self.url withOptions:options];
    
    //设置视频视图大小
    self.player.view.frame = self.view.bounds;
    
    //设置适配屏幕
    self.player.view.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    
    //设置播放视图的缩放模式
    self.player.scalingMode = IJKMPMovieScalingModeAspectFit;
    
    //自动播放
    self.player.shouldAutoplay = YES;
    
    //自动更新子视图大小
    self.view.autoresizesSubviews = YES;
    
    //添加子视图
    [self.view addSubview:self.player.view];
    
}

#pragma mark - 创建播放器控制器
-(void)perparePlayerControlUI
{
    //创建播放器控制器
    STLivePlayerControl *playerControl = [[STLivePlayerControl alloc]initWithLivePlayerVc:self];
    self.playerControl = playerControl;
    
    //设置代理
    playerControl.delegatePlayer = self.player;
    playerControl.liveTitle = self.liveTitle;
    [self.view addSubview:playerControl];
    [playerControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [[STCollectonManager sharedManager]isCollected:self.roomList[self.indexPath.item] resultBlock:^(BOOL isCollected) {
        playerControl.likeButton.selected = isCollected;
    }];
    
}

#pragma mark - 实现接口类方法
+(void)presentFromViewController:(UIViewController *)viewController withLiveTitle:(NSString *)liveTitle URL:(NSURL *)url andRoomList:(NSArray *)roomList andIndexPath:(NSIndexPath *)indexPath completion:(void (^)())completion
{
    [viewController presentViewController:[[self alloc] initWithUrl:url andLiveTitle:liveTitle andRoomList:roomList andIndexPath:indexPath]animated:YES completion:completion];
}

#pragma mark - 重写init方法将成员属性关联
-(instancetype)initWithUrl:(NSURL *)url andLiveTitle:(NSString *)liveTitle andRoomList:(NSArray *)roomList andIndexPath:(NSIndexPath *)indexPath
{
    if (self = [super init]) {
        self.url = url;
        self.liveTitle = liveTitle;
        self.roomList = roomList;
        self.indexPath = indexPath;
    }
    return self;
}

#pragma mark - 实现视频播放控制器代理方法
- (void)onClickPlayerControl {
    [self.playerControl showAndFade];
}

- (void)onClickOverlayPanel {
    [self.playerControl hide];
}

- (void)onClickPlay {
    [self.player play];
}

- (void)onClickPause {
    [self.player pause];
}

- (void)onClickVolumnUp {
    [self.playerControl volumeUp];
}

- (void)onClickVolumnDown{
    [self.playerControl volumeDown];
}

//没写
- (void)onClickLike {
    self.playerControl.likeButton.selected = !self.playerControl.likeButton.selected;
    id liveModel = self.roomList[self.indexPath.item];
    NSString *live_id = [[NSString alloc]init];
    if ([liveModel isKindOfClass:[STZhanqiLiveListModel class]]) {
        STZhanqiLiveListModel *zhanqiLiveModel = liveModel;
        live_id = zhanqiLiveModel.title;
    }else if ([liveModel isKindOfClass:[STPandaLiveListModel class]]) {
        STPandaLiveListModel *pandaLiveModel = liveModel;
        live_id = pandaLiveModel.userinfo[@"nickName"];
    }else if ([liveModel isKindOfClass:[STQuanMinLiveListModel class]]){
        STQuanMinLiveListModel *quanMinLiveModel = liveModel;
        live_id = quanMinLiveModel.title;
    }
    if (self.playerControl.likeButton.selected) {
        [[STCollectonManager sharedManager]addCollection:liveModel];
    }else {
        [[STCollectonManager sharedManager]cancleCollection:live_id];
    }
}

#pragma mark - 自动旋屏
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}

#pragma mark - 如果视频出现问题，直接dismiss当前控制器
- (void)onClickBack {
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appdelegate.allowRotation = 0;
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 获取视频状态
- (void)moviePlayBackDidFinish:(NSNotification*)notification
{
    int reason = [[[notification userInfo] valueForKey:IJKMPMoviePlayerPlaybackDidFinishReasonUserInfoKey] intValue];
    
    switch (reason)
    {
        case IJKMPMovieFinishReasonPlaybackEnded:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackEnded: %d\n", reason);
            break;
            
        case IJKMPMovieFinishReasonUserExited:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonUserExited: %d\n", reason);
            break;
            
        case IJKMPMovieFinishReasonPlaybackError:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackError: %d\n", reason);
            [SVProgressHUD showWithStatus:@"很抱歉，该平台数据暂无，程序员正在紧张抓取数据中..."];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self onClickBack];
                [SVProgressHUD dismiss];
            });
            break;
    }
}

#pragma mark - 监听通知
-(void)installMovieNotificationObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:IJKMPMoviePlayerPlaybackDidFinishNotification
                                               object:_player];
}

#pragma mark - 移除通知
-(void)removeMovieNotificationObservers
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMoviePlayerPlaybackDidFinishNotification object:_player];
}

@end
