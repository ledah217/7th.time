//
//  STThreePlatformView.h
//  SeventhTimeLive
//
//  Created by 刘洋  on 17/2/16.
//  Copyright © 2017年 com.217.www.SeventhTimeLive. All rights reserved.
//

#import <UIKit/UIKit.h>
@class STThreePlatformView;
@class STCategoryPlatformModel;

@protocol  STThreePlatformViewDelegate <NSObject>

@optional
-(void)threePlatformView:(STThreePlatformView *)threePlatformView withIndex:(NSUInteger )selectIndex;

@end

@interface STThreePlatformView : UIView
//接收首页传过来的滚动偏移
@property (nonatomic,assign) CGFloat offsetX;
//接收首页传来的模型数组
@property(nonatomic,strong) NSArray<STCategoryPlatformModel *> *platformList;
//代理
@property (nonatomic,weak) id<STThreePlatformViewDelegate> delegate;
@end
