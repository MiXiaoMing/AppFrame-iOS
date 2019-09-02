//
//  NSFileManager+QM.h
//  Module
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSFileManager (QM)

#pragma mark - 类方法
/**
 判断文件是否存在
 @param path 文件路径
 @return YES:文件存在. NO:不存在.
 */
+ (BOOL)isFileExists:(NSString *)path;

/**
 计算指定路径下得文件是否超过了规定时间
 @param path 文件路径
 @param timeout 设定的超时时间
 @return YES:超时. NO:没超时
 */
+ (BOOL)isTimeoutWithPath:(NSString *)path time:(NSTimeInterval)timeout;

/**
 重置文件夹
 @param finderPath 文件路径
 @return YES:重置成功. NO:重置失败.
 */
+ (BOOL)resetFinderWithPath:(NSString *)finderPath;

/**
 删除文件
 @param filePath 文件路径
 @return YES:删除成功. NO:删除失败
 */
+ (BOOL)removeFileWithPath:(NSString *)filePath;

/**
 获取单个文件的大小
 @param filePath 文件路径
 @return 文件大小
 */
+ (NSString *)fileSizeAtPath:(NSString*)filePath;

/**
 根据音频文件二进制流判断是否是amr格式音频
 */
+ (BOOL)isAMR:(NSString*)audioPath;



@end
