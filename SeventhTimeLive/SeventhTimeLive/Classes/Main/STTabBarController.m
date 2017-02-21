//
//  STTabBarController.m
//  SeventhTimeLive
//
//  Created by 刘洋  on 17/2/15.
//  Copyright © 2017年 com.217.www.SeventhTimeLive. All rights reserved.
//

#import "STTabBarController.h"

@interface STTabBarController ()

@end

@implementation STTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary *dic1 = @{@"vcName":@"STHomeController",@"title":@"首页",@"imgName":@"homepage"};
    NSDictionary *dic2 = @{@"vcName":@"STCategoryController",@"title":@"分类",@"imgName":@"category"};
    NSDictionary *dic3 = @{@"vcName":@"STSubscriptionController",@"title":@"订阅",@"imgName":@"subscription"};
    NSDictionary *dic4 = @{@"vcName":@"STMineController",@"title":@"我的",@"imgName":@"mine"};
    
    UIViewController *vc1 = [self createVcWithDict:dic1];
    UIViewController *vc2 = [self createVcWithDict:dic2];
    UIViewController *vc3 = [self createVcWithDict:dic3];
    UIViewController *vc4 = [self createVcWithDict:dic4];
    
    self.viewControllers = @[vc1,vc2,vc3,vc4];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//自定义方法创建控制器，字典传参
-(UIViewController *)createVcWithDict:(NSDictionary *)dict
{
    
    Class vcClass = NSClassFromString(dict[@"vcName"]);
    UIViewController *vc = [[vcClass alloc] init];
    UIView *tabView = [[UIView alloc] init];
    tabView.dk_backgroundColorPicker = DKColorPickerWithKey(TABV);
    tabView.frame = self.tabBar.bounds;
    [[UITabBar appearance] insertSubview:tabView atIndex:0];
    vc.tabBarController.tabBar.translucent = NO;
    vc.tabBarItem.title = dict[@"title"];
    vc.tabBarItem.image = [[UIImage imageNamed:[NSString stringWithFormat:@"menu_%@",dict[@"imgName"]]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"menu_%@_sel",dict[@"imgName"]]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UINavigationController *navVc = [[UINavigationController alloc] initWithRootViewController:vc];
    
    return navVc;
}

@end
