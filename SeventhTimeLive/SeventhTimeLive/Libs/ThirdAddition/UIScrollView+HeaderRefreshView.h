//
//  UIScrollView+HeaderRefreshView.h
//  半糖Refresh
//
//  Created by 刘洋  on 17/1/17.
//  Copyright © 2017年 itheima. All rights reserved.
//

/**
 下拉刷新HeaderView
 */

#import <UIKit/UIKit.h>



//重命名定义block代码块ActionHandler
typedef void(^ActionHandler) (void);

@class RefreshHeader;

@interface UIScrollView (HeaderRefreshView)



@property (nonatomic, strong) RefreshHeader * header;


-(void)addRefreshHeader;




////headerRefreshView下拉刷新的高 - 默认是80
//@property(nonatomic,assign) CGFloat headerRefreshViewHeight;
//
////定义下拉headerRefreshView
//@property(nonatomic,strong) HeaderRefreshView *headerRefreshView;
//
//
//
///**
// 添加刷新
// 此方法用于动画时Block回调刷新代码
// 
// @param navBool 这里判断有无导航栏（NavigationController）
//               Demo是直接用ViewController上加TableView做的
//               所以要么TableView置顶屏幕，要么TableView上面还有导航栏
//               有导航栏，用于判断的Offset初始高度就是64了
// @param actionHandler 回调
// */
//-(void)addHeaderRefreshWithNavBool:(BOOL)navBool andActionHandler:(ActionHandler)actionHandler;



@end





