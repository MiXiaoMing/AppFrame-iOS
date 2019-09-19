//
//  JXNetworkManagerSingle.m
//  JXNetworkManager
//

#import "QMNetworkManagerSingle.h"
#import "AFNetworking.h"
#define ERROR_IMFORMATION @"网络出现错误，请检查网络连接"

#define ERROR [NSError errorWithDomain:@"Networking.ErrorDomain" code:-1009 userInfo:@{ NSLocalizedDescriptionKey:ERROR_IMFORMATION}]

@interface QMNetworkManagerSingle ()

@property (nonatomic, strong) AFHTTPSessionManager *httpSessionManager;
@property (nonatomic, assign) QMNetworkStatus  networkStatus;

@property (nonatomic, strong) NSDictionary     *headers;
@property (nonatomic, strong) NSMutableArray   *requestTasksPool;
@property (nonatomic, assign) NSTimeInterval   requestTimeout;

@end

@implementation QMNetworkManagerSingle

static QMNetworkManagerSingle *sharedSingleton = nil;
static dispatch_once_t onceAllocToken;
static dispatch_once_t onceInitToken;

+ (instancetype)shareInstance
{
    return [[self alloc] init];
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    if (sharedSingleton == nil) {
        dispatch_once(&onceAllocToken, ^{
            sharedSingleton = [super allocWithZone:zone];
        });
    }
    return sharedSingleton;
}

- (instancetype)init
{
    dispatch_once(&onceInitToken, ^{
        sharedSingleton = [super init];
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        sessionConfiguration.allowsCellularAccess = YES;
        sessionConfiguration.HTTPMaximumConnectionsPerHost = 4;
        sharedSingleton.httpSessionManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:sessionConfiguration];
        
        sharedSingleton.requestTimeout = 20;
        [sharedSingleton configRequestSerializer:nil];
        [sharedSingleton configResponseSerializer:nil];
    });
    return sharedSingleton;
}
- (id)copy
{
    return self;
}

- (id)mutableCopy
{
    return self;
}

+ (BOOL)isNetwork
{
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

+ (BOOL)isWWANNetwork
{
    return [AFNetworkReachabilityManager sharedManager].reachableViaWWAN;
}

+ (BOOL)isWiFiNetwork
{
    return [AFNetworkReachabilityManager sharedManager].reachableViaWiFi;
}

+ (void)networkStatusWithBlock:(QMNetworkStatusBlock)networkStatus
{
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                
                networkStatus ? networkStatus(QMNetworkStatusUnknown) : nil;
                break;
            case AFNetworkReachabilityStatusNotReachable:
                
                networkStatus ? networkStatus(QMNetworkStatusNotReachable) : nil;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                
                networkStatus ? networkStatus(QMNetworkStatusReachableViaWWAN) : nil;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                
                networkStatus ? networkStatus(QMNetworkStatusReachableViaWiFi) : nil;
                break;
        }
    }];
}
- (void)cancleAllRequest {
    @synchronized (self) {
        [[self allTasks] enumerateObjectsUsingBlock:^(NSURLSessionTask  *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[NSURLSessionTask class]]) {
                [obj cancel];
            }
        }];
        [[self allTasks] removeAllObjects];
    }
}

- (void)cancelRequestWithURL:(NSString *)url {
    if (!url) return;
    @synchronized (self) {
        [[self allTasks] enumerateObjectsUsingBlock:^(NSURLSessionTask * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[NSURLSessionTask class]]) {
                if ([obj.currentRequest.URL.absoluteString hasSuffix:url]) {
                    [obj cancel];
                    *stop = YES;
                }
            }
        }];
    }
}

