//
//  MMPushVC.m
//  MMSegmentVC
//
//  Created by mengxuanlong on 17/3/30.
//  Copyright © 2017年 mengxuanlong. All rights reserved.
//

#import "MMPushVC.h"
#import "MMBaseVC.h"

#import "MMHomePageVC.h"

@interface MMPushVC ()

@end

@implementation MMPushVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //push到电影的Index
    [self pushFilmIndex];
    //push到卖品的Index
    [self pushGoodIndex];
//    self.navigationController.navigationBar.barTintColor = [UIColor purpleColor];

}
- (void)pushFilmIndex {
    UIButton *pushBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    pushBtn.frame = CGRectMake(0, 80, 300, 60);
    [pushBtn setTitle:@"正常的push" forState:UIControlStateNormal];
    [pushBtn setBackgroundColor: [UIColor grayColor]];
    [pushBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:pushBtn];
    [pushBtn addTarget:self action:@selector(pushFilmIndexClick) forControlEvents:UIControlEventTouchUpInside];

}
#pragma mark - 正常的push
- (void)pushFilmIndexClick {
    MMHomePageVC *vc  = [[MMHomePageVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];

}

- (void)pushGoodIndex {
    UIButton *pushBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    pushBtn.frame = CGRectMake(0, 160, 300, 60);
    [pushBtn setBackgroundColor: [UIColor grayColor]];
    [pushBtn setTitle:@"push到卖品的Index" forState:UIControlStateNormal];
    [pushBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:pushBtn];
    [pushBtn addTarget:self action:@selector(pushGoodIndexClick) forControlEvents:UIControlEventTouchUpInside];
    
    
}
#pragma mark - push到卖品的Index
- (void)pushGoodIndexClick {
    MMHomePageVC *vc  = [[MMHomePageVC alloc]init];
    NSInteger pushGoodIndexNum = 10001;
    vc.pushGoodIndexNum = pushGoodIndexNum;
    [self.navigationController pushViewController:vc animated:YES];
    
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
