//
//  STSubscriptionController.m
//  SeventhTimeLive
//
//  Created by 刘洋  on 17/2/15.
//  Copyright © 2017年 com.217.www.SeventhTimeLive. All rights reserved.
//

#import "STSubscriptionController.h"
#import "STCollectonManager.h"
#import "STLiveListCell.h"
#import "STNetworkManager.h"
#import "STLivePlayerController.h"
#import <MJRefresh.h>


static NSString *liveListCollectionViewCellIdentifer = @"liveListCollectionViewCellIdentifer";
static CGFloat verticalMargin = 5;
static CGFloat horizontalMargin = 5;
@interface STSubscriptionController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (copy, nonatomic) NSArray *collectionModelArr;
@property (strong, nonatomic) NSArray *liveRoomList;
@property (weak, nonatomic) UICollectionView *liveListCollectionView;
@property (nonatomic) NSInteger platformId;
@property (weak, nonatomic) UILabel *indicateLabel;
@property (nonatomic,weak) UIImageView *backgroundView;
@property (weak, nonatomic) UIImageView *logoView;
@end

@implementation STSubscriptionController
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [self loadData];
//    self.indicateLabel.hidden = !(self.liveRoomList.count == 0);
    self.backgroundView.hidden = !(self.liveRoomList.count == 0);
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

- (void)loadData {
    [[STCollectonManager sharedManager]getAllCollectionsWithPage:1 allCollectionsBlock:^(NSArray *collectionModelArr) {
        self.liveRoomList = collectionModelArr;
        [self.liveListCollectionView reloadData];
    }];
}

-(void)perpareUI
{
    //设置状态栏颜色
    UIView *statusBarBGC = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width
                                                                    , 20)];
    statusBarBGC.dk_backgroundColorPicker = DKColorPickerWithKey(SVBG);
    [self.view addSubview:statusBarBGC];

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    CGFloat liveInfoW = ([UIScreen mainScreen].bounds.size.width - 3 * horizontalMargin) / 2;
    CGFloat liveInfoH = ([UIScreen mainScreen].bounds.size.height - NavigationBarHeight - TabBarHeight - 4 * verticalMargin) / 4;
    flowLayout.itemSize = CGSizeMake(liveInfoW, liveInfoH);
    flowLayout.minimumLineSpacing = verticalMargin;
    flowLayout.minimumInteritemSpacing = horizontalMargin;
    flowLayout.sectionInset = UIEdgeInsetsMake(verticalMargin, horizontalMargin, verticalMargin, horizontalMargin);
    UICollectionView *liveListCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    liveListCollectionView.dk_backgroundColorPicker = DKColorPickerWithKey(CELL);
    self.liveListCollectionView = liveListCollectionView;
    liveListCollectionView.dataSource = self;
    liveListCollectionView.delegate = self;
    liveListCollectionView.backgroundColor = [UIColor whiteColor];
    [liveListCollectionView registerClass:[STLiveListCell class] forCellWithReuseIdentifier:liveListCollectionViewCellIdentifer];
    
    
    UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, self.view.bounds.size.height)];
    backgroundView.image = [UIImage imageNamed:@"background"];
    self.backgroundView = backgroundView;
    [self.view addSubview:backgroundView];
    
    
//    UILabel *indicateLabel = [[UILabel alloc]init];
//    indicateLabel.text = @"你订阅的直播可以在这里找到";
//    indicateLabel.textColor = [UIColor darkGrayColor];
//    indicateLabel.font = [UIFont systemFontOfSize:12];
//    self.indicateLabel = indicateLabel;
//    [self.view addSubview:indicateLabel];
    
    [self.view insertSubview:liveListCollectionView atIndex:0];
    
    [liveListCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];

    
}

//MARK:- 数据源代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.liveRoomList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    STLiveListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:liveListCollectionViewCellIdentifer forIndexPath:indexPath];
    
    if ([self.liveRoomList[indexPath.item] isKindOfClass:[STPandaLiveListModel class]]) {
        cell.pandaLiveListModel = self.liveRoomList[indexPath.item];
    }else if ([self.liveRoomList[indexPath.item] isKindOfClass:[STZhanqiLiveListModel class]]) {
        cell.zhanqiLiveListModel = self.liveRoomList[indexPath.item];
    }else if ([self.liveRoomList[indexPath.item] isKindOfClass:[STQuanMinLiveListModel class]]) {
        cell.quanminLiveListModel = self.liveRoomList[indexPath.item];
    }
    return cell;
}

//MARK:- 跳转进入直播间
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger roomId = 0;
    NSString *videoId = [[NSString alloc]init];
    NSString *stream = [[NSString alloc]init];
    NSString *liveName = [[NSString alloc]init];
    if ([self.liveRoomList[indexPath.item] isKindOfClass:[STPandaLiveListModel class]]) {
        STPandaLiveListModel *pandaLiveModel = self.liveRoomList[indexPath.item];
        liveName = pandaLiveModel.name;
        roomId = pandaLiveModel.roomId;
        self.platformId = 3;
    }else if ([self.liveRoomList[indexPath.item] isKindOfClass:[STZhanqiLiveListModel class]]) {
        STZhanqiLiveListModel *zhanqiLiveModel = self.liveRoomList[indexPath.item];
        liveName = zhanqiLiveModel.title;
        videoId =  zhanqiLiveModel.videoId;
        self.platformId = 2;
    }else if ([self.liveRoomList[indexPath.item] isKindOfClass:[STQuanMinLiveListModel class]]) {
        STQuanMinLiveListModel *quanminLiveModel = self.liveRoomList[indexPath.item];
        liveName = quanminLiveModel.title;
        stream = quanminLiveModel.stream;
        self.platformId = 5;
    }
    [self loadLiveDataWithRoomId:roomId andVideoId:videoId andStream:stream andLiveName:liveName andRoomList:self.liveRoomList andIndexPath:indexPath];
}

- (void)loadLiveDataWithRoomId:(NSInteger)roomId andVideoId:(NSString *)videoId andStream:(NSString *)stream andLiveName:(NSString *)liveName andRoomList:(NSArray *)roomList andIndexPath:(NSIndexPath *)indexPath {
    [[STNetworkManager sharedManager]getRoomWithPlatformId:(int)self.platformId andRoomId:(int)roomId andVideoId:videoId andStreamUrl:stream andCompletionHandler:^(NSURL *streamUrl) {
        [SVProgressHUD show];
        NSString *scheme = [[streamUrl scheme] lowercaseString];
        if ([scheme isEqualToString:@"http"]
            || [scheme isEqualToString:@"https"]
            || [scheme isEqualToString:@"rtmp"]) {
            [STLivePlayerController presentFromViewController:self withLiveTitle:liveName URL:streamUrl andRoomList:roomList andIndexPath:indexPath completion:^{
                [SVProgressHUD dismiss];
            }];
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
