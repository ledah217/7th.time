



//
//  STMineController.m
//  SeventhTimeLive
//
//  Created by 刘洋  on 17/2/15.
//  Copyright © 2017年 com.217.www.SeventhTimeLive. All rights reserved.
//

#import "STMineController.h"
#import "STFirstCell.h"
#import "STSecCell.h"
#import "STThirdCell.h"



static NSString *firstID = @"firstID";
static NSString *secID = @"secID";
static NSString *thirdID = @"thirdID";
@interface STMineController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation STMineController
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillDisappear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBarController.tabBar.translucent = NO;
    [self perpareUI];
}
-(void)perpareUI
{
    //设置状态栏颜色
    UIView *statusBarBGC = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width
                                                                    , 20)];
    [self.view addSubview:statusBarBGC];
    statusBarBGC.dk_backgroundColorPicker = DKColorPickerWithKey(SVBG);
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
    tableView.dk_backgroundColorPicker = DKColorPickerWithKey(TAB);
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[STFirstCell class] forCellReuseIdentifier:firstID];
    [tableView registerClass:[STSecCell class] forCellReuseIdentifier:secID];
    [tableView registerClass:[STThirdCell class] forCellReuseIdentifier:thirdID];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [tableView reloadData];
    [self.view addSubview:tableView];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section == 0) {
        return 1;
    }
    else if (section == 1)
    {
        return 1;
    }
    else
    {
        return 1;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        STFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:firstID forIndexPath:indexPath];
        cell.dk_backgroundColorPicker = DKColorPickerWithKey(CELL);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if (indexPath.section == 1) {
        STSecCell *cell = [tableView dequeueReusableCellWithIdentifier:secID forIndexPath:indexPath];
        cell.dk_backgroundColorPicker = DKColorPickerWithKey(CELL);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else
    {
        STThirdCell *cell = [tableView dequeueReusableCellWithIdentifier:thirdID forIndexPath:indexPath];
        cell.dk_backgroundColorPicker = DKColorPickerWithKey(CELL);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 200;
    }
    return 40;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
