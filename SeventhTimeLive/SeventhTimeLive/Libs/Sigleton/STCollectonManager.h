//
//  STCollectonManager.h
//  SeventhTimeLive
//
//  Created by 刘洋  on 17/2/17.
//  Copyright © 2017年 com.217.www.SeventhTimeLive. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STCollectonManager : NSObject
+ (instancetype)sharedManager;

- (void)addCollection:(id)liveModel;
- (void)cancleCollection:(NSString *)liveId;
- (void)getAllCollectionsWithPage:(NSInteger)page allCollectionsBlock:(void (^)(NSArray *collectionModelArr))block;
- (void)isCollected:(id)liveModel resultBlock:(void (^)(BOOL isCollected))resultBlock;
@end
