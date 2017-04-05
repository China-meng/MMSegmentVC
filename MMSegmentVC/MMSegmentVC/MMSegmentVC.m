//
//  MMSegmentVC.m
//  MMSegmentVC
//
//  Created by mengxuanlong on 17/3/30.
//  Copyright © 2017年 mengxuanlong. All rights reserved.
//

#import "MMSegmentVC.h"
#import "MMShowDataVC.h"
#import "AutoScrollView.h"

#define HEADBTN_TAG                 10000
#define Default_ButtonHeight        45
#define Default_BottomLineHeight    2
#define Default_BottomLineColor     [UIColor redColor]
#define Default_TitleColor          [UIColor blackColor]
#define Default_FontSize            16
#define MainScreenWidth             [[UIScreen mainScreen]bounds].size.width
#define MainScreenHeight            [[UIScreen mainScreen]bounds].size.height
#define Default_HeadViewBackgroundColor  [UIColor whiteColor]

@interface MMSegmentVC ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *headScrollView;
@property (nonatomic, assign) NSInteger selectIndex;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) AutoScrollView *contentScrollView;

@end

@implementation MMSegmentVC {
    float startContentOffsetX;
    float willEndContentOffsetX;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
#pragma mark - 初始化方法(标签栏标题和对应的VC)
- (void)initSegment {

    // 根据传入的title数组新建button显示在顶部scrollView上
    [self addButtonInScrollHeader:_titleArray];
    // 根据传入的viewController数组，将viewController的view添加到显示内容的scrollView
    [self addVcInScrollViewContent:_subViewControllers];
    
    //如果pushGoodIndexNum存在,则push到卖品的Index
    if (_pushGoodIndexNum) {
        [_contentScrollView scrollRectToVisible:CGRectMake((_pushGoodIndexNum - HEADBTN_TAG) *MainScreenWidth, 0, MainScreenWidth, _contentScrollView.frame.size.height) animated:YES];
        [self didSelectSegmentIndex:_pushGoodIndexNum];
        
    }



}
#pragma mark - 根据传入的title数组新建button显示在顶部scrollView上
- (void)addButtonInScrollHeader:(NSArray *)titleArray {
    self.headScrollView.frame = CGRectMake(0, 0, MainScreenWidth, self.buttonHeight);
    if (_segmentHeaderType == 0) {
        self.headScrollView.contentSize = CGSizeMake(self.buttonWidth * titleArray.count, self.buttonHeight);
    } else {
        self.headScrollView.contentSize = CGSizeMake(MainScreenWidth, self.buttonHeight);
    
    }
    [self.view addSubview:self.headScrollView];
    for (NSInteger index = 0; index < titleArray.count; index++) {
        UIButton *segmentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        segmentBtn.frame = CGRectMake(self.buttonWidth * index, 0, self.buttonWidth, self.buttonHeight);
        [segmentBtn setTitle:titleArray[index] forState:UIControlStateNormal];
        segmentBtn.titleLabel.font = [UIFont systemFontOfSize:self.fontSize];
        segmentBtn.tag = index + HEADBTN_TAG;
        [segmentBtn setTitleColor:self.titleColor forState:UIControlStateNormal];
        [segmentBtn setTitleColor:self.titleSelectedColor forState:UIControlStateSelected];
        [segmentBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.headScrollView addSubview:segmentBtn];
        if (index == 0) {
            segmentBtn.selected = YES;
            self.selectIndex = segmentBtn.tag;
        }

    }
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.buttonHeight - self.bottomLineHeight, self.buttonWidth, self.bottomLineHeight)];
    _lineView.backgroundColor = self.bottomLineColor;
    [self.headScrollView addSubview:_lineView];


}
- (void)btnClick:(UIButton *)button {
    [_contentScrollView scrollRectToVisible:CGRectMake((button.tag - HEADBTN_TAG) *MainScreenWidth, 0, MainScreenWidth, _contentScrollView.frame.size.height) animated:YES];
    [self didSelectSegmentIndex:button.tag];

}
//点击标签栏按钮调用方法
- (void)didSelectSegmentIndex:(NSInteger)index {
    UIButton *btn = (UIButton *)[self.view viewWithTag:self.selectIndex];
    btn.selected = NO;
    self.selectIndex = index;
    UIButton *currentSelectBtn = (UIButton *)[self.view viewWithTag:index];
    currentSelectBtn.selected = YES;
    CGRect lineViewRect = self.lineView.frame;
    lineViewRect.origin.x = (index - HEADBTN_TAG) *_buttonWidth;
    if (_pushGoodIndexNum) {
        [UIView animateWithDuration:0.2 animations:^{
            self.lineView.frame = lineViewRect;
        }];
    } else  {
        [UIView animateWithDuration:0.3 animations:^{
            self.lineView.frame = lineViewRect;
        }];
    
    }

    NSInteger indexOfVC = index - 10000;
    id vC = _subViewControllers[indexOfVC];
    if ([vC isKindOfClass:[MMShowDataVC class]]) {
        MMShowDataVC *showDataVC = vC;
        showDataVC.isLoadData = YES;
        [showDataVC loadDataWith:indexOfVC];
    }

}
#pragma mark - 根据传入的viewController数组，将viewController的view添加到显示内容的scrollView
- (void)addVcInScrollViewContent:(NSArray *)subViewControllers {
    _contentScrollView = [[AutoScrollView alloc]initWithFrame:CGRectMake(0, self.buttonHeight, MainScreenWidth, MainScreenHeight - self.buttonHeight)];
    _contentScrollView.contentSize = CGSizeMake(MainScreenWidth * subViewControllers.count, MainScreenHeight - self.buttonHeight);
    [_contentScrollView setPagingEnabled:YES];
    if (_segmentControlType == 0) {
        _contentScrollView.scrollEnabled = YES;
    }
    else {
        _contentScrollView.scrollEnabled = NO;
    }
    [_contentScrollView setShowsVerticalScrollIndicator:NO];
    [_contentScrollView setShowsHorizontalScrollIndicator:NO];
    _contentScrollView.bounces = NO;
    _contentScrollView.delegate = self;
    [self.view addSubview:_contentScrollView];
    
    [subViewControllers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIViewController *vc = (UIViewController *)_subViewControllers[idx];
        vc.view.frame = CGRectMake(idx * MainScreenWidth, 0, MainScreenWidth, _contentScrollView.frame.size.height);
        [_contentScrollView addSubview:vc.view];
        [self addChildViewController:vc];
    }];
}
#pragma mark - 最外层的VC
- (void)addParentController:(UIViewController *)parentController {
    if ([parentController respondsToSelector:@selector(edgesForExtendedLayout)])
    {
        parentController.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [parentController addChildViewController:self];
    [parentController.view addSubview:self.view];

}

#pragma mark - ScrollViewDelegate
//减速停止的时候开始执行
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == _contentScrollView) {
        float xx = scrollView.contentOffset.x * (_buttonWidth / MainScreenWidth) - _buttonWidth;
        [_headScrollView scrollRectToVisible:CGRectMake(xx, 0, MainScreenWidth, _headScrollView.frame.size.height) animated:YES];
        NSInteger currentIndex = scrollView.contentOffset.x / MainScreenWidth;
        [self didSelectSegmentIndex:currentIndex + HEADBTN_TAG];
    }


}

