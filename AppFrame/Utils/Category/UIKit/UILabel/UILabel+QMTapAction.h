//
//  UILabel+QMTapAction.h
//  AFNetworking
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol QMTapActionDelegate <NSObject>
@optional
/**
 点击回调delegate
 */
- (void)TapActionReturnString:(NSString *)string range:(NSRange)range index:(NSInteger)index;
@end

/**
 点击回调block
 */
typedef void(^TapClickAction)(NSString *string , NSRange range , NSInteger index);

@interface UILabel (QMTapAction)
/**
 点击效果
 */
@property (nonatomic, assign) BOOL enabledTapEffect;

/**
 给文本添加点击事件Block回调
 */
- (void)addAttributeTapActionWithStrings:(NSArray <NSString *> *)strings
                              tapClicked:(TapClickAction)tapClick;

/**
 给文本添加点击事件delegate回调
 */
- (void)addAttributeTapActionWithStrings:(NSArray <NSString *> *)strings
                                delegate:(id <QMTapActionDelegate> )delegate;
@end

NS_ASSUME_NONNULL_END
