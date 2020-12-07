//
//  UIView+QYFrame.m
//  DiyRefresh
//
//  Created by jqy on 2018/11/20.
//  Copyright © 2018年 jqy. All rights reserved.
//

#import "UIView+QYFrame.h"

@implementation UIView (QYFrame)

- (CGFloat)qy_x{
    
    return self.frame.origin.x;
}

- (void)setQy_x:(CGFloat)qy_x{
    CGRect frame = self.frame;
    frame.origin.x = qy_x;
    self.frame = frame;
}

- (CGFloat)qy_y{
    
    return self.frame.origin.y;
}

- (void)setQy_y:(CGFloat)qy_y{
    CGRect frame = self.frame;
    frame.origin.y = qy_y;
    self.frame = frame;
}

- (CGFloat)qy_w{
    
    return self.frame.size.width;
}

- (void)setQy_w:(CGFloat)qy_w{
    CGRect frame = self.frame;
    frame.size.width = qy_w;
    self.frame = frame;
}

- (CGFloat)qy_h{
    return self.frame.size.height;
}
- (void)setQy_h:(CGFloat)qy_h{
    CGRect frame = self.frame;
    frame.size.height = qy_h;
    self.frame = frame;
}

- (CGFloat)qy_right{
    return CGRectGetMaxX(self.frame);
}

- (void)setQy_right:(CGFloat)qy_right{
    CGRect frame = self.frame;
    frame.origin.x = qy_right - self.qy_w;
    self.frame = frame;
}

- (CGFloat)qy_centerX{
    return self.center.x;
}

- (void)setQy_centerX:(CGFloat)qy_centerX{
    CGPoint center = self.center;
    self.center = CGPointMake(qy_centerX, center.y);
}

- (CGFloat)qy_centerY{
    return self.center.y;
}

- (void)setQy_centerY:(CGFloat)qy_centerY{
    CGPoint center = self.center;
    self.center = CGPointMake(center.x, qy_centerY);
}

- (CGFloat)qy_bottom{
    return CGRectGetMaxY(self.frame);
}

- (void)setQy_bottom:(CGFloat)qy_bottom{
    CGRect frame = self.frame;
    frame.origin.y = qy_bottom - self.qy_h;
    self.frame = frame;
}

- (CGSize)qy_size{
    return self.frame.size;
}

- (void)setQy_size:(CGSize)qy_size{
    CGRect frame = self.frame;
    frame.size = qy_size;
    self.frame = frame;
}

@end
