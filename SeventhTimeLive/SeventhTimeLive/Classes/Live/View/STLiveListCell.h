//
//  STLiveListCell.h
//  SeventhTimeLive
//
//  Created by 刘洋  on 17/2/16.
//  Copyright © 2017年 com.217.www.SeventhTimeLive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STPandaLiveListModel.h"
#import "STQuanMinLiveListModel.h"
#import "STZhanqiLiveListModel.h"
#import "STDouyuLiveListModel.h"
#import "STHuoMaoLiveListModel.h"

@interface STLiveListCell : UICollectionViewCell
@property (strong, nonatomic) STHuoMaoLiveListModel *huoMaoLiveListModel;
@property (strong, nonatomic) STPandaLiveListModel *pandaLiveListModel;
@property (strong, nonatomic) STZhanqiLiveListModel *zhanqiLiveListModel;
@property (strong, nonatomic) STQuanMinLiveListModel *quanminLiveListModel;
@property (strong, nonatomic) STDouyuLiveListModel *douyuLiveListModel;
@end
