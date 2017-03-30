//
//  MMSegmentVC.h
//  MMSegmentVC
//
//  Created by mengxuanlong on 17/3/30.
//  Copyright © 2017年 mengxuanlong. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,SegmentHeaderType) {
    SegmentHeaderTypeScroll, //标签栏可滚动
    SegmentHeaderTypeFixed   //标签栏固定
    
};
typedef NS_ENUM(NSInteger, SegmentControlStyle) {
    SegmentControlTypeScroll, //内容部分可滚动
    SegmentControlTypeFixed   //内容部分固定
};
@interface MMSegmentVC : UIViewController
//标签栏标题数组
@property (nonatomic, strong) NSArray *titleArray;
//标签栏标题数组对应ViewController数组
@property (nonatomic, strong) NSArray *subViewControllers;
//标签栏背景色
@property (nonatomic, strong) UIColor *headViewBackgroundColor;
//非选中状态下标签字体颜色
@property (nonatomic, strong) UIColor *titleColor;
//选中标签字体颜色
@property (nonatomic, strong) UIColor *titleSelectedColor;
//标签字体大小
@property (nonatomic, assign) CGFloat fontSize;
//标签栏每个按钮高度
@property (nonatomic, assign) CGFloat buttonHeight;
//标签栏每个按钮宽度
@property (nonatomic, assign) CGFloat buttonWidth;
//选中标签下划线高度
@property (nonatomic, assign) CGFloat bottomLineHeight;
//选中标签底部划线颜色
@property (nonatomic, strong) UIColor *bottomLineColor;
//标签栏类型，默认为滚动
@property (nonatomic, assign) SegmentHeaderType segmentHeaderType;
//内容类型，默认为滚动
@property (nonatomic, assign) SegmentControlStyle segmentControlType;

#pragma mark - 对外暴露的方法
//初始化方法(标签栏标题和对应的VC)
- (void)initSegment;
//最外层的VC
- (void)addParentController:(UIViewController *)parentController;
//点击标签栏按钮调用方法
- (void)didSelectSegmentIndex:(NSInteger)index;

@end
