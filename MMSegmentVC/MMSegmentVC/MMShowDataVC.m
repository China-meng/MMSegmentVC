//
//  MMShowDataVC.m
//  MMSegmentVC
//
//  Created by mengxuanlong on 17/3/30.
//  Copyright © 2017年 mengxuanlong. All rights reserved.
//

#import "MMShowDataVC.h"

@interface MMShowDataVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation MMShowDataVC
- (instancetype)initWithIndex:(NSInteger)index title:(NSString *)title {
    self = [super init];
    if (self) {
        _titleStr = title;
    }
    return self;
    
}


- (void)setIsLoadData:(BOOL)isLoadData{
    _isLoadData = isLoadData;
    NSLog(@"刷新数据");

}
- (void)loadDataWith:(NSInteger)index {
    NSLog(@"点击了第%ld个，刷新数据",index);


}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;

    [self.view addSubview:self.tableView];

    
}

- (UITableView *)tableView {
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height- 50 - 64) style:UITableViewStylePlain];
        _tableView.delegate =self;
        _tableView.dataSource = self;

    }
    return _tableView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier: cellIdentifier];
    }
    cell.textLabel.text = [_titleStr stringByAppendingString:[NSString stringWithFormat:@"-%d",(int)indexPath.row]];
    return cell;
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
