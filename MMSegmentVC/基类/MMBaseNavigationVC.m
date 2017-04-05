//
//  MMBaseNavigationVC.m
//  MMSegmentVC
//
//  Created by mengxuanlong on 17/3/31.
//  Copyright © 2017年 mengxuanlong. All rights reserved.
//

#import "MMBaseNavigationVC.h"

@interface MMBaseNavigationVC ()<UIGestureRecognizerDelegate>

@end

@implementation MMBaseNavigationVC
//自定义了leftBarButtonItem 侧滑返回失效
- (void)viewDidLoad {
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.delegate =  self;

}


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.viewControllers.count <= 1 ) {
        return NO;
    }
    
    return YES;
}

@end
