//
//  STCategoryListView.m
//  SeventhTimeLive
//
//  Created by 刘洋  on 17/2/15.
//  Copyright © 2017年 com.217.www.SeventhTimeLive. All rights reserved.
//

#import "STCategoryListView.h"
#import "STGameLabel.h"

@interface STCategoryListView()

/** 游戏名 */
@property (weak, nonatomic) UILabel *nameLabel;

@property(nonatomic,weak) UIScrollView *scrollView;

@end

@implementation STCategoryListView
- (instancetype)init {
    if (self = [super init]) {
        self.dk_backgroundColorPicker = DKColorPickerWithKey(SVBG);
        UIScrollView *scrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
        scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
    }
    return self;
}


-(void)setModelList:(STCategoryPlatformModel *)modelList
{
    _modelList = modelList;
    
    
    
    //计算Label的位置
    CGFloat margin = 5;
    CGFloat x = margin;
    CGFloat y = 0;
    CGFloat width;
    CGFloat height = 30;
    
    for (int i = 0; i < modelList.categories.count; i++) {
        STCategoryGameModel *model = (STCategoryGameModel *)modelList.categories[i];
        STGameLabel *nameLabel = [STGameLabel labelWithTitle:model.name];
        
        width = nameLabel.frame.size.width;
        [nameLabel setFrame:CGRectMake(x, y, width, height)];
        
        x += width + margin;
        
        [self.scrollView addSubview:nameLabel];
        
        nameLabel.tag = i;
        
        //label的点击手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTap:)];
        [nameLabel addGestureRecognizer:tap];
    }
    
   [self.scrollView setContentSize:CGSizeMake(x, height)];
}

-(void)labelTap:(UITapGestureRecognizer *)tap{
    STGameLabel *nameLabel =  (STGameLabel *)tap.view;
    NSInteger index = nameLabel.tag;
    self.currentIndex = index;
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

@end
