//
//  STCategoryListView.h
//  SeventhTimeLive
//
//  Created by 刘洋  on 17/2/15.
//  Copyright © 2017年 com.217.www.SeventhTimeLive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STCategoryGameModel.h"
#import "STCategoryPlatformModel.h"

@interface STCategoryListView : UIControl

@property(nonatomic,strong) STCategoryPlatformModel *modelList;

//记录当前哪个label被点击
@property(nonatomic,assign) NSInteger currentIndex;


@end
