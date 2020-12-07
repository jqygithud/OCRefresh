//
//  ViewController.m
//  OCRefresh
//
//  Created by sudiyang on 2020/12/7.
//

#import "ViewController.h"
#import "QYRefresh.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *table = UITableView.new;
    self.view = table;
    table.qy_header = [QYRefreshNormalHeader headerWithRefreshingBlock:^{
        [table.qy_header endRefreshing];
    }];
    
    // Do any additional setup after loading the view.
}


@end
