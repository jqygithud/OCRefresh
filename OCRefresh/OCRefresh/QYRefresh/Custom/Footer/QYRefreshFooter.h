//
//  QYRefreshFooter.h
//  DiyRefresh
//
//  Created by jqy on 2019/6/25.
//  Copyright © 2019 jqy. All rights reserved.
//

#import "QYRefreshCompont.h"

NS_ASSUME_NONNULL_BEGIN

@interface QYRefreshFooter : QYRefreshCompont

+ (instancetype)footerWithRefreshingBlock:(QYComponentRefreshingBlock)refreshingBlock;

+ (instancetype)addFooterWithRefreshingTarget:(id)target refreshingAction:(SEL)action;

@end

NS_ASSUME_NONNULL_END
