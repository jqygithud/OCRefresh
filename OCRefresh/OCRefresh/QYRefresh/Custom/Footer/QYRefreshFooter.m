//
//  QYRefreshFooter.m
//  DiyRefresh
//
//  Created by jqy on 2019/6/25.
//  Copyright © 2019 jqy. All rights reserved.
//

#import "QYRefreshFooter.h"
#import "UIScrollView+QYRefresh.h"
@implementation QYRefreshFooter

+ (instancetype)footerWithRefreshingBlock:(QYComponentRefreshingBlock)refreshingBlock{
    QYRefreshFooter *cmp = [[self alloc]init];
    cmp.refreshingBlock = refreshingBlock;
    return cmp;
}

+ (instancetype)addFooterWithRefreshingTarget:(id)target refreshingAction:(SEL)selector{
    QYRefreshFooter *cmp = [[self alloc]init];
    cmp.target = target;
    cmp.selector = selector;
    return cmp;
}

- (void)scrollViewContentSizeDidChange:(NSDictionary *)change{
    [super scrollViewContentSizeDidChange:change];
    self.qy_y = self.scrollView.qy_contentSizeHeight +  _scrollViewDefaultInset.bottom ;
    self.scrollView.qy_contentInsetBottom = self.qy_h + _scrollViewDefaultInset.bottom;
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change{
    
    [super scrollViewContentOffsetDidChange:change];
    if (self.scrollView.contentSize.height<= 0) return;
    if (self.scrollView.contentSize.height + self.scrollView.qy_contentInsetBottom + self.scrollView.qy_contentInsetTop <= self.scrollView.qy_h) {
        if (self.scrollView.isDragging == NO) {
            if (self.scrollView.contentOffset.y + self.scrollView.qy_contentInsetTop > 1 && self.state == QYDidEndRefreshState) {
                self.state = QYRefreshingState;
            }
        }
    }else{
        if (self.scrollView.contentOffset.y + self.scrollView.qy_contentInsetTop > (self.scrollView.contentSize.height + self.scrollView.qy_contentInsetBottom + self.scrollView.qy_contentInsetTop - self.qy_h - self.scrollView.qy_h) && self.state == QYDidEndRefreshState) {
            self.state = QYRefreshingState;
        }
    }
}

- (void)setState:(QYRefreshState)state{
    QYRefreshCheckState
    if (state == QYRefreshingState){
        [self executeRefreshingCallback];
    }
}

- (void)endRefreshing{
    self.state = QYDidEndRefreshState;
}

@end
