//
//  STHuoMaoLiveListModel.m
//  SeventhTimeLive
//
//  Created by 刘洋  on 17/2/16.
//  Copyright © 2017年 com.217.www.SeventhTimeLive. All rights reserved.
//

#import "STHuoMaoLiveListModel.h"

@implementation STHuoMaoLiveListModel
// 返回一个 Dict，将 Model 属性名对映射到 JSON 的 Key。
// key:propertyName value:JsonKey
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"roomName" : @[@"channel"],
             @"imgName" : @[@"img"],
             @"userName" : @[@"username"],
             @"audienceCount" : @[@"views"],
             @"roomId" : @[@"cid"]};
}
@end