- (void)configRequestSerializer:(id)request
{
    AFJSONRequestSerializer *requestSerializer;
    if ([request isKindOfClass:[AFHTTPRequestSerializer class]]) {
        requestSerializer = request;
    }else
    {
        requestSerializer = [AFJSONRequestSerializer serializer];
        requestSerializer.stringEncoding = NSUTF8StringEncoding;
        requestSerializer.timeoutInterval = self.requestTimeout;
    }
    self.httpSessionManager.requestSerializer = requestSerializer;
}
- (void)configResponseSerializer:(id)response
{
    AFJSONResponseSerializer *responseSerializer;
    if ([response isKindOfClass:[AFHTTPResponseSerializer class]]) {
        responseSerializer = response;
    }else
    {
        responseSerializer = [AFJSONResponseSerializer serializer];
        responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                          @"text/html",
                                                                          @"text/json",
                                                                          @"text/plain",
                                                                          @"text/javascript",
                                                                          @"text/xml",
                                                                          @"image/*",
                                                                          @"application/octet-stream",
                                                                          @"application/zip"]];
    }
    [responseSerializer setRemovesKeysWithNullValues:YES];
    self.httpSessionManager.responseSerializer = responseSerializer;
}

- (void)configHttpSessionManagerHeaders:(NSDictionary *)configHeaders
{
    self.headers = [NSDictionary dictionaryWithDictionary:configHeaders];
    if (self.headers.count != 0) {
        for (NSString *headerField in self.headers.keyEnumerator) {
            [self.httpSessionManager.requestSerializer setValue:self.headers[headerField] forHTTPHeaderField:headerField];
        }
    }
}
- (void)clearHeaders
{
    [self.httpSessionManager.requestSerializer clearAuthorizationHeader];
}
- (void)setupTimeout:(NSTimeInterval)timeout
{
    self.requestTimeout = timeout;
    if (self.self.httpSessionManager.requestSerializer) {
        self.httpSessionManager.requestSerializer.timeoutInterval = self.requestTimeout;
    }
}

- (NSURLSessionTask *)getWithUrl:(NSString *)url
                          params:(NSDictionary *)params
                   progressBlock:(GetProgress)progressBlock
                    successBlock:(ResponseSuccessBlock)successBlock
                       failBlock:(ResponseFailBlock)failBlock
{
    __block NSURLSessionTask *session = nil;
    
    if (self.networkStatus == QMNetworkStatusNotReachable) {
        if (failBlock) failBlock(ERROR);
        return session;
    }
    session = [self.httpSessionManager GET:url
                                parameters:params
               //                                   headers:self.headers
                                  progress:^(NSProgress * _Nonnull downloadProgress) {
                                      if (progressBlock) progressBlock(downloadProgress.completedUnitCount,
                                                                       downloadProgress.totalUnitCount);
                                  } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                      if (successBlock) successBlock(responseObject);
                                      [[self allTasks] removeObject:session];
                                  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                      if (error.code == -999 && [error.localizedDescription isEqualToString:@"cancelled"]) {
                                          //                           NSLog(@"取消网络请求");
                                      }else
                                      {
                                          if (failBlock) failBlock(error);
                                      }
                                      [[self allTasks] removeObject:session];
                                  }];
    
    //    if ([self haveSameRequestInTasksPool:session]) {
    //
    //        [session cancel];
    //        return session;
    //    }else {
    //        if (session) [[self allTasks] addObject:session];
    //        [session resume];
    //        return session;
    //    }
    
    NSURLSessionTask *oldTask = [self cancleSameRequestInTasksPool:session];
    if (oldTask) {
        //        NSLog(@"进入");
        [oldTask cancel];
        [[self allTasks] removeObject:oldTask];
    }
    if (session) [[self allTasks] addObject:session];
    [session resume];
    
    return session;
}

