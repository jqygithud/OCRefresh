//
//  QYRefreshCompont.h
//  DiyRefresh
//
//  Created by jqy on 2018/11/19.
//  Copyright © 2018年 jqy. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 刷新状态 */
#define  QYRefreshCheckState \
         QYRefreshState oldState = self.state;\
         if (state == oldState) return;\
         [super setState:state];

#import "UIView+QYFrame.h"

/** 刷新状态 */
typedef NS_ENUM(NSInteger,QYRefreshState) {
    
    /** 已经结束刷新状态 **/
    QYDidEndRefreshState = 0,
    /** 即将结束刷新 */
    QYWillEndRefreshState,
    /** 松手就能刷新 */
    QYPullingRefreshState,
    /** 正在刷新 */
    QYRefreshingState,
    /** 数据加载完毕 **/
    QYNoMoreDataState
};

/** 进入刷新回调 */
typedef void(^QYComponentRefreshingBlock)(void);

@interface QYRefreshCompont : UIView

{
    /** 记录scrollView刚开始的inset */
    UIEdgeInsets _scrollViewDefaultInset;
    
    /** 记录scrollView默认的offset*/
    CGPoint _scrollViewDefaultOffset;
    
    /** 父视图scrollView */
    __weak UIScrollView *_scrollView;
    
}

@property(nonatomic,weak,readonly)UIScrollView *scrollView; //

/** 记录scrollView默认的inset*/
@property(nonatomic,assign)UIEdgeInsets scrollViewDefaultInset;

/** 记录scrollView默认的offset*/
@property(nonatomic,assign,readonly)CGPoint scrollViewDefaultOffset;

/** 刷新状态 */
@property(nonatomic,assign)QYRefreshState state;

- (void)setViews;
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change;
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change;

/** 开始刷新 */
- (void)beginRefreshing;

/** 结束刷新 */
- (void)endRefreshing;

/** 刷新事件 */
@property(nonatomic,copy)QYComponentRefreshingBlock refreshingBlock;
@property(nonatomic)id target;
@property(nonatomic)SEL selector;


/**触发刷新事件 */
- (void)executeRefreshingCallback;




@end
