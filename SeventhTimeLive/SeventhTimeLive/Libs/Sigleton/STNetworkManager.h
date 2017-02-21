//
//  STNetworkManager.h
//  SeventhTimeLive
//
//  Created by 刘洋  on 17/2/15.
//  Copyright © 2017年 com.217.www.SeventhTimeLive. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

typedef void(^RequestCallBack)(id respose,NSError *error);
typedef void(^SuccessCallBack)(id response);
typedef void(^StreamCallBack)(NSURL* streamUrl);

@interface STNetworkManager : AFHTTPSessionManager
//单例
+(instancetype)sharedManager;

/** 获取房间列表 */
- (void)getRoomListWithPlatformId:(int)platformId andGameId:(NSString *)gameName andPageNum:(int)pageNum andOffset:(int)offset andCompletionHandler:(SuccessCallBack)callBack;
/** 获取直播间 */
- (void)getRoomWithPlatformId:(int)platformId andRoomId:(int)roomId andVideoId:(NSString *)videoId andStreamUrl:(NSString *)streamUrl andCompletionHandler:(StreamCallBack)callBack;

/** 获取首页房间列表 */
- (void)getHomeRoomListWithCompletionHandler:(SuccessCallBack)callBack;
/** 获取首页直播间 */
- (void)getHomeRoomWithLiveType:(NSString *)liveType andLiveId:(NSString *)liveId andCompletionHandler:(StreamCallBack)callBack;

@end