//滚动完毕就会调用（如果不是人为拖拽scrollView导致滚动完毕，才会调用这个方法）
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    float xx = scrollView.contentOffset.x * (_buttonWidth / MainScreenWidth) - _buttonWidth;
    [_headScrollView scrollRectToVisible:CGRectMake(xx, 0, MainScreenWidth, _headScrollView.frame.size.height) animated:YES];
}

#pragma mark - 懒加载
- (UIScrollView *)headScrollView {
    if (_headScrollView == nil) {
        _headScrollView = [[UIScrollView alloc]init];
        [_headScrollView setShowsVerticalScrollIndicator:NO];
        [_headScrollView setShowsHorizontalScrollIndicator:NO];
        _headScrollView.backgroundColor = _headViewBackgroundColor;
        
    }
    return  _headScrollView;

}
- (UIColor *)headViewBackgroundColor
{
    if (_headViewBackgroundColor == nil) {
        _headViewBackgroundColor = Default_HeadViewBackgroundColor;
    }
    return _headViewBackgroundColor;
}

//按钮的高度
- (CGFloat)buttonHeight {
    if (_buttonWidth == 0) {
        _buttonHeight = Default_ButtonHeight;
    }
    return _buttonHeight;
}
//按钮的宽度
- (CGFloat)buttonWidth {
    if (_buttonWidth == 0) {
        _buttonWidth = MainScreenWidth / 6;
    }
    return _buttonWidth;
}


- (CGFloat)bottomLineHeight {
    if (_bottomLineHeight == 0) {
        _bottomLineHeight = Default_BottomLineHeight;
    }
    return _bottomLineHeight;
}

- (UIColor *)bottomLineColor {
    if (_bottomLineColor == nil) {
        _bottomLineColor = Default_BottomLineColor;
    }
    return _bottomLineColor;
}
- (UIColor *)titleColor {
    if (_titleColor == nil) {
        _titleColor = Default_TitleColor;
    }
    return _titleColor;
}

- (UIColor *)titleSelectedColor {
    if (_titleSelectedColor == nil) {
        _titleSelectedColor = Default_TitleColor;
    }
    return _titleSelectedColor;
}

- (CGFloat)fontSize {
    if (_fontSize == 0) {
        _fontSize = Default_FontSize;
    }
    return _fontSize;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{    //拖动前的起始坐标
    
    startContentOffsetX = scrollView.contentOffset.x;
    
}
//
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{    //将要停止前的坐标
    
    willEndContentOffsetX = scrollView.contentOffset.x;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
