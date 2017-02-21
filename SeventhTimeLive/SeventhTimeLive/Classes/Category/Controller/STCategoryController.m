//
//  STCategoryController.m
//  SeventhTimeLive
//
//  Created by 刘洋  on 17/2/15.
//  Copyright © 2017年 com.217.www.SeventhTimeLive. All rights reserved.
//

#import "STCategoryController.h"
#import "STCategoryGameModel.h"
#import "STCategoryPlatformModel.h"
#import "STLiveListController.h"
#import "STThreePlatformView.h"
#import "STCategoryListView.h"

@interface STCategoryController ()<UIScrollViewDelegate,STThreePlatformViewDelegate,UIGestureRecognizerDelegate>
//游戏分类的数据
@property(nonatomic,strong)NSArray<STCategoryPlatformModel *> *platformList;
//游戏分类的滚动条
@property(nonatomic,weak) STCategoryListView *gameListView;
//三大平台选择条
@property(nonatomic,weak) STThreePlatformView *threePlatformView;
//状态栏
@property(nonatomic,weak) UIView *statusBarBGC;
//临时变量记录上滑滚动值
@property(nonatomic,assign) CGFloat tempHeight;
//关联scrollView
@property(nonatomic,weak) UIScrollView *scrollView;
//记录控制器下标
@property(nonatomic,assign) NSInteger index;
//记录游戏分类下标
@property(nonatomic,assign) NSInteger gameListIndex;
//
@property(nonatomic,strong) STLiveListController *pandaTV;

@property(nonatomic,strong) STLiveListController *zhanqiTV;

@property(nonatomic,strong) STLiveListController *quanminTV;

@property(nonatomic,strong) NSMutableArray <STLiveListController *> *liveListArray;
@end

@implementation STCategoryController

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
    self.tabBarController.tabBar.translucent = NO;
    self.view.backgroundColor = [UIColor blackColor];
    [self loadCategoreyData];
    [self perpareUI];
    
    
}

#pragma mark - 设置状态栏背景颜色
-(void)perpareUI
{
    //设置状态栏颜色
    UIView *statusBarBGC = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 20)];
    statusBarBGC.dk_backgroundColorPicker = DKColorPickerWithKey(SVBG);
    [self.view addSubview:statusBarBGC];
    self.statusBarBGC = statusBarBGC;
    
    //设置三大平台选择条
    STThreePlatformView *threePlatformView = [[STThreePlatformView alloc] init];
    [self.view insertSubview:threePlatformView atIndex:0];
    self.threePlatformView = threePlatformView;
    threePlatformView.delegate = self;
    threePlatformView.platformList = self.platformList;
    
    [threePlatformView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(20);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    
    //设置游戏类别滚动条
    STCategoryListView *listView = [[STCategoryListView alloc] init];
    [self.view addSubview:listView];
    //接收label点击事件
    [listView addTarget:self action:@selector(labelClick:) forControlEvents:UIControlEventValueChanged];
    
    listView.modelList = self.platformList[_index];
    [listView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(threePlatformView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(30);
    }];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //设置直播房间展示底层scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor brownColor];
    
    //分页
    scrollView.pagingEnabled = YES;
    //弹动
    scrollView.bounces = NO;
    //去掉滚动条
    scrollView.showsHorizontalScrollIndicator = NO;
    //代理
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    self.scrollView =scrollView;
    
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(listView.mas_bottom);
    }];
    
    //给底层scrollView添加三个控制器的View
    //给scrollView添加子控件的时候，设置edges == 0.，控件宽高必须设置
//    NSArray <NSString *>*vcNameArray = @[@"STLiveListController",@"STLiveListController",@"STLiveListController"];
    
    NSMutableArray <UIView *>*viewArray = [NSMutableArray array];
    
    self.liveListArray = [NSMutableArray array];