- (NSURLSessionTask *)postWithUrl:(NSString *)url
                           params:(NSDictionary *)params
                    progressBlock:(PostProgress)progressBlock
                     successBlock:(ResponseSuccessBlock)successBlock
                        failBlock:(ResponseFailBlock)failBlock
{
    __block NSURLSessionTask *session = nil;
    
    if (self.networkStatus == QMNetworkStatusNotReachable) {
        if (failBlock) failBlock(ERROR);
        return session;
    }
    
    session = [self.httpSessionManager POST:url
                                 parameters:params
               //                                    headers:self.headers
                                   progress:^(NSProgress * _Nonnull uploadProgress) {
                                       if (progressBlock) progressBlock(uploadProgress.completedUnitCount,
                                                                        uploadProgress.totalUnitCount);
                                   } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                       if (successBlock) successBlock(responseObject);
                                       
                                       [[self allTasks] removeObject:session];
                                   } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                       if (error.code == -999 && [error.localizedDescription isEqualToString:@"cancelled"]) {
                                           //            NSLog(@"取消网络请求");
                                       }else
                                       {
                                           if (failBlock) failBlock(error);
                                       }
                                       [[self allTasks] removeObject:session];
                                   }];
    
    //    if ([self haveSameRequestInTasksPool:session]) {
    //        [session cancel];
    //        return session;
    //    }else {
    //        if (session) [[self allTasks] addObject:session];
    //        [session resume];
    //        return session;
    //    }
    
    NSURLSessionTask *oldTask = [self cancleSameRequestInTasksPool:session];
    if (oldTask) {
        [oldTask cancel];
        [[self allTasks] removeObject:oldTask];
    }
    if (session) [[self allTasks] addObject:session];
    [session resume];
    
    return session;
}

- (NSURLSessionTask *)uploadFileWithUrl:(NSString *)url
                             parameters:(id)parameters
                                   name:(NSString *)name
                               filePath:(NSString *)filePath
                          progressBlock:(UploadProgressBlock)progressBlock
                           successBlock:(ResponseSuccessBlock)successBlock
                              failBlock:(ResponseFailBlock)failBlock
{
    __block NSURLSessionTask *session = nil;
    
    if (self.networkStatus == QMNetworkStatusNotReachable) {
        if (failBlock) failBlock(ERROR);
        return session;
    }
    
    session = [self.httpSessionManager POST:url
                                 parameters:parameters
               //                                    headers:self.headers
                  constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                      NSError *error = nil;
                      [formData appendPartWithFileURL:[NSURL URLWithString:filePath] name:name error:&error];
                      (failBlock && error) ? failBlock(error) : nil;
                      
                  } progress:^(NSProgress * _Nonnull uploadProgress) {
                      if (progressBlock) progressBlock (uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);
                  } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                      if (successBlock) successBlock(responseObject);
                      [[self allTasks] removeObject:session];
                      [self.httpSessionManager.session finishTasksAndInvalidate];
                  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                      if (failBlock) failBlock(error);
                      [self.httpSessionManager.session finishTasksAndInvalidate];
                      [[self allTasks] removeObject:session];
                  }];
    
    [session resume];
    
    if (session) [[self allTasks] addObject:session];
    
    return session;
}


- (NSURLSessionTask *)downloadWithUrl:(NSString *)url
                              fileDir:(NSString *)fileDir
                        progressBlock:(DownloadProgress)progressBlock
                         successBlock:(DownloadSuccessBlock)successBlock
                            failBlock:(DownloadFailBlock)failBlock {
    __block NSURLSessionTask *session = nil;
    
    self.httpSessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    session = [self.httpSessionManager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progressBlock) progressBlock(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSString *downloadDir;
        downloadDir = fileDir;
        NSString *filePath = [downloadDir stringByAppendingPathComponent:response.suggestedFilename];
        return [NSURL URLWithString:filePath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        [self.httpSessionManager.session finishTasksAndInvalidate];
        [[self allTasks] removeObject:session];
        if(failBlock && error) {failBlock(error) ; return ;};
        successBlock ? successBlock(filePath.absoluteString /** NSURL->NSString*/) : nil;
    }];
    [session resume];
    if (session) [[self allTasks] addObject:session];
    
    return session;
}

