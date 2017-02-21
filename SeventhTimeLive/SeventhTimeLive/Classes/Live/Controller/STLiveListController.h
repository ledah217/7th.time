//
//  STLiveListController.h
//  SeventhTimeLive
//
//  Created by 刘洋  on 17/2/16.
//  Copyright © 2017年 com.217.www.SeventhTimeLive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STCategoryGameModel.h"
#import "STCategoryPlatformModel.h"

typedef enum : NSUInteger {
    PlatformTypeDouYu,
    PlatformTypeHuoMao,
    PlatformTypeZhanQi,
    PlatformTypeXiongMao,
    PlatformTypeHuYa,
    PlatformTypeQuanMin
} PlatformType;

typedef enum : NSUInteger {
    GameTypeDota2,
    GameTypeLoL,
    GameTypeHearthStone,
    GameTypeOW,
    GameTypeCSGO,
    GameTypeMobileLol,
    GameTypeCF,
    GameTypeWow,
    GameTypeOthers
} GameType;


@interface STLiveListController : UIViewController
@property (strong, nonatomic) STCategoryPlatformModel *platFormModel;
@property (strong, nonatomic) STCategoryGameModel *gameModel;
@property (nonatomic) int currentPage;
@property (nonatomic) int currentOffset;
//当前列表显示的位置
@property(nonatomic,assign) NSInteger index;

@property (weak, nonatomic) UICollectionView *liveListCollectionView;

- (void)configRefresh;
- (void)loadData;
@end