//    [vcNameArray enumerateObjectsUsingBlock:^(NSString * _Nonnull vcName, NSUInteger idx, BOOL * _Nonnull stop) {
//        //1.根据字符串  class
//        Class class = NSClassFromString(vcName);
//        
//        //2.根据类 生成对象
//        STLiveListController *targetVc = [[class alloc]init];
//        targetVc.platFormModel = self.platformList[idx];
//        targetVc.gameModel = self.platformList[idx].categories[_gameListIndex];
//
//        //3.添加(使用的是分类)
//        [self addChildController:targetVc intoView:scrollView];
//        [self.liveListArray addObject:targetVc];
//        [viewArray addObject:targetVc.view];
//
//
//    }];
    
    STLiveListController *pandaTV = [[STLiveListController alloc] init];
    pandaTV.platFormModel = self.platformList[0];
    pandaTV.gameModel = self.platformList[0].categories[_gameListIndex];
    [self addChildController:pandaTV intoView:scrollView];
    [self.liveListArray addObject:pandaTV];
    [viewArray addObject:pandaTV.view];
    self.pandaTV = pandaTV;
    
    STLiveListController *zhanqiTV = [[STLiveListController alloc] init];
    zhanqiTV.platFormModel = self.platformList[1];
    zhanqiTV.gameModel = self.platformList[1].categories[_gameListIndex];
    [self addChildController:zhanqiTV intoView:scrollView];
    [self.liveListArray addObject:zhanqiTV];
    [viewArray addObject:zhanqiTV.view];
    self.zhanqiTV = zhanqiTV;
    
    STLiveListController *quanminTV = [[STLiveListController alloc] init];
    quanminTV.platFormModel = self.platformList[2];
    quanminTV.gameModel = self.platformList[2].categories[_gameListIndex];
    [self addChildController:quanminTV intoView:scrollView];
    [self.liveListArray addObject:quanminTV];
    [viewArray addObject:quanminTV.view];
    self.quanminTV = quanminTV;
    
    [viewArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    
    [viewArray mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.bottom.equalTo(scrollView);
        //设置大小
        make.size.equalTo(scrollView);
    }];

    //添加拖拽手势，监听手势，修改三大平台选择条的高度约束
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    
    //解决手势冲突
    pan.delegate = self;
    
    [self.view addGestureRecognizer:pan];

}

#pragma mark - label点击事件
-(void)labelClick:(STCategoryListView *)listView
{
    self.gameListIndex =  listView.currentIndex;
    if (self.index == 0) {
        self.pandaTV.platFormModel = self.platformList[0];
        self.pandaTV.gameModel = self.platformList[_index].categories[listView.currentIndex];
        [self.pandaTV.liveListCollectionView.mj_header endRefreshing];
        NSDictionary *dict = @{@"platFormModel":self.pandaTV.platFormModel,@"gameModel":self.pandaTV.gameModel};
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"loadData1" object:nil userInfo:dict];
    }
    if (self.index == 1) {
        self.zhanqiTV.platFormModel = self.platformList[1];
        self.zhanqiTV.gameModel = self.platformList[_index].categories[listView.currentIndex];
        [self.zhanqiTV.liveListCollectionView.mj_header endRefreshing];
        NSDictionary *dict = @{@"platFormModel":self.zhanqiTV.platFormModel,@"gameModel":self.zhanqiTV.gameModel};
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"loadData2" object:nil userInfo:dict];
    }
    if (self.index == 2) {
        self.quanminTV.platFormModel = self.platformList[2];
        self.quanminTV.gameModel = self.platformList[_index].categories[listView.currentIndex];
        [self.quanminTV.liveListCollectionView.mj_header endRefreshing];
        NSDictionary *dict = @{@"platFormModel":self.quanminTV.platFormModel,@"gameModel":self.quanminTV.gameModel};
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"loadData3" object:nil userInfo:dict];
    }
    
    
    
    
//    STLiveListController *liveListVc = [[STLiveListController alloc] init];
//    liveListVc.platFormModel = self.platformList[_index];
//    liveListVc.gameModel = self.platformList[_index].categories[listView.currentIndex];
//    [liveListVc.liveListCollectionView.mj_header beginRefreshing];
    
}

