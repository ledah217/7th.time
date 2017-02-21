//
//  RefreshHeader.m
//  半糖Refresh
//
//  Created by 刘洋  on 17/2/9.
//  Copyright © 2017年 itheima. All rights reserved.
//

#import "RefreshHeader.h"
#import <objc/runtime.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreText/CoreText.h>

//设置初始的高度，默认是有NavigationController
const CGFloat originOffset= 64.0f;
const CGFloat refreshHeaderViewHeight = 80.0f;

@interface RefreshHeader()

@property (nonatomic, weak) UIScrollView * scrollView;

@property (nonatomic, retain) CALayer *animationLayer;
@property (nonatomic, retain) CAShapeLayer *pathLayer;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;


@property (nonatomic, assign) CGFloat progress;

@end

@implementation RefreshHeader

-(instancetype)initWithScrollView:(UIScrollView *)ScrollView
{
    self = [super initWithFrame:CGRectMake(0, -80.0f, 375.0f, 80.0f)];
    
    if (self) {
        
        
        self.scrollView = ScrollView;
        
        [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
        
        self.animationLayer = [CALayer layer];
        self.animationLayer.frame = CGRectMake(0.0f, 44.0f, 375.0f, 80.0f);
        [self.layer addSublayer:self.animationLayer];
        [self addPullAnimation];
        
    }
    return self;
}




#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    //属性
    if ([keyPath isEqualToString:@"contentOffset"]) {
        CGPoint contentOffset = [[change objectForKey:NSKeyValueChangeNewKey]CGPointValue];
        if (contentOffset.y + originOffset <= 160) {
            self.progress = MAX(0.0, MIN(fabs(contentOffset.y+originOffset)/200.0f, 1.0));
        }
    }
}

#pragma mark - 滑动过程控制动画进度
-(void)setProgress:(CGFloat)progress
{
    //动画View的中心的y是根据offset的变化而改变
    self.center = CGPointMake(self.center.x, -fabs(self.scrollView.contentOffset.y + originOffset)/2);
    
    //判断是否开始下拉，如果diff为正是下拉，为负则是上拉
    //CGFloat diff = fabs(self.scrollView.contentOffset.y + originOffset) - 80.0f;
    
    //CAShapeLayer的strokeStart和strokeEnd属性
    //用于对绘制的Path进行分区，这两个属性的值在0-1之间，0代表Path的开始位置
    //1代表结束位置，是线性递增关系这两个属性都支持动画
    //所以设置他的值为KVO监控下获取的contentOffset的计算值
    self.pathLayer.strokeEnd = progress;
    [UIView animateWithDuration:0.3 animations:^{
        self.scrollView.contentInset = UIEdgeInsetsMake(80.0f + originOffset, 0, 0, 0);
    }];
    
    
}

