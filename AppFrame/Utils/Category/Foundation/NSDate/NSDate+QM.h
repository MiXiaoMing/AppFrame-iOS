//
//  NSDate+QM.h
//  Module
//

#import <Foundation/Foundation.h>

@interface NSDate (QM)

@property (readonly) NSInteger nearestHour; // 半个小时后的小时
@property (readonly) NSInteger hour; // 当前小时
@property (readonly) NSInteger minute; // 当前分钟
@property (readonly) NSInteger seconds; // 当前秒
@property (readonly) NSInteger day; // 当前天
@property (readonly) NSInteger month; // 当前月份
@property (readonly) NSInteger week; // 月包含的周数。
@property (readonly) NSInteger weekday; // 当前周几
@property (readonly) NSInteger nthWeekday; // 以7天为单位，范围为1-5 （1-7号为第1个7天，8-14号为第2个7天...）
@property (readonly) NSInteger year; // 当前年

#pragma mark - 类方法
/**
 获取当前时间
 */
+ (NSString *)getCurrenTimeWithFormat:(NSString *)format;
/**
 获取年，例2019
 */
+ (NSString *)getCurrentYear;
/**
 获取月，例07
 */
+ (NSString *)getCurrentMonth;
/**
 获取日，例23
 */
+ (NSString *)getCurrentDay;
/**
 获取星期，例星期一
 */
+ (NSString *)getCurrentWeek;
/**
 获取中国日期，例 正月初一
 */
+ (NSString *)getCurrentchineseDate;
/**
 明天日期date
 */
+ (NSDate*)dateTomorrow;
/**
 昨天日期date
 */
+ (NSDate*)dateYesterday;
/**
 当天日期后的几天日期date
 */
+ (NSDate*)dateWithDaysFromNow:(NSInteger)days;
/**
 当天日期前的几天日期date
 */
+ (NSDate*)dateWithDaysBeforeNow:(NSInteger)days;
/**
 当天日期后的几小时日期date
 */
+ (NSDate*)dateWithHoursFromNow:(NSInteger)dHours;
/**
 当天日期前的几小时日期date
 */
+ (NSDate*)dateWithHoursBeforeNow:(NSInteger)dHours;
/**
 当天日期后的几分钟日期date
 */
+ (NSDate*)dateWithMinutesFromNow:(NSInteger)dMinutes;
/**
 当天日期前的几分钟日期date
 */
+ (NSDate*)dateWithMinutesBeforeNow:(NSInteger)dMinutes;

#pragma mark - 实例方法
/**
 标准时，毫秒
 */
- (double)timeIntervalSince1970InMilliSecond;
/**
 当前日期对比另一日期是否相同，对比年月日
 */
- (BOOL)isEqualToDateIgnoringTime: (NSDate *) aDate;
/**
 当前日期是否为今天
 */
- (BOOL)isToday;
/**
 当前日期是否为明天
 */
- (BOOL)isTomorrow;
/**
 当前日期是否为昨天
 */
- (BOOL)isYesterday;
/**
 当前日期和另一日期是否有相同的周数
 */
- (BOOL)isSameWeekAsDate: (NSDate *) aDate;
/**
 当前日期是否为本周
 */
- (BOOL)isThisWeek;
/**
 当前日期是否为下一周
 */
- (BOOL)isNextWeek;
/**
 当前日期是否为上一周
 */
- (BOOL)isLastWeek;
/**
 当前日期和另一日期的年月是否有相同
 */
- (BOOL)isSameMonthAsDate: (NSDate *) aDate;
/**
 当前日期是否为本月
 */
- (BOOL)isThisMonth;
/**
 当前日期和另一日期的年是否相同
 */
- (BOOL)isSameYearAsDate: (NSDate *) aDate;
/**
 当前日期是否为本年
 */
- (BOOL)isThisYear;
/**
 当前日期是否为下一年
 */
- (BOOL)isNextYear;
/**
 当前日期是否为上一年
 */
- (BOOL)isLastYear;
/**
 当前日期是否在另一日期之前
 */
- (BOOL)isEarlierThanDate: (NSDate *) aDate;
/**
 当前日期是否在另一日期之后
 */
- (BOOL)isLaterThanDate: (NSDate *) aDate;
/**
 当前日期是否为未来
 */
- (BOOL)isInFuture;
/**
 当前日期是否为以前
 */
- (BOOL)isInPast;


/**
 当前日期是否是工作日
 */
- (BOOL)isTypicallyWorkday;
/**
 当前日期是否是休息日
 */
- (BOOL)isTypicallyWeekend;

// Adjusting dates
- (NSDate*)dateByAddingDays:(NSInteger)dDays;
- (NSDate*)dateBySubtractingDays:(NSInteger)dDays;
- (NSDate*)dateByAddingHours:(NSInteger)dHours;
- (NSDate*)dateBySubtractingHours:(NSInteger)dHours;
- (NSDate*)dateByAddingMinutes:(NSInteger)dMinutes;
- (NSDate*)dateBySubtractingMinutes:(NSInteger)dMinutes;
- (NSDate*)dateAtStartOfDay;

// Retrieving intervals
- (NSInteger)minutesAfterDate:(NSDate*)aDate;
- (NSInteger)minutesBeforeDate:(NSDate*)aDate;
- (NSInteger)hoursAfterDate:(NSDate*)aDate;
- (NSInteger)hoursBeforeDate:(NSDate*)aDate;
- (NSInteger)daysAfterDate:(NSDate*)aDate;
- (NSInteger)daysBeforeDate:(NSDate*)aDate;
- (NSInteger)distanceInDaysToDate:(NSDate*)anotherDate;


/**
 将date日期转换为字符串日期
 */
- (NSString *)dateToStringWithFormat:(NSString *)format;


@end
