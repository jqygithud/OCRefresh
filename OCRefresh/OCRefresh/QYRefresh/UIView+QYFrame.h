//
//  UIView+QYFrame.h
//  DiyRefresh
//
//  Created by jqy on 2018/11/20.
//  Copyright © 2018年 jqy. All rights reserved.
//

#import <UIKit/UIKit.h>
#define QYScreenWidth  [UIScreen mainScreen].bounds.size.width
#define QYScreenHeight   [UIScreen mainScreen].bounds.size.height
#define QYScaleW ((QYScreenWidth > QYScreenHeight ? QYScreenHeight : QYScreenWidth)/375.0)
#define QYFitWidth(w)  QYScaleW*w
#define QYFitFont(font) [UIFont systemFontOfSize:QYScaleW*font]

@interface UIView (QYFrame)

@property(nonatomic,assign) CGFloat qy_x;
@property(nonatomic,assign) CGFloat qy_y;
@property(nonatomic,assign) CGFloat qy_w;
@property(nonatomic,assign) CGFloat qy_h;
@property(nonatomic,assign) CGFloat qy_centerX;
@property(nonatomic,assign) CGFloat qy_centerY;
@property(nonatomic,assign) CGFloat qy_right;
@property(nonatomic,assign) CGFloat qy_bottom;
@property(nonatomic,assign) CGSize qy_size;

@end
