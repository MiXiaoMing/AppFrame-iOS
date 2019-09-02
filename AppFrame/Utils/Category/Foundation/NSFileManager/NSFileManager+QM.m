//
//  NSFileManager+QM.m
//  Module
//

#import "NSFileManager+QM.h"

#define AMR_MAGIC_NUMBER "#!AMR\n"

@implementation NSFileManager (QM)

+ (BOOL)isFileExists:(NSString *)path {
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}

+ (BOOL)isTimeoutWithPath:(NSString *)path time:(NSTimeInterval)timeout {
    
    NSDictionary *info = [[NSFileManager defaultManager]
                          attributesOfItemAtPath:path error:nil];
    
    NSDate *creationDate = [info valueForKey:NSFileCreationDate];
    NSDate *currentDate = [NSDate date];
    
    return [currentDate timeIntervalSinceDate:creationDate] > timeout;
}

+ (BOOL)resetFinderWithPath:(NSString *)finderPath {
    
    BOOL ret = YES;
    
    ret &= [[NSFileManager defaultManager] removeItemAtPath:finderPath
                                                      error:nil];
    ret &= [[NSFileManager defaultManager] createDirectoryAtPath:finderPath
                                     withIntermediateDirectories:YES
                                                      attributes:nil
                                                           error:nil];
    return ret;
}

+ (BOOL)removeFileWithPath:(NSString *)filePath {
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return YES;
    }
    return [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
}

#pragma mark 单个文件的大小
+ (NSString *)fileSizeAtPath:(NSString*)filePath {
    
    NSFileManager* manager = [NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath:filePath]){
        
        double theSize = [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
        NSString *ret = nil;
        if (theSize<100) {
            ret = @"0.00B";
        } else if (theSize < 1024) {
            ret = [NSString stringWithFormat:@"%.2fB", theSize];
        } else if (theSize < 1024*1024) {
            ret = [NSString stringWithFormat:@"%.2fKB", theSize/1024];
        } else if (theSize < 1024*1024*1024) {
            ret = [NSString stringWithFormat:@"%.2fMB", theSize/(1024*1024)];
        } else {
            ret = [NSString stringWithFormat:@"%.2fGB", theSize/(1024*1024*1024)];
        }
        return ret;
    }
    return nil;
}

+ (BOOL)isAMR:(NSString*)audioPath
{
    NSData* data = [NSData dataWithContentsOfFile:audioPath];
    const char* rfile = [data bytes];
    if (rfile == nil) {
        return false;
    }
    // 检查amr文件头
    if (strncmp(rfile, AMR_MAGIC_NUMBER, strlen(AMR_MAGIC_NUMBER)) == 0)
    {
        return YES;
    }
    
    return NO;
}


@end
