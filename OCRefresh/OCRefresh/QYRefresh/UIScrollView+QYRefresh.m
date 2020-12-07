//
//  UIScrollView+QYRefresh.m
//  DiyRefresh
//
//  Created by sudiyang on 2018/11/19.
//  Copyright © 2018年 sudiyang. All rights reserved.
//

#import "UIScrollView+QYRefresh.h"
#import <objc/runtime.h>
#import "QYRefreshHeader.h"
#import "QYRefreshFooter.h"
@implementation UIScrollView (QYRefresh)

- (void)setQy_header:(QYRefreshHeader *)qy_header{
    if (qy_header != self.qy_header) {
        [self.qy_header removeFromSuperview];
        [self insertSubview:qy_header atIndex:0];
        objc_setAssociatedObject(self, @selector(qy_header), qy_header, OBJC_ASSOCIATION_ASSIGN);
    }
}
- (QYRefreshHeader *)qy_header{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setQy_footer:(QYRefreshFooter *)qy_footer{
    if (qy_footer != self.qy_footer) {
        [self.qy_footer removeFromSuperview];
        [self insertSubview:qy_footer atIndex:0];
        objc_setAssociatedObject(self, @selector(qy_footer), qy_footer, OBJC_ASSOCIATION_ASSIGN);
    }
}

- (QYRefreshFooter *)qy_footer{
    return objc_getAssociatedObject(self, _cmd);
}

- (UIEdgeInsets)qy_contentInset{
    if (@available(iOS 11.0, *)) {
        return self.adjustedContentInset;
    } else {
        return self.contentInset;
    }
}

- (void)setQy_contentInset:(UIEdgeInsets)qy_contentInset{
    self.contentInset = qy_contentInset;
}

- (CGFloat)qy_contentInsetBottom{
    if (@available(iOS 11.0, *)) {
        return self.adjustedContentInset.bottom;
    } else {
        return self.contentInset.bottom;
    }
}

- (void)setQy_contentInsetBottom:(CGFloat)qy_contentInsetBottom{
    UIEdgeInsets contentInset = self.qy_contentInset;
    contentInset.bottom = qy_contentInsetBottom;
    self.contentInset =  contentInset;
}

- (void)setQy_contentSizeHeight:(CGFloat)qy_contentSizeHeight{
    CGSize contentSize = self.contentSize;
    contentSize.height = qy_contentSizeHeight;
    self.contentSize = contentSize;
}

- (CGFloat)qy_contentSizeHeight{
    return self.contentSize.height;
}

- (void)setQy_contentInsetTop:(CGFloat)qy_contentInsetTop{
    UIEdgeInsets contentInset = self.qy_contentInset;
    contentInset.top = qy_contentInsetTop;
    self.contentInset =  contentInset;
}

- (CGFloat)qy_contentInsetTop{
    if (@available(iOS 11.0, *)) {
       return self.adjustedContentInset.top;
    } else {
       return self.contentInset.top;
    }
}

@end
