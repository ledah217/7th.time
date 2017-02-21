//
//  STPandaLiveListModel.h
//  SeventhTimeLive
//
//  Created by 刘洋  on 17/2/15.
//  Copyright © 2017年 com.217.www.SeventhTimeLive. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STPandaLiveListModel : NSObject
/** 房间名 */
@property (copy, nonatomic) NSString *name;
/** 缩略图(key:img) */
@property (strong, nonatomic) NSDictionary *pictures;
/** 房间人数 */
@property (copy, nonatomic) NSString *person_num;
/** 主播名(key:nickName) */
@property (strong, nonatomic) NSDictionary *userinfo;
/** 房间id */
@property (nonatomic) NSInteger roomId;
@end
