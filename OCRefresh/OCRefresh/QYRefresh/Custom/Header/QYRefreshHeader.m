//
//  QYRefreshHeader.m
//  DiyRefresh
//
//  Created by sudiyang on 2018/11/19.
//  Copyright © 2018年 sudiyang. All rights reserved.
//

#define MJRefreshCheckState \
QYRefreshState oldState = self.state; \
if (state == oldState) return; \
[super setState:state];

#import "QYRefreshHeader.h"
#import "UIScrollView+QYRefresh.h"

@implementation QYRefreshHeader
#pragma mark- 自定义初始化
+ (instancetype)headerWithRefreshingBlock:(QYComponentRefreshingBlock)refreshingBlock{
    QYRefreshHeader *cmp = [[self alloc]init];
    cmp.refreshingBlock = refreshingBlock;
    return cmp;
}

+ (instancetype)addHeaderWithRefreshingTarget:(id)target refreshingAction:(SEL)selector{
    QYRefreshHeader *cmp = [[self alloc]init];
    cmp.target = target;
    cmp.selector = selector;
    return cmp;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.qy_y = - self.qy_h - self.scrollViewDefaultInset.top;
}

#pragma mark- 监听
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change{
    [super scrollViewContentOffsetDidChange:change];
    if (self.state == QYRefreshingState) {return;}
    if (self.scrollView.isDragging){
        if (self.scrollView.contentOffset.y + _scrollViewDefaultInset.top <= - self.qy_h ) {
            self.state = QYPullingRefreshState;
        }else{
            self.state = QYDidEndRefreshState;
        }
    }else {
       if (self.state == QYPullingRefreshState ){
            [self beginRefreshing];
       }
    }
}

#pragma mark- 重写刷新状态setter方法
- (void)setState:(QYRefreshState)state{
    __weak typeof(self)weakSelf = self;
    QYRefreshCheckState
    if (state == QYWillEndRefreshState) {
        [UIView animateWithDuration:0.3 animations:^{
            __strong typeof(self)strongSelf = weakSelf;
            strongSelf.scrollView.qy_contentInsetTop = strongSelf.scrollViewDefaultInset.top;
        } completion:^(BOOL finished) {
            __strong typeof(self)strongSelf = weakSelf;
            strongSelf.state = QYDidEndRefreshState;
        }];
    }else if (state == QYRefreshingState){
        [UIView animateWithDuration:0.3 animations:^{
            __strong typeof(self) strongSelf = weakSelf;
            strongSelf.scrollView.qy_contentInsetTop = strongSelf.scrollViewDefaultInset.top + strongSelf.qy_h;
        } completion:^(BOOL finished) {
            __strong typeof(self) strongSelf = weakSelf;
            [strongSelf executeRefreshingCallback];
        }];
    }
}

@end
