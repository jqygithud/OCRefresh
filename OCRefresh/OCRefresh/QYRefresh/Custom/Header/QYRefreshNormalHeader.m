//
//  QYRefreshNormalHeader.m
//  DiyRefresh
//
//  Created by jqy on 2018/11/20.
//  Copyright © 2018年 jqy. All rights reserved.
//

#import "QYRefreshNormalHeader.h"
#import <AudioToolbox/AudioToolbox.h>
@interface QYRefreshNormalHeader ()
@property(nonatomic,strong)UIView *centerIcon;
@property(nonatomic,strong)UIView *leftIcon;
@property(nonatomic,strong)UIView *rightIcon;
@property(nonatomic,strong)UILabel *alertLabel;
@end

@implementation QYRefreshNormalHeader

#pragma mark -重写刷新状态
- (void)setState:(QYRefreshState)state{
   
    [super setState:state];
    if (state == QYWillEndRefreshState || state == QYDidEndRefreshState) {
        _alertLabel.text = @"下拉更新";
    }else if (state == QYPullingRefreshState){
        _alertLabel.text = @"松开更新";
        AudioServicesPlaySystemSound(1519);
    }else if (state == QYRefreshingState){
        _alertLabel.text = @"更新中";
        [self refreshingAnimate];
    }
}

- (void)refreshingAnimate{
    CGFloat duration = 0.4;
    CGFloat alpha = 0.3;
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:duration animations:^{
        weakSelf.leftIcon.alpha = alpha;
    } completion:^(BOOL finished) {
        weakSelf.leftIcon.alpha = 1;
        [UIView animateWithDuration:duration animations:^{
            weakSelf.centerIcon.alpha = alpha;
        } completion:^(BOOL finished) {
            weakSelf.centerIcon.alpha = 1;
            [UIView animateWithDuration:duration animations:^{
                weakSelf.rightIcon.alpha = alpha;
            }completion:^(BOOL finished) {
                weakSelf.rightIcon.alpha = 1;
                if (weakSelf.state == QYRefreshingState) {
                    [weakSelf refreshingAnimate];
                }
            }];
        }];
    }];
}


- (void)setViews{
    
    _centerIcon = [UIView.alloc init];
    _centerIcon.qy_w = QYFitWidth(9);
    _centerIcon.qy_h = QYFitWidth(9);
    _centerIcon.qy_centerX = self.qy_centerX;
    _centerIcon.qy_y = QYFitWidth(15);
    _centerIcon.layer.cornerRadius = _centerIcon.qy_h/2;
    _centerIcon.backgroundColor = [UIColor colorWithRed:0/255.0 green:183/255.0 blue:183/255.0 alpha:1];
    [self addSubview:_centerIcon];
    
    _leftIcon = [UIView.alloc init];
    _leftIcon.frame = _centerIcon.frame;
    _leftIcon.layer.cornerRadius = _leftIcon.qy_h/2;
    _leftIcon.backgroundColor = _centerIcon.backgroundColor;
    [self addSubview:_leftIcon];
    
    _rightIcon = [UIView.alloc init];
    _rightIcon.frame = _centerIcon.frame;
    _rightIcon.layer.cornerRadius = _leftIcon.qy_h/2;
    _rightIcon.backgroundColor = _centerIcon.backgroundColor;
    [self addSubview:_rightIcon];
    
    _alertLabel = [UILabel.alloc init];
    _alertLabel.qy_y = _centerIcon.qy_bottom + QYFitWidth(5);
    _alertLabel.qy_w = self.qy_w - QYFitWidth(20);
    _alertLabel.qy_centerX = _centerIcon.qy_centerX;
    _alertLabel.qy_h = QYFitWidth(20);
    _alertLabel.textColor = [UIColor colorWithRed:171/255.0 green:171/255.0 blue:171/255.0 alpha:1];
    _alertLabel.textAlignment = NSTextAlignmentCenter;
    _alertLabel.font = QYFitFont(13);
    [self addSubview:_alertLabel];
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change{
    [super scrollViewContentOffsetDidChange:change];
    
    CGFloat changeContentY = -(self.scrollView.contentOffset.y + self.scrollViewDefaultInset.top);
    CGFloat changCoordinate = _centerIcon.qy_w/(self.qy_h/changeContentY);
    if (changCoordinate < _centerIcon.qy_w*1.5) {
        _leftIcon.qy_right = _centerIcon.qy_x - changCoordinate;
        _rightIcon.qy_x = _centerIcon.qy_right + changCoordinate;
    }
}



@end
