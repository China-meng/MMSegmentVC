//
//  AutoScrollView.m
//  MMSegmentVC
//
//  Created by mengxuanlong on 17/4/5.
//  Copyright © 2017年 mengxuanlong. All rights reserved.
//

#import "AutoScrollView.h"
@interface AutoScrollView()<UIGestureRecognizerDelegate>

@end
@implementation AutoScrollView
/*
 scrollView的pan手势会让系统的pan手势失效，这里需要在系统手势失效且scrollView的位置在初始位置的时候让两个手势同时启用就可以了。
 */
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    // 首先判断otherGestureRecognizer是不是系统pop手势
    if ([otherGestureRecognizer.view isKindOfClass:NSClassFromString(@"UILayoutContainerView")]) {
        // 再判断系统手势的state是began还是fail，同时判断scrollView的位置是不是正好在最左边
        if (otherGestureRecognizer.state == UIGestureRecognizerStateBegan && self.contentOffset.x == 0) {
            return YES;
        }
    }
    
    return NO;
}

@end
