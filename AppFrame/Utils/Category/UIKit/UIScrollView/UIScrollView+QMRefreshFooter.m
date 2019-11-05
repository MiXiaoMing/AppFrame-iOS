//
//  UIScrollView+QMRefreshFooter.m
//  CaiFair_Mine
//
//  Created by edz on 2019/10/28.
//  Copyright © 2019 edz. All rights reserved.
//

#import "UIScrollView+QMRefreshFooter.h"
#import <objc/message.h>
#import <MJRefresh/MJRefresh.h>

static char countKey;

@implementation UIScrollView (QMRefreshFooter)

- (void)setCurrentPageCount:(NSInteger)currentPageCount {
    
    [self.mj_footer addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
    
    NSNumber *value = [NSNumber numberWithInteger:currentPageCount];
    objc_setAssociatedObject(self, &countKey, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger)currentPageCount {
    NSNumber *currentPageCount = objc_getAssociatedObject(self, &countKey);
    return [currentPageCount integerValue];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (object == self.mj_footer && [keyPath isEqualToString:@"frame"]) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        if (self.mj_footer.frame.origin.y < window.frame.size.height) {// footer在屏幕内隐藏
            self.mj_footer.hidden = YES;
        }
        else {
            self.mj_footer.hidden = NO;
            
            if (self.currentPageCount == 0) {// 当前请求数据为空（模型数组个数为0）显示全部加载
                [self.mj_footer endRefreshingWithNoMoreData];
            }
            else {// Normal状态
                [self.mj_footer endRefreshing];
            }
        }
    }
}

- (void)dealloc {
    if (self.currentPageCount) {
        [self.mj_footer removeObserver:self forKeyPath:@"frame"];
    }
}

@end
