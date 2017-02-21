//
//  STZhanqiLiveListModel.h
//  SeventhTimeLive
//
//  Created by 刘洋  on 17/2/15.
//  Copyright © 2017年 com.217.www.SeventhTimeLive. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STZhanqiLiveListModel : NSObject
/** 主播名 */
@property (copy, nonatomic) NSString *nickname;
/** 直播名称 */
@property (copy, nonatomic) NSString *title;
/** 直播截图 */
@property (copy, nonatomic) NSString *bpic;
/** 观众人数 */
@property (copy, nonatomic) NSString *online;
/** 拉流地址 */
@property (copy, nonatomic) NSString *videoId;

@end
