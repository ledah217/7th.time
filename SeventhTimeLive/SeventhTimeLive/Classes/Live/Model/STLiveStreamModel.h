//
//  STLiveStreamModel.h
//  SeventhTimeLive
//
//  Created by 刘洋  on 17/2/15.
//  Copyright © 2017年 com.217.www.SeventhTimeLive. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STLiveStreamModel : NSObject
/** 超清流 */
@property (copy, nonatomic) NSString *tdStream;
/** 高清流 */
@property (copy, nonatomic) NSString *hdStream;
/** 标清流 */
@property (copy, nonatomic) NSString *sdStream;
/** 普清流 */
@property (copy, nonatomic) NSString *bdStream;
@end