- (CAShapeLayer *)setupDefaultLayer
{
    //设置默认文本吧，就不传参了
    NSString *refreshStr = @"7th.Time Live~";
    
    //如果pathLayer存在，则移除
    if (self.pathLayer != nil) {
        [self.pathLayer removeFromSuperlayer];
        self.pathLayer = nil;
    }
    
    //创建绘图路径
    CGMutablePathRef letters = CGPathCreateMutable();
    
    //设置字体属性
    CTFontRef font = CTFontCreateWithName(CFSTR("HelveticaNeue-UltraLight"), 26.0f, NULL);
    
    //ARC模式下OC对象和CF独享之间的桥接  ——  (__bridge id)font
    //创建属性字典
    NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:(__bridge id)font,kCTFontAttributeName,nil];
    
    //这块就可以说说上面属性字典是干嘛的了
    //富文本的属性是以键值对的方式出现的，所以，我们可以将预设好的属性存放到属性字典中，然后添加进去
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:refreshStr attributes:attrs];
    
    //这里就要涉及coreText的核心知识了
    /**
     首先coreText是用来实现图文混编的，我们可以是用coreText对属性字符串进行绘制。
     绘制过程中的两个概念是CTFramesetterRef跟CTFrameRef。
     
     在创建好要绘制的富文本字符串之后，我们用它来创建一个CTFramesetterRef变量，这个变量可以看做是
     CTFrameRef的一个工厂，用来辅助我们创建后者。
     
     除此之外，每一个创建的CTFrameRef中存在一个或者更多的CTLineRef变量，这个变量表示绘制文本中的每一行文
     本。每个CTLineRef变量中存在一个或者更多个CTRunRef变量，在文本绘制过程中，我们并不关心CTLineRef或者
     CTRunRef变量具体对应的是什么字符，这些工作在更深层次系统已经帮我们完成了创建。
     
     上面这些话看起来挺累的，不如我们这么理解：
     CTFrame是段落
     CTLine是行
     CTRun就是字符了
     这么理解起来下面就好说了
     */
    //获取这行每个字符的字体（run），别忘了强转下格式
    CTLineRef line = CTLineCreateWithAttributedString((CFAttributedStringRef)attrString);
    
    //CTLineGetGlyphRuns:构成线的CTRUN对象
    //获取line中包含的所有run的数组，也就是获取这一行的每个富文本字符的数组
    CFArrayRef runArray = CTLineGetGlyphRuns(line);
    
    //到上面这里我们已经拿到了我们想要的东西了，字符和他自己的属性，也就是run数组
    //遍历文本行，针对每个字符的字形进行处理（Glyph:字形）
    //for循环三个参数应该很好理解了
    for (CFIndex runIndex = 0; runIndex < CFArrayGetCount(runArray); runIndex++)
    {
        //获取每个字符的字体数组
        CTRunRef run = (CTRunRef)CFArrayGetValueAtIndex(runArray, runIndex);
        CTFontRef runFont = CFDictionaryGetValue(CTRunGetAttributes(run), kCTFontAttributeName);
        
        //遍历字体数组进行处理
        for (CFIndex runGlyphIndex = 0; runGlyphIndex < CTRunGetGlyphCount(run); runGlyphIndex++)
        {
            CFRange thisGlyphRange = CFRangeMake(runGlyphIndex, 1);//范围
            CGGlyph glyph;//字形
            CGPoint position;//位置
            CTRunGetGlyphs(run, thisGlyphRange, &glyph);
            CTRunGetPositions(run, thisGlyphRange, &position);
            
            //获取轮廓路径
            {
                CGPathRef letter = CTFontCreatePathForGlyph(runFont, glyph, NULL);
                CGAffineTransform t = CGAffineTransformMakeTranslation(position.x, position.y);
                CGPathAddPath(letters, &t, letter);
                CGPathRelease(letter);
                
            }
        }
        
    }
    //由于coreText基于C语言的库，所有对象都需要我们手动释放内存
    CFRelease(line);
    
    //然后就是咱们熟悉的绘制了
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointZero];
    //添加文字那个路径
    [path appendPath:[UIBezierPath bezierPathWithCGPath:letters]];
    
    CGPathRelease(letters);
    CFRelease(font);
    
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    //animationLayer.bounds理论上来讲应该是动态数据
    pathLayer.frame = self.animationLayer.bounds;
    //CGPathGetBoundingBox，返回文字区域
    pathLayer.bounds = CGPathGetBoundingBox(path.CGPath);
    //子图层垂直反转
    pathLayer.geometryFlipped = YES;
    pathLayer.path = path.CGPath;
    //绘制边框色
    //pathLayer.strokeColor = [UIColor colorWithRed:234.0/255 green:84.0/255 blue:87.0/255 alpha:1].CGColor;
    pathLayer.strokeColor = mainColor.CGColor;
    //填充色设置为nil
    pathLayer.fillColor = nil;
    //填充路径的线宽
    pathLayer.lineWidth = 1.0f;
    //拐角样式
    pathLayer.lineJoin = kCALineJoinBevel;
    
    return pathLayer;
}

- (void)addPullAnimation
{
    // 这就是生活
    CAShapeLayer *pathLayer = [self setupDefaultLayer];
    [self.animationLayer addSublayer:pathLayer];
    self.pathLayer = pathLayer;
}


@end
