//
//  NetworkHeader.h
//  AppFrame
//

#ifndef NetworkHeader_h
#define NetworkHeader_h

/**
 网络状态
 */
typedef NS_ENUM(NSInteger, QMNetworkStatus) {
    QMNetworkStatusUnknown             = 1 << 0,
    QMNetworkStatusNotReachable        = 1 << 1,
    QMNetworkStatusReachableViaWWAN    = 1 << 2,
    QMNetworkStatusReachableViaWiFi    = 1 << 3
};

typedef void(^ResponseSuccessBlock)(id response);

typedef void(^RequestCache)(id responseCache);

typedef void(^ResponseFailBlock)(NSError *error);

typedef void (^DownloadProgress)(int64_t bytesRead,
                                   int64_t totalBytes);

typedef void(^DownloadSuccessBlock)(NSString *url);

typedef void(^UploadProgressBlock)(int64_t bytesWritten,
                                     int64_t totalBytes);

typedef void(^QMNetworkStatusBlock)(QMNetworkStatus status);

typedef DownloadProgress GetProgress;

typedef DownloadProgress PostProgress;

typedef ResponseFailBlock DownloadFailBlock;


#endif /* NetworkHeader_h */
