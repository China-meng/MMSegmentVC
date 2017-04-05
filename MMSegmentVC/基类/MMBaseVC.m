//
//  MMBaseVC.m
//  MMSegmentVC
//
//  Created by mengxuanlong on 17/3/31.
//  Copyright © 2017年 mengxuanlong. All rights reserved.
//

#import "MMBaseVC.h"

@interface MMBaseVC ()<UIGestureRecognizerDelegate>

@end

@implementation MMBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.interactivePopGestureRecognizer.delegate = self;

}

- (void)leftBackButton {
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 30, 16);
    [leftBtn setImage:[UIImage imageNamed:@"whiteBack"]
             forState:UIControlStateNormal];
    [leftBtn setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 18)];
    [leftBtn addTarget:self
                action:@selector(backTo)
      forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem =
    [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;

}
- (void)backTo {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
//    //导航的rootViewController关闭右滑返回功能
//    if (self.navigationController.viewControllers.count <= 1) {
//        return NO;
//    }
//    
//    return YES;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
