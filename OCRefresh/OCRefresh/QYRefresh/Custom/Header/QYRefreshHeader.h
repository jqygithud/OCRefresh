//
//  QYRefreshHeader.h
//  DiyRefresh
//
//  Created by sudiyang on 2018/11/19.
//  Copyright © 2018年 sudiyang. All rights reserved.
//

#import "QYRefreshCompont.h"



@interface QYRefreshHeader : QYRefreshCompont

+ (instancetype)headerWithRefreshingBlock:(QYComponentRefreshingBlock)refreshingBlock;

+ (instancetype)addHeaderWithRefreshingTarget:(id)target refreshingAction:(SEL)selector;

@end
