//
//  STDouyuLiveListModel.h
//  SeventhTimeLive
//
//  Created by 刘洋  on 17/2/16.
//  Copyright © 2017年 com.217.www.SeventhTimeLive. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STDouyuLiveListModel : NSObject
/** 主播名 */
@property (copy, nonatomic) NSString *nickname;
/** 直播名称 */
@property (copy, nonatomic) NSString *room_name;
/** 直播截图 */
@property (copy, nonatomic) NSString *room_src;
/** 观众人数 */
@property (copy, nonatomic) NSString *online;
@end
