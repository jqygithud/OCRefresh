//
//  QYRefreshHeader.h
//  DiyRefresh
//
//  Created by jqy on 2018/11/19.
//  Copyright © 2018年 jqy. All rights reserved.
//

#import "QYRefreshCompont.h"



@interface QYRefreshHeader : QYRefreshCompont

+ (instancetype)headerWithRefreshingBlock:(QYComponentRefreshingBlock)refreshingBlock;

+ (instancetype)addHeaderWithRefreshingTarget:(id)target refreshingAction:(SEL)selector;

@end
