//
//  STGameLabel.m
//  SeventhTimeLive
//
//  Created by 刘洋  on 17/2/16.
//  Copyright © 2017年 com.217.www.SeventhTimeLive. All rights reserved.
//

#define kBIG 18
#define kSMALL 15

#import "STGameLabel.h"

@implementation STGameLabel

+(instancetype)labelWithTitle:(NSString *)title
{
    STGameLabel *label = [[STGameLabel alloc]init];
    label.text = title;
    label.textColor = [UIColor whiteColor];
    [label setTextAlignment:NSTextAlignmentCenter];
    
    //先设置大字体，目的是吧label空间撑开
    label.font = [UIFont systemFontOfSize:kBIG];
    [label sizeToFit];
    label.font = [UIFont systemFontOfSize:kSMALL];

    //label开启交互
    label.userInteractionEnabled = YES;
    
    return label;
}


@end
