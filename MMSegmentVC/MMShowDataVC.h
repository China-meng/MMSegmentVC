//
//  MMShowDataVC.h
//  MMSegmentVC
//
//  Created by mengxuanlong on 17/3/30.
//  Copyright © 2017年 mengxuanlong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MMShowDataVC : UIViewController
@property (nonatomic, assign)BOOL isLoadData;

- (void)loadDataWith:(NSInteger)index;
- (instancetype)initWithIndex:(NSInteger)index title:(NSString *)title;

@end
