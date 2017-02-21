//
//  STHomeController.m
//  SeventhTimeLive
//
//  Created by 刘洋  on 17/2/15.
//  Copyright © 2017年 com.217.www.SeventhTimeLive. All rights reserved.
//

#import "STHomeController.h"
#import "STNetworkManager.h"
#import "STHomeCell.h"
#import "STHomeRoomListModel.h"
#import "STLivePlayerController.h"
#import "UIImage+OYImage.h"
#import "RefreshHeader.h"


#define headH 124
#define headMinH 20
static NSString *homeTableViewCellIdentifier = @"homeTableViewCellIdentifier";

static NSString *homeCellID = @"cellID";
@interface STHomeController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property(nonatomic,strong) UITableView *tableView;
@property (strong, nonatomic) NSArray *roomList;
@property (weak, nonatomic) UILabel *nameLabel;
@property (weak, nonatomic) UIImageView *logoView;
@property (nonatomic, assign) CGFloat lastOffsetY;
@end

@implementation STHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadData];
    [self perpareUI];
    [self.tableView addRefreshHeader];
}

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

-(void)perpareUI
{
    //设置状态栏颜色
    UIView *statusBarBGC = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 20)];
    statusBarBGC.dk_backgroundColorPicker = DKColorPickerWithKey(SVBG);
    [self.view addSubview:statusBarBGC];
    

    
    UIImageView *logoView = [[UIImageView alloc] initWithFrame:CGRectMake(0,20, self.view.bounds.size.width, 124)];
    logoView.image = [UIImage imageNamed:@"logo"];
    self.logoView = logoView;
    [self.view addSubview:logoView];
    
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.text = @"小编优选";
    [nameLabel sizeToFit];
    self.navigationItem.titleView = nameLabel;
    self.nameLabel = nameLabel;
    nameLabel.alpha = 0;
    
    UITableView *tableView = [[UITableView alloc]init];
    self.tableView = tableView;
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.rowHeight = 200;
    [tableView registerClass:[STHomeCell class] forCellReuseIdentifier:homeTableViewCellIdentifier];
    [self.view insertSubview:tableView atIndex:0];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.view);
    }];

    
}
- (void)loadData {
    [[STNetworkManager sharedManager]getHomeRoomListWithCompletionHandler:^(id response) {
        self.roomList = response;
        [self.tableView reloadData];
    }];
}

#pragma mark - TableViewDataSource
//MARK:- UITableViewDataSource & UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.roomList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    STHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:homeTableViewCellIdentifier forIndexPath:indexPath];
    cell.roomListModel = self.roomList[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    STHomeRoomListModel *selectRoomModel = self.roomList[indexPath.row];
    NSString *liveType = selectRoomModel.live_type;
    NSString *liveId = selectRoomModel.live_id;
    NSString *liveName = selectRoomModel.live_title;
    [[STNetworkManager sharedManager]getHomeRoomWithLiveType:liveType andLiveId:liveId andCompletionHandler:^(NSURL *streamUrl) {
        [SVProgressHUD show];
        NSString *scheme = [[streamUrl scheme] lowercaseString];
        if ([scheme isEqualToString:@"http"]
            || [scheme isEqualToString:@"https"]
            || [scheme isEqualToString:@"rtmp"]) {
            [STLivePlayerController presentFromViewController:self withLiveTitle:liveName URL:streamUrl andRoomList:self.roomList andIndexPath:indexPath completion:^{
                [SVProgressHUD dismiss];
            }];
//            [STLivePlayerController presentFromViewController:self withTitle:liveName URL:streamUrl andRoomList:self.roomList andIndexPath:indexPath completion:^{
//                //            [self.navigationController popViewControllerAnimated:NO];
//                [SVProgressHUD dismiss];
//            }];
        }
    }];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    NSLog(@"%lf",offsetY)
    
    CGFloat alpha = ABS(offsetY / 104.0);
    if (offsetY > 0) {
        alpha = 0;
    }
    //NSLog(@"%lf",alpha)
    
    self.logoView.alpha = alpha;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
