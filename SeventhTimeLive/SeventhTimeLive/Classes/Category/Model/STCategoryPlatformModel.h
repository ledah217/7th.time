//
//  STCategoryPlatformModel.h
//  SeventhTimeLive
//
//  Created by 刘洋  on 17/2/15.
//  Copyright © 2017年 com.217.www.SeventhTimeLive. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STCategoryGameModel.h"

@interface STCategoryPlatformModel : NSObject
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *bannerpic;
@property (nonatomic) NSInteger platformid;

@property (strong, nonatomic) NSArray<STCategoryGameModel *> *categories;
@end
