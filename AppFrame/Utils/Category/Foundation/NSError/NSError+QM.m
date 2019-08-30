//
//  NSError+QM.m
//  AppFrame
//

#import "NSError+QM.h"

@implementation NSError (QM)

+ (NSError *)errorWithCode:(NSInteger)code errorMessage:(NSString*)errorMsg
{
    NSMutableDictionary* userInfo = [[NSMutableDictionary alloc] initWithCapacity:2];
    [userInfo setObject:[NSString stringWithFormat:@"%ld", (long)code] forKey:@"errorCode"];
    if (errorMsg)
    {
        [userInfo setObject:errorMsg ? errorMsg : @"" forKey:@"errorMsg"];
    }
    NSError *error = [NSError errorWithDomain:@"DingDing" code:code userInfo:userInfo];
    return error;
}

- (NSInteger)errorCode
{
    return self.code;
}

- (NSString*)errorMsg
{
    NSString* errorMsg = nil;
    errorMsg = [self.userInfo objectForKey:@"errorMsg"];
    
    if (nil == errorMsg)
    {
        if (NSOrderedSame == [self.domain compare:@"NSURLErrorDomain"])
        {
            switch (self.code)
            {
                case NSURLErrorNotConnectedToInternet:
                    errorMsg = @"网络连接失败，请稍候再试";
                    break;
                case NSURLErrorTimedOut:
                    errorMsg = @"连接超时";
                    break;
                case kCFURLErrorCancelled:
                    errorMsg = @"网络连接失败，请稍候再试";
                    break;
                case kCFURLErrorCannotFindHost:
                    errorMsg = @"连接服务器失败，请检查网络试试";
                    break;
                default:
                    // 更改默认服务器出错提示
                    errorMsg = @"服务器君出海去找One Piece啦~~";
                    break;
            }
        }
        else
        {
            errorMsg = @"未知错误";
        }
    }
    
    return errorMsg;
}

@end
