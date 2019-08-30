//
//  NetworkHeader.h
//  AppFrame
//

#ifndef NetworkHeader_h
#define NetworkHeader_h

/**
 网络状态
 */
typedef NS_ENUM(NSInteger, NetworkStatus) {
    NetworkStatusUnknown             = 1 << 0,
    NetworkStatusNotReachable        = 1 << 1,
    NetworkStatusReachableViaWWAN    = 1 << 2,
    NetworkStatusReachableViaWiFi    = 1 << 3
};

typedef void(^ResponseSuccessBlock)(id response);

typedef void(^RequestCache)(id responseCache);

typedef void(^ResponseFailBlock)(NSError *error);

typedef void (^DownloadProgress)(int64_t bytesRead,
                                   int64_t totalBytes);

typedef void(^DownloadSuccessBlock)(NSString *url);

typedef void(^UploadProgressBlock)(int64_t bytesWritten,
                                     int64_t totalBytes);

typedef void(^NetworkStatusBlock)(NetworkStatus status);

typedef DownloadProgress GetProgress;

typedef DownloadProgress PostProgress;

typedef ResponseFailBlock DownloadFailBlock;

@interface NSURLRequest (Decide)

- (BOOL)isTheSameRequest:(NSURLRequest *)request;

@end

@implementation NSURLRequest (Decide)

- (BOOL)isTheSameRequest:(NSURLRequest *)request {
    if ([self.HTTPMethod isEqualToString:request.HTTPMethod]) {
        if ([self.URL.absoluteString isEqualToString:request.URL.absoluteString]) {
            if ([self.HTTPMethod isEqualToString:@"GET"]||[self.HTTPBody isEqualToData:request.HTTPBody]) {
                return YES;
            }
        }
    }
    return NO;
}

@end

#endif /* NetworkHeader_h */
