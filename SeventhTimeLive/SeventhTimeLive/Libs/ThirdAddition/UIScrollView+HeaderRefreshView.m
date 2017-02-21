//
//  UIScrollView+HeaderRefreshView.m
//  半糖Refresh
//
//  Created by 刘洋  on 17/1/17.
//  Copyright © 2017年 itheima. All rights reserved.
//

#import "UIScrollView+HeaderRefreshView.h"
#import "RefreshHeader.h"
#import <objc/runtime.h>


//定义关联对象的关键字
static char UIScrollViewHeaderRefreshView;
static char HeaderRerfreshViewHeight;

@implementation UIScrollView (HeaderRefreshView)


-(void)setHeader:(RefreshHeader *)header
{
    objc_setAssociatedObject(self, @selector(header), header, OBJC_ASSOCIATION_ASSIGN);
}

-(RefreshHeader *)header
{
    return objc_getAssociatedObject(self, @selector(header));
}


-(void)addRefreshHeader
{
    self.header = [[RefreshHeader alloc] initWithScrollView:self];
    [self insertSubview:self.header atIndex:0];
}

















////运行时 —— 对象关联
////为“UIScrollView分类”添加动态成员属性
//
////刷新页set方法
//-(void)setHeaderRefreshView:(HeaderRefreshView *)headerRefreshView
//{
//    objc_setAssociatedObject(self, &UIScrollViewHeaderRefreshView, headerRefreshView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//
////刷新页get方法
//-(HeaderRefreshView *)headerRefreshView
//{
//    return objc_getAssociatedObject(self, &UIScrollViewHeaderRefreshView);
//}
//
////下拉刷新页高的set方法
//-(void)setHeaderRefreshViewHeight:(CGFloat)headerRefreshViewHeight
//{
//    //下拉刷新的高0或默认高度
//    objc_setAssociatedObject(self, &HeaderRerfreshViewHeight, @(MAX(0,HeaderRerfreshViewHeight)), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//
//-(CGFloat)headerRefreshViewHeight
//{
//    //考虑到不同平台下CGFLOAT的类型，64位是double类型，剩下是float类型
//#if CGFLOAT_IS_DOUBLE
//    return [objc_getAssociatedObject(self, &HeaderRerfreshViewHeight) doubleValue];
//#else
//    return [objc_getAssociatedObject(self, &HeaderRerfreshViewHeight) doubleValue];
//#endif
//}
//
//
///**
// 添加刷新
// 此方法用于动画时Block回调刷新代码
// */

@end