- (NSURLSessionTask *)uploadImagesWithURL:(NSString *)URL
                               parameters:(id)parameters
                                     name:(NSString *)name
                                   images:(NSArray<UIImage *> *)images
                                fileNames:(NSArray<NSString *> *)fileNames
                               imageScale:(CGFloat)imageScale
                                imageType:(NSString *)imageType
                                 progress:(DownloadProgress)progress
                                  success:(ResponseSuccessBlock)success
                                  failure:(ResponseFailBlock)failure
{
    __block NSURLSessionTask *session = nil;
    
    if (self.networkStatus == QMNetworkStatusNotReachable) {
        if (failure) failure(ERROR);
        return session;
    }
    
    session = [self.httpSessionManager POST:URL
                                 parameters:parameters
               //                                    headers:self.headers
                  constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                      for (int i = 0; i < images.count; i++) {
                          NSData *imageData = UIImageJPEGRepresentation(images[i], imageScale ?: 1.f);
                          
                          NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                          formatter.dateFormat = @"yyyyMMddHHmmss";
                          NSString *str = [formatter stringFromDate:[NSDate date]];
                          NSString *imageFileName = [NSString stringWithFormat:@"%@%d.%@",str,i,imageType?nil:@"jpg"];
                          
                          [formData appendPartWithFileData:imageData
                                                      name:name
                                                  fileName:fileNames ? [NSString stringWithFormat:@"%@.%@",fileNames[i],imageType?:@"jpg"] : imageFileName
                                                  mimeType:[NSString stringWithFormat:@"image/%@",imageType ?: @"jpg"]];
                      }
                  } progress:^(NSProgress * _Nonnull uploadProgress) {
                      dispatch_sync(dispatch_get_main_queue(), ^{
                          if (progress) progress (uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);
                      });
                  } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                      if (success) success(responseObject);
                      [self.httpSessionManager.session finishTasksAndInvalidate];
                      [[self allTasks] removeObject:session];
                  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                      if (failure) failure(error);
                      [self.httpSessionManager.session finishTasksAndInvalidate];
                      [[self allTasks] removeObject:session];
                  }];
    
    [session resume];
    
    if (session) [[self allTasks] addObject:session];
    
    return session;
}

// 检查网络
- (void)checkNetworkStatus {
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    [manager startMonitoring];
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
                self.networkStatus = QMNetworkStatusNotReachable;
                break;
            case AFNetworkReachabilityStatusUnknown:
                self.networkStatus = QMNetworkStatusUnknown;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                self.networkStatus = QMNetworkStatusReachableViaWWAN;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                self.networkStatus = QMNetworkStatusReachableViaWiFi;
                break;
            default:
                self.networkStatus = QMNetworkStatusUnknown;
                break;
        }
    }];
}

- (BOOL)haveSameRequestInTasksPool:(NSURLSessionTask *)task {
    __block BOOL isSame = NO;
    [[self allTasks] enumerateObjectsUsingBlock:^(NSURLSessionTask *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([task.originalRequest isTheSameRequest:obj.originalRequest]) {
            isSame  = YES;
            *stop = YES;
        }
    }];
    return isSame;
}

- (NSURLSessionTask *)cancleSameRequestInTasksPool:(NSURLSessionTask *)task {
    __block NSURLSessionTask *oldTask = nil;
    
    [[self allTasks] enumerateObjectsUsingBlock:^(NSURLSessionTask *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([task.originalRequest isTheSameRequest:obj.originalRequest]) {
            if (obj.state == NSURLSessionTaskStateRunning) {
                [obj cancel];
                oldTask = obj;
            }
            *stop = YES;
        }
    }];
    
    return oldTask;
}

#pragma mark - lazy load
- (NSMutableArray *)allTasks {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (self.requestTasksPool == nil) self.requestTasksPool = [NSMutableArray array];
    });
    
    return self.requestTasksPool;
}

@end
