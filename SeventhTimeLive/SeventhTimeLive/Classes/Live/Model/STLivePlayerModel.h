//
//  STLivePlayerModel.h
//  SeventhTimeLive
//
//  Created by 刘洋  on 17/2/15.
//  Copyright © 2017年 com.217.www.SeventhTimeLive. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STLiveStreamModel.h"

@interface STLivePlayerModel : NSObject
/** 拉流地址数组 */
@property (strong, nonatomic) NSArray<STLiveStreamModel *> *liveStreamList;
@end
