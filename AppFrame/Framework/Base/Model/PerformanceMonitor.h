//
//  PerformanceMonitor.h
//  YunDian
//
//  Created by 87cn on 2020/3/13.
//  Copyright © 2020 edz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
/**性能监测工具，cpu,页面响应时间，内存，接口响应时间**/
@interface PerformanceMonitor : NSObject
//是否开启监听
@property (nonatomic,assign) BOOL   start;
//网络
@property (nonatomic,strong) NSMutableArray  *netArray;
//响应时间
@property (nonatomic,strong) NSMutableArray  *responceTimeArray;

/**时间响应记录字段**/
@property (nonatomic,strong) NSMutableDictionary  *timeDic;

/**定时器**/
@property (nonatomic,strong) CADisplayLink  *displayLink;

/**时间间隔**/
@property (nonatomic,assign) NSInteger   interval;
+ (instancetype)shareTools;

/**记录页面初始化时间**/
-(void)getVCBiginTime:(UIViewController *)vc;

/**获取页面响应的时间**/
-(void)getVCDurationTime:(UIViewController *)vc;


/**记录接口请求的时间**/
-(NSDictionary *)recordURLBeginWithUrl:(NSString *)url;
/**获取接口的响应时间**/
-(void)getUrlDurationTime:(NSDictionary *)dic;

/**获取页面本地存储的响应数据**/
-(NSArray *)getVCDurationList;
/**获取url本地存储的响应数据**/
-(NSArray *)getUrlDurationList;
/**获取内存，cpu本地存储数据**/
-(NSArray *)getCPUAndMemoryList;

-(NSString *)getNowTimeTimestamp3;
@end

NS_ASSUME_NONNULL_END
