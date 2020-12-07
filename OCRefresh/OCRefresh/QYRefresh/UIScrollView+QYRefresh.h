//
//  UIScrollView+QYRefresh.h
//  DiyRefresh
//
//  Created by sudiyang on 2018/11/19.
//  Copyright © 2018年 sudiyang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QYRefreshHeader;
@class QYRefreshFooter;
@interface UIScrollView (QYRefresh)
@property(nonatomic,assign)UIEdgeInsets qy_contentInset;
@property(nonatomic,assign)CGFloat qy_contentInsetBottom;
@property(nonatomic,assign)CGFloat qy_contentInsetTop;
@property(nonatomic,assign)CGFloat qy_contentSizeHeight;
@property(strong,nonatomic)QYRefreshHeader *qy_header;
@property(strong,nonatomic)QYRefreshFooter *qy_footer;
@end
