//
//  MMHomePageVC.m
//  MMSegmentVC
//
//  Created by mengxuanlong on 17/3/30.
//  Copyright © 2017年 mengxuanlong. All rights reserved.
//

#import "MMHomePageVC.h"
#import "MMSegmentVC.h"
#import "MMShowDataVC.h"
static CGFloat const ButtonHeight = 50;
@interface MMHomePageVC ()

@end

@implementation MMHomePageVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"有问题可以直接给我提问";
    [self leftBackButton];//这句代码注释了就可侧滑返回了,不知道为什么
    self.view.backgroundColor = [UIColor whiteColor];
    MMSegmentVC *vc = [[MMSegmentVC alloc]init];
    NSArray *titleArray = @[@"影票订单", @"卖品订单", @"其他订单"];
    vc.titleArray = titleArray;
    NSMutableArray *subVcArray =  [[NSMutableArray alloc]init];
    for (int i = 0; i < vc.titleArray.count; i ++) {
        MMShowDataVC *vc = [[MMShowDataVC alloc]initWithIndex:i title:titleArray[i]];
        [subVcArray addObject:vc];
    }
    vc.titleSelectedColor = [UIColor redColor];
    vc.subViewControllers = subVcArray;
    vc.buttonWidth = self.view.frame.size.width / titleArray.count;
    vc.buttonHeight = ButtonHeight;
    vc.headViewBackgroundColor = [UIColor whiteColor];
    //如果pushGoodIndexNum存在,则push到卖品的Index
    if (_pushGoodIndexNum) {
        vc.pushGoodIndexNum = _pushGoodIndexNum;

    }
    
    [vc initSegment];
    
    [vc addParentController:self];


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
