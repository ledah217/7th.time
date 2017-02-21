//
//  STQuanMinLiveListModel.h
//  SeventhTimeLive
//
//  Created by 刘洋  on 17/2/15.
//  Copyright © 2017年 com.217.www.SeventhTimeLive. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STQuanMinLiveListModel : NSObject
/** 主播名 */
@property (copy, nonatomic) NSString *nick;
/** 缩略图 */
@property (copy, nonatomic) NSString *thumb;
/** 观众人数 */
@property (copy, nonatomic) NSString *view;
/** 直播名称 */
@property (copy, nonatomic) NSString *title;
/** 拉流地址 */
@property (copy, nonatomic) NSString *stream;
@end
