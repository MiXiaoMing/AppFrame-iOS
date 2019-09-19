//
//  NetworkManagerSingle.h
//  NetworkManager
//

#import <Foundation/Foundation.h>
#import "QMNetworkHeader.h"
#import <UIKit/UIKit.h>


@interface QMNetworkManagerSingle : NSObject

+ (instancetype)shareInstance;
/**
 有网YES, 无网:NO
 */
+ (BOOL)isNetwork;

/**
 手机网络:YES, 反之:NO
 */
+ (BOOL)isWWANNetwork;

/**
 WiFi网络:YES, 反之:NO
 */
+ (BOOL)isWiFiNetwork;
/**
 实时获取网络状态,通过Block回调实时获取(此方法可多次调用)
 */
+ (void)networkStatusWithBlock:(QMNetworkStatusBlock)networkStatus;

/**
 取消所有请求
 */
- (void)cancleAllRequest;

/**
 检查网络状态
 */
- (void)checkNetworkStatus;
/**
 取消请求
 
 @param url url
 */
- (void)cancelRequestWithURL:(NSString *)url;

- (void)configRequestSerializer:(id)request;
- (void)configResponseSerializer:(id)response;
/**
 配置网络请求头
 */
- (void)configHttpSessionManagerHeaders:(NSDictionary *)configHeaders;

- (void)clearHeaders;
/**
 设置超时时间,默认20s
 
 @param timeout 超时时间
 */
- (void)setupTimeout:(NSTimeInterval)timeout;

/**
 GET请求
 
 @param url           请求路径
 @param params        拼接参数
 @param progressBlock 进度回调
 @param successBlock  成功回调
 @param failBlock     失败回调
 @return              返回的对象中可取消请求
 */
- (NSURLSessionTask *)getWithUrl:(NSString *)url
                          params:(NSDictionary *)params
                   progressBlock:(GetProgress)progressBlock
                    successBlock:(ResponseSuccessBlock)successBlock
                       failBlock:(ResponseFailBlock)failBlock;

/**
 POST请求
 
 @param url           请求路径
 @param params        拼接参数
 @param progressBlock 进度回调
 @param successBlock  成功回调
 @param failBlock     失败回调
 @return              返回的对象中可取消请求
 */
- (NSURLSessionTask *)postWithUrl:(NSString *)url
                           params:(NSDictionary *)params
                    progressBlock:(PostProgress)progressBlock
                     successBlock:(ResponseSuccessBlock)successBlock
                        failBlock:(ResponseFailBlock)failBlock;
/**
 文件上传
 
 @param url           上传文件接口地址
 @param parameters    请求参数
 @param name          文件对应服务器上的字段
 @param filePath      文件本地的沙盒路径
 @param progressBlock 上传文件进度
 @param successBlock  成功回调
 @param failBlock     失败回调
 @return              返回的对象中可取消请求
 */
- (NSURLSessionTask *)uploadFileWithUrl:(NSString *)url
                             parameters:(id)parameters
                                   name:(NSString *)name
                               filePath:(NSString *)filePath
                          progressBlock:(UploadProgressBlock)progressBlock
                           successBlock:(ResponseSuccessBlock)successBlock
                              failBlock:(ResponseFailBlock)failBlock;
/**
 文件下载
 
 @param url           下载文件接口地址
 @param fileDir       文件存储目录(默认存储目录为download)
 @param progressBlock 下载进度
 @param successBlock  成功回调
 @param failBlock     下载回调
 @return              返回的对象可取消请求
 */
- (NSURLSessionTask *)downloadWithUrl:(NSString *)url
                              fileDir:(NSString *)fileDir
                        progressBlock:(DownloadProgress)progressBlock
                         successBlock:(DownloadSuccessBlock)successBlock
                            failBlock:(DownloadFailBlock)failBlock;

/**
 *  上传单/多张图片
 *
 *  @param URL        请求地址
 *  @param parameters 请求参数
 *  @param name       图片对应服务器上的字段
 *  @param images     图片数组
 *  @param fileNames  图片文件名数组, 可以为nil, 数组内的文件名默认为当前日期时间"yyyyMMddHHmmss"
 *  @param imageScale 图片文件压缩比 范围 (0.f ~ 1.f)
 *  @param imageType  图片文件的类型,例:png、jpg(默认类型)....
 *  @param progress   上传进度信息
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
- (NSURLSessionTask *)uploadImagesWithURL:(NSString *)URL
                               parameters:(id)parameters
                                     name:(NSString *)name
                                   images:(NSArray<UIImage *> *)images
                                fileNames:(NSArray<NSString *> *)fileNames
                               imageScale:(CGFloat)imageScale
                                imageType:(NSString *)imageType
                                 progress:(DownloadProgress)progress
                                  success:(ResponseSuccessBlock)success
                                  failure:(ResponseFailBlock)failure;
@end