#pragma mark - 滚动联动小绿条
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //1.获取滚得变量
    CGPoint offset = scrollView.contentOffset;
    
    if (!(scrollView.tracking || scrollView.dragging || scrollView.decelerating)) {//自动
        return;
    }
    
    //2.赋值给threV的属性
    _threePlatformView.offsetX = offset.x/3;
    //NSLog(@"%lf",-offset.x)
    
    NSUInteger index = (offset.x + self.view.bounds.size.width) / self.view.bounds.size.width - 0.5;
    NSLog(@"%zd",index);
    
        if (index == 0) {
            self.pandaTV.platFormModel = self.platformList[0];
            self.pandaTV.gameModel = self.platformList[0].categories[0];
            //[self.pandaTV.liveListCollectionView.mj_header endRefreshing];
            NSDictionary *dict = @{@"platFormModel":self.pandaTV.platFormModel,@"gameModel":self.pandaTV.gameModel};
            
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"loadData1" object:nil userInfo:dict];
        }
        if (index == 1) {
            self.zhanqiTV.platFormModel = self.platformList[1];
            self.zhanqiTV.gameModel = self.platformList[1].categories[0];
            //[self.zhanqiTV.liveListCollectionView.mj_header endRefreshing];
            NSDictionary *dict = @{@"platFormModel":self.zhanqiTV.platFormModel,@"gameModel":self.zhanqiTV.gameModel};
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"loadData2" object:nil userInfo:dict];
        }
        if (index == 2) {
            self.quanminTV.platFormModel = self.platformList[2];
            self.quanminTV.gameModel = self.platformList[2].categories[0];
            //[self.quanminTV.liveListCollectionView.mj_header endRefreshing];
            NSDictionary *dict = @{@"platFormModel":self.quanminTV.platFormModel,@"gameModel":self.quanminTV.gameModel};
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"loadData3" object:nil userInfo:dict];
        }


}

//解决手势冲突
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

#pragma mark - 监听拖拽手势
-(void)pan:(UIPanGestureRecognizer *)sender
{
    //MARK:1.获取偏移量
    CGPoint offset = [sender translationInView:sender.view];
    
    if (ABS(offset.x) > ABS(offset.y)) {
        return;
    }
    
    //MARK:2.归零
    [sender setTranslation:CGPointZero inView:sender.view];
    
    //MARK:3.计算高度
    CGFloat height = offset.y;
    _tempHeight += height;
    NSLog(@"%lf",_tempHeight);
    
    if (_tempHeight <= -50){
        _tempHeight = -50;
    }
    if (_tempHeight >= 0) {
        _tempHeight = 0;
    }
    if(_tempHeight < -50 || _tempHeight > 0){

        return;
        
    }
    
    
    //MARK:4.更新topV的高度的约束
    [_threePlatformView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view.mas_top).offset(20 + _tempHeight);
        
    }];
    
    // 建议加个动画
    [UIView animateWithDuration:.3 animations:^{
        [self.view layoutIfNeeded];
    }];


}


#pragma mark - 获取数据
-(void)loadCategoreyData
{
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"category.plist" ofType:nil];
    NSArray *plistArr = [NSArray arrayWithContentsOfFile:plistPath];
    NSArray *modelArr = [NSArray yy_modelArrayWithClass:[STCategoryPlatformModel class] json:plistArr];
    self.platformList = modelArr;

}

#pragma mark - 游戏分类页的视图PageVc


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 点击按钮实现切换scrollView
-(void)threePlatformView:(STThreePlatformView *)threePlatformView withIndex:(NSUInteger)selectIndex
{
    self.index = selectIndex;
    NSLog(@"%ld",(long)self.index);
    CGRect rect = CGRectMake(selectIndex * kScreenWidth, 0, kScreenWidth, _scrollView.bounds.size.height);
    [_scrollView scrollRectToVisible:rect animated:YES];
    
    if (self.index == 0) {
        self.pandaTV.platFormModel = self.platformList[0];
        self.pandaTV.gameModel = self.platformList[_index].categories[0];
        [self.pandaTV.liveListCollectionView.mj_header endRefreshing];
        NSDictionary *dict = @{@"platFormModel":self.pandaTV.platFormModel,@"gameModel":self.pandaTV.gameModel};
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"loadData1" object:nil userInfo:dict];
    }
    if (self.index == 1) {
        self.zhanqiTV.platFormModel = self.platformList[1];
        self.zhanqiTV.gameModel = self.platformList[_index].categories[0];
        [self.zhanqiTV.liveListCollectionView.mj_header endRefreshing];
        NSDictionary *dict = @{@"platFormModel":self.zhanqiTV.platFormModel,@"gameModel":self.zhanqiTV.gameModel};
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"loadData2" object:nil userInfo:dict];
    }
    if (self.index == 2) {
        self.quanminTV.platFormModel = self.platformList[2];
        self.quanminTV.gameModel = self.platformList[_index].categories[0];
        [self.quanminTV.liveListCollectionView.mj_header endRefreshing];
        NSDictionary *dict = @{@"platFormModel":self.quanminTV.platFormModel,@"gameModel":self.quanminTV.gameModel};
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"loadData3" object:nil userInfo:dict];
    }

}


@end
