//
//  QYRefreshCompont.m
//  DiyRefresh
//
//  Created by sudiyang on 2018/11/19.
//  Copyright © 2018年 sudiyang. All rights reserved.
//

#import "QYRefreshCompont.h"
#import "UIScrollView+QYRefresh.h"
#import <objc/message.h>
@implementation QYRefreshCompont
{
    BOOL _isLayoutSubviews;
    void(^_didLayoutSubviewsBlock)(void);
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.qy_h = 60;
        // 基本属性
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self setViews];
    if (_didLayoutSubviewsBlock) {
        _didLayoutSubviewsBlock();
    }
    _isLayoutSubviews = YES;
}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    
    [super willMoveToSuperview:newSuperview];
    
    if (newSuperview && ![newSuperview isKindOfClass:[UIScrollView class]]) return;
    [self removeObservers];
    if (newSuperview) {
        self.qy_x = 0;
        self.qy_w = newSuperview.qy_w;
        _scrollView = (UIScrollView *)newSuperview;
        _scrollView.alwaysBounceVertical = YES;
         _scrollViewDefaultInset = _scrollView.qy_contentInset;
        [self addObservers];
    }
    
}

#pragma mark- 添加监听
- (void)addObservers {
    
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:options context:nil];
    [self.scrollView addObserver:self forKeyPath:@"contentSize" options:options context:nil];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if (!self.userInteractionEnabled) return;
    
    if ([keyPath isEqualToString:@"contentOffset"]) {
        [self scrollViewContentOffsetDidChange:change];
    }
    
    if ([keyPath isEqualToString:@"contentSize"]) {
        [self scrollViewContentSizeDidChange:change];
    }
}

- (void)setViews{};
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change{}
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change{}


#pragma mark- 移除监听
- (void)removeObservers{
    
    [self.superview removeObserver:self forKeyPath:@"contentOffset"];
    [self.superview removeObserver:self forKeyPath:@"contentSize"];
}

#pragma mark- 开始进入刷新状态

- (void)beginRefreshing{
    if (!_isLayoutSubviews) {
        __weak typeof(self)weakSelf = self;
        _didLayoutSubviewsBlock = ^{
            weakSelf.state = QYRefreshingState;
        };
    }else{
        self.state = QYRefreshingState;
    }
}

#pragma mark- 结束刷新
- (void)endRefreshing{
    self.state = QYWillEndRefreshState;
}

#pragma mark- 调用刷新内部方法
- (void)executeRefreshingCallback{
    
    if (self.refreshingBlock) {
        self.refreshingBlock();
    }
    if (self.target && self.selector) {
        objc_msgSend(self.target, self.selector);
    }
}

@end
