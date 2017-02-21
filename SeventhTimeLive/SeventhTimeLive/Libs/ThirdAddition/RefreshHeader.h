//
//  RefreshHeader.h
//  半糖Refresh
//
//  Created by 刘洋  on 17/2/9.
//  Copyright © 2017年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+HeaderRefreshView.h"

@interface RefreshHeader : UIView
-(instancetype)initWithScrollView:(UIScrollView *)ScrollView;

- (void)stopRefreshing;
@end
