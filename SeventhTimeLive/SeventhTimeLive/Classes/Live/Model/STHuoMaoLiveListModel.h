//
//  STHuoMaoLiveListModel.h
//  SeventhTimeLive
//
//  Created by 刘洋  on 17/2/16.
//  Copyright © 2017年 com.217.www.SeventhTimeLive. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STHuoMaoLiveListModel : NSObject
/** 房间名 */
@property (copy, nonatomic) NSString *roomName;
/** 房间缩略图 */
@property (copy, nonatomic) NSString *imgName;
/** 主播名 */
@property (copy, nonatomic) NSString *userName;
/** 观众人数 */
@property (copy, nonatomic) NSString *audienceCount;
/** 房间id */
@property (nonatomic) NSInteger roomId;
@end
