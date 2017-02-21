//
//  STThreePlatformView.m
//  SeventhTimeLive
//
//  Created by 刘洋  on 17/2/16.
//  Copyright © 2017年 com.217.www.SeventhTimeLive. All rights reserved.
//

#import "STThreePlatformView.h"


@interface STThreePlatformView()
@property(nonatomic,weak) UIView *greenLine;
@property(nonatomic,assign)NSInteger index;

//标记选中按钮
@property(nonatomic,weak) UIButton *selectBtn;
@end
@implementation STThreePlatformView
{
    NSMutableArray <UIButton *> *_btnsArray;
}
-(instancetype)init
{
    if (self = [super init]) {
        [self perpareUI];
    }
    return self;
}

#pragma mark - 按钮点击事件  切换小绿条
-(void)clickBtn:(UIButton *)sender
{
    //取消上一个按钮的状态
    self.selectBtn.selected = NO;
    //设置现在按钮选中
    sender.selected = YES;
    //替换选中按钮
    self.selectBtn = sender;
    
    //获取按钮在数组中的角标
    NSInteger index = [_btnsArray indexOfObject:sender];
    self.index = index;
    
    [_greenLine mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_btnsArray[0]).offset(index * _btnsArray[0].bounds.size.width);
    }];
    
    [UIView animateWithDuration:.3 animations:^{
        [self layoutIfNeeded];
    }];
    
    //给控制器发送消息
    if ([_delegate respondsToSelector:@selector(threePlatformView:withIndex:)]) {
        [_delegate threePlatformView:self withIndex:self.index];
    }
}


-(void)perpareUI
{
    
    
    //创建按钮图片名集合
    NSArray <NSString *> *imgArray = @[@"panda",@"zhanqi",@"quanmin"];
    
    //创建添加三个按钮
    _btnsArray = [NSMutableArray array];
    [imgArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = [[UIButton alloc] init];
        [btn setImage:[UIImage imageNamed:obj] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:obj] forState:UIControlStateHighlighted];
        [btn sizeToFit];
        
        //监听按钮的事件
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        //设置默认选中
        if (idx == 0) {
            btn.selected = YES;
            self.selectBtn = btn;
        }
        
        [self addSubview:btn];
        
        [_btnsArray addObject:btn];
    }];
    
    //小绿条
    UIView *greenLine = [[UIView alloc] init];
    greenLine.dk_backgroundColorPicker = DKColorPickerWithKey(SVBG);
    [self addSubview:greenLine];
    self.greenLine = greenLine;
    
    //布局
        //横竖
        //中间间距
        //头间距
        //尾间距
    [_btnsArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    [_btnsArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
    }];
    
    [greenLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.bottom.equalTo(_btnsArray[0]);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(4);
        
    }];
}

#pragma mark - 接收手动滚动的偏移量
-(void)setOffsetX:(CGFloat)offsetX
{
    _offsetX = offsetX;
    [_greenLine mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_btnsArray[0]).offset(offsetX);
    }];
    
    [UIView animateWithDuration:.3 animations:^{
        [self layoutIfNeeded];
    }];
    
    //修改按钮的选中状态
    NSUInteger index = offsetX/_btnsArray[0].bounds.size.width + 0.5;
    //计算按钮角标
    UIButton *btn = _btnsArray[index];
    
    //设置按钮的状态
    self.selectBtn.selected = NO;
    btn.selected = YES;
    self.selectBtn = btn;
}

-(void)setPlatformList:(NSArray<STCategoryPlatformModel *> *)platformList
{
    _platformList = platformList;
}

@end
