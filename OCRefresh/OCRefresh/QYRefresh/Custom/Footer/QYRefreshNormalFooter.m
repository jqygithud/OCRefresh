//
//  QYRefreshNormalFooter.m
//  DiyRefresh
//
//  Created by sudiyang on 2019/6/25.
//  Copyright © 2019 sudiyang. All rights reserved.
//

#import "QYRefreshNormalFooter.h"

@interface QYRefreshNormalFooter ()
@property(nonatomic,strong)UIButton *footerButton;
@property(nonatomic,strong)UIView *loadingView;
@end

@implementation QYRefreshNormalFooter

- (void)setViews{
    [self.footerButton setTitle:@"点击或上拉加载更多" forState:(UIControlStateNormal)];
}
- (void)setState:(QYRefreshState)state{
    QYRefreshCheckState
    if (state == QYRefreshingState) {
        self.footerButton.hidden = YES;
        self.loadingView.hidden = NO;
    }else {
        self.loadingView.hidden = YES;
        self.footerButton.hidden = NO;
        if (state == QYDidEndRefreshState){
            [self.footerButton setTitle:@"点击或上拉加载更多" forState:(UIControlStateNormal)];
        }else if (state == QYNoMoreDataState){
            [self.footerButton setTitle:@"没有更多数据了" forState:(UIControlStateNormal)];
        }
    }
}

- (UIButton *)footerButton{
    if (!_footerButton) {
        _footerButton = [UIButton.alloc initWithFrame:self.bounds];
        _footerButton.titleLabel.font = QYFitFont(13);
        [_footerButton setTitleColor:[UIColor colorWithRed:171/255.0 green:171/255.0 blue:171/255.0 alpha:1] forState:(UIControlStateNormal)];
        [_footerButton setTitle:@"点击或上拉加载更多" forState:(UIControlStateNormal)];
        [_footerButton addTarget:self action:@selector(loadMoreData) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:_footerButton];
    }
    return _footerButton;
}

- (UIView *)loadingView{
    if (!_loadingView) {
        _loadingView = [UIView.alloc initWithFrame:self.bounds];
        UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleGray)];
        activityIndicatorView.qy_w = QYFitWidth(13);
        activityIndicatorView.qy_h = QYFitWidth(13);
        activityIndicatorView.qy_centerY = _loadingView.qy_centerY;
        activityIndicatorView.qy_x = (_loadingView.qy_w - QYFitWidth(13) - QYFitWidth(20) - QYFitWidth(60))/2;
        [activityIndicatorView startAnimating];
        [_loadingView addSubview:activityIndicatorView];
        UILabel *alertLabel = [UILabel.alloc init];
        alertLabel.font = QYFitFont(15);
        alertLabel.textColor = [UIColor colorWithRed:171/255.0 green:171/255.0 blue:171/255.0 alpha:1];
        alertLabel.qy_w = QYFitWidth(60);
        alertLabel.qy_h = _loadingView.qy_h;
        alertLabel.qy_centerY = activityIndicatorView.qy_centerY;
        alertLabel.qy_x = activityIndicatorView.qy_right + QYFitWidth(20);
        alertLabel.text = @"加载中...";
        [_loadingView addSubview:alertLabel];
        [self addSubview:_loadingView];
    }
    return _loadingView;
}

- (void)loadMoreData{
    if (self.state == QYDidEndRefreshState) {
        [self beginRefreshing];
    }
}

@end
