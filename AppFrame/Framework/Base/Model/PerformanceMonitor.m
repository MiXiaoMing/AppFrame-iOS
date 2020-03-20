//
//  PerformanceMonitor.m
//  YunDian
//
//  Created by 87cn on 2020/3/13.
//  Copyright © 2020 edz. All rights reserved.
//

#import "PerformanceMonitor.h"
#import <mach/mach.h>
#import <sys/time.h>

static PerformanceMonitor *tools = nil;
@implementation PerformanceMonitor
+ (instancetype)shareTools
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (tools==nil) {
            tools = [[self alloc] init];
        }
    });
    return tools;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self initArray];
        self.interval = 60;
        self.start = NO;
    }
    return self;
}

-(void)initArray{
    if (_netArray == nil) {
        _netArray = [[NSMutableArray alloc]init];
    }
    if (_responceTimeArray == nil) {
        _responceTimeArray = [[NSMutableArray alloc]init];
    }
    
    if (_timeDic==nil) {
        _timeDic = [[NSMutableDictionary alloc]init];
    }
}


-(void)setStart:(BOOL)start{
    _start = start;
    if (start==YES) {
        [self creatRunLoopLink];
    }else{
        [self closeDisplay];
    }
    
}

-(void)closeDisplay{
    
    //销毁
    if (_displayLink) {
        [_displayLink invalidate];
        _displayLink = nil;
    }
    
}

-(void)creatRunLoopLink{
    //return;
    if (self.displayLink == nil) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(repeatRecord)];
        _displayLink.frameInterval = self.interval;
         [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
    
    
}

-(void)repeatRecord{
    [self saveMonitorCPUAndMemoryLog];//cpu与内存检测
    
}

- (NSString *)taskDescription:(id)objects{
    return [NSString stringWithFormat:@"%p", objects];
}

/**记录页面初始化时间**/
-(void)getVCBiginTime:(UIViewController *)vc{
    if (self.start ==NO) {
        return;
    }
     NSLog(@"currentMonitorClass^^%@  ", NSStringFromClass([vc class]));
    NSDate *date = [NSDate date];
    NSString *keyss=[self taskDescription:vc];
    [_timeDic setValue:date forKey:keyss];
}
/**获取页面响应的时间**/
-(void)getVCDurationTime:(UIViewController *)vc{
    if (self.start ==NO) {
           return;
       }
    
    NSString *keyss=[self taskDescription:vc];
    NSDate *date =[_timeDic objectForKey:keyss];
    if (!date) {
        return;
    }
    NSTimeInterval duration = [[NSDate date] timeIntervalSinceDate:date];
    NSString *durationS=[NSString stringWithFormat:@"%g",duration];
    [_timeDic removeObjectForKey:keyss];
    [self saveMonitorLogVC:NSStringFromClass([vc class]) duration:durationS];
}



/**记录接口请求的时间**/
-(NSDictionary *)recordURLBeginWithUrl:(NSString *)url{
    if (self.start ==NO) {
      return nil;
    }
    if (url.length<=0) {
        return nil;
    }
    
    NSDate *date = [NSDate date];
    NSMutableDictionary *dic=[NSMutableDictionary new];
    [dic setValue:date forKey:@"date"];
    [dic setValue:url forKey:@"url"];
    return dic;
}
/**获取接口的响应时间**/
-(void)getUrlDurationTime:(NSDictionary *)dic{
    
    if (self.start ==NO) {
        return;
     }
    
    if (dic==nil) {
        return;
    }
    NSDate *date =[dic objectForKey:@"date"];
    NSTimeInterval duration = [[NSDate date] timeIntervalSinceDate:date];
    NSString *durationS=[NSString stringWithFormat:@"%g",duration];
    NSString *url=dic[@"url"];
    
    [self saveMonitorLogURL:url duration:durationS];
}

//接口响应时间
- (void)saveMonitorLogURL:(NSString *)url duration:(NSString *)duration{
    struct tm* timeNow = [PerformanceMonitor getCurTime];
    NSString *monitorLog = [NSString stringWithFormat:@"%d-%d-%d %d:%d:%d.%ld",
                            timeNow->tm_year,
                            timeNow->tm_mon,
                            timeNow->tm_mday,
                            timeNow->tm_hour,
                            timeNow->tm_min,
                            timeNow->tm_sec,
                            timeNow->tm_gmtoff];
    NSLog(@"%@\n:url:%@ \n:duration:%@",monitorLog,url,duration);
    monitorLog = [self getNowTimeTimestamp3];
    [self saveUrl:url time:duration recordTime:monitorLog];//本地存储
}

//界面的响应时间
- (void)saveMonitorLogVC:(NSString *)vcName duration:(NSString *)duration{
    struct tm* timeNow = [PerformanceMonitor getCurTime];
    NSString *monitorLog = [NSString stringWithFormat:@"%d-%d-%d %d:%d:%d.%ld",
                            timeNow->tm_year,
                            timeNow->tm_mon,
                            timeNow->tm_mday,
                            timeNow->tm_hour,
                            timeNow->tm_min,
                            timeNow->tm_sec,
                            timeNow->tm_gmtoff
                            ];
    NSLog(@"%@:%@ - %@",monitorLog,vcName,duration);
    //数据存储本地
    monitorLog = [self getNowTimeTimestamp3];
    [self saveVC:vcName time:duration recordTime:monitorLog];
   // [self getCurrentBatteryLevel];
}

/**cup与缓存*/
- (void)saveMonitorCPUAndMemoryLog{
   
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
         float cpuUsage = [PerformanceMonitor cpuUsage];
          float memoryUsage = [PerformanceMonitor memoryUsage];
          struct tm* timeNow = [PerformanceMonitor getCurTime];
        NSString *monitorLog = [NSString stringWithFormat:@"%d-%d-%d %d:%d:%d.%ld | cpu 使用率:%.2f ----内存使用:%f\n",
                                     timeNow->tm_year,
                                     timeNow->tm_mon,
                                     timeNow->tm_mday,
                                     timeNow->tm_hour,
                                     timeNow->tm_min,
                                     timeNow->tm_sec,
                                     timeNow->tm_gmtoff,
                                     cpuUsage,
                                     memoryUsage];
        NSString *recordTime= [self getNowTimeTimestamp3];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //返回主线程存储数据
            
            [self saveCPU:[NSString stringWithFormat:@"%.3f",cpuUsage] memorys:[NSString stringWithFormat:@"%.3f",memoryUsage] recordTime:recordTime];
           // [self saveMemory:[NSString stringWithFormat:@"%.3f",memoryUsage] recordTime:recordTime];
        });
             
      });
}


/**
 本地保存类响应时间信息

 @param vcName 类名
 @param duration 响应时间
 @param recordTime 记录时间
 */
- (void)saveVC:(NSString *)vcName time:(NSString *)duration recordTime:(NSString *)recordTime {
    if (vcName.length<=0||duration.length<=0||recordTime.length<=0) {
        return;
    }
    NSString *filePatch = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"VCResponseList.plist"];
    
    NSMutableArray *array =[[NSMutableArray alloc] initWithContentsOfFile:filePatch];
    
    if (!array) {
        array = [NSMutableArray array];
    }
    
    NSDictionary *toDict = @{@"name":vcName,
                            @"duration":duration,
                            @"recordTime":recordTime
                            };

    if (![array containsObject:toDict]) {
        [array addObject:toDict];
        [array writeToFile:filePatch atomically:true];
    }

}


/**
 本地保存接口响应时间信息

 @param url 接口
 @param duration 响应时间
 @param recordTime 记录时间
 */
- (void)saveUrl:(NSString *)url time:(NSString *)duration recordTime:(NSString *)recordTime {

    if (url.length<=0||duration.length<=0||recordTime.length<=0) {
        return;
    }
    NSString *filePatch = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"URLResponseList.plist"];
    
    NSMutableArray *array =[[NSMutableArray alloc] initWithContentsOfFile:filePatch];
    
    if (!array) {
        array = [NSMutableArray array];
    }
    
    NSDictionary *toDict = @{@"name":url,
                            @"duration":duration,
                            @"recordTime":recordTime
                            };

    if (![array containsObject:toDict]) {
        [array addObject:toDict];
        [array writeToFile:filePatch atomically:true];
    }

}


/**
 本地保存cpu使用率,内存使用

 @param use cpu使用率
 @param memory memory使用
 @param recordTime 记录时间
 */
- (void)saveCPU:(NSString *)use memorys:(NSString *)memory recordTime:(NSString *)recordTime {
    
    @synchronized (self) {
        //加锁，保证每条数据都存进去

        if (use.length<=0||recordTime.length<=0||memory.length<=0) {
               return;
           }
           NSString *filePatch = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"CPUUseList.plist"];
           
           NSMutableArray *array =[[NSMutableArray alloc] initWithContentsOfFile:filePatch];
           
           if (!array) {
               array = [NSMutableArray array];
           }
           
           NSDictionary *toDict = @{@"cpuUse":use,
                                   @"memoryUse":memory,
                                   @"recordTime":recordTime
                                   };

           if (![array containsObject:toDict]) {
               [array addObject:toDict];
               [array writeToFile:filePatch atomically:true];
           }
    }
   
}


/**
 本地保存内存使用率
 @param use 使用率
 @param recordTime 记录时间
 */
- (void)saveMemory:(NSString *)use recordTime:(NSString *)recordTime{
    if (use.length<=0||recordTime.length<=0) {
        return;
    }
    NSString *filePatch = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"memoryUseList.plist"];
    
    NSMutableArray *array =[[NSMutableArray alloc] initWithContentsOfFile:filePatch];
    
    if (!array) {
        array = [NSMutableArray array];
    }
    
    NSDictionary *toDict = @{@"name":@"memory",
                            @"use":use,
                            @"recordTime":recordTime
                            };

    if (![array containsObject:toDict]) {
        [array addObject:toDict];
        [array writeToFile:filePatch atomically:true];
    }

}



/**
 本地保存电池电量数据

 @param batteryLeve 电量
 @param recordTime 记录时间
 */
- (void)saveBattery:(NSString *)batteryLeve recordTime:(NSString *)recordTime{
    if (batteryLeve.length<=0||recordTime.length<=0) {
        return;
    }
    NSString *filePatch = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"batteryUseList.plist"];
    
    NSMutableArray *array =[[NSMutableArray alloc] initWithContentsOfFile:filePatch];
    
    if (!array) {
        array = [NSMutableArray array];
    }
    
    NSDictionary *toDict = @{@"name":@"battery",
                            @"Leve":batteryLeve,
                            @"recordTime":recordTime
                            };

    if (![array containsObject:toDict]) {
        [array addObject:toDict];
        [array writeToFile:filePatch atomically:true];
    }

}



+ (struct tm*)getCurTime
{
    //时间格式
    struct timeval ticks;
    gettimeofday(&ticks, nil);
    time_t now;
    struct tm* timeNow;
    time(&now);
    timeNow = localtime(&now);
    timeNow->tm_gmtoff = ticks.tv_usec/1000;  //毫秒

    timeNow->tm_year += 1900;    //tm中的tm_year是从1900至今数
    timeNow->tm_mon  += 1;       //tm_mon范围是0-11

    return timeNow;
}


+ (float)cpuUsage
{
    float cpu = cpu_usage();
    return cpu;
}



float cpu_usage()
{
    kern_return_t kr;
    task_info_data_t tinfo;
    mach_msg_type_number_t task_info_count;

    task_info_count = TASK_INFO_MAX;
    kr = task_info(mach_task_self(), TASK_BASIC_INFO, (task_info_t)tinfo, &task_info_count);
    if (kr != KERN_SUCCESS) {
        return -1;
    }

    task_basic_info_t      basic_info;
    thread_array_t         thread_list;
    mach_msg_type_number_t thread_count;

    thread_info_data_t     thinfo;
    mach_msg_type_number_t thread_info_count;

    thread_basic_info_t basic_info_th;
    uint32_t stat_thread = 0; // Mach threads

    basic_info = (task_basic_info_t)tinfo;

    // get threads in the task
    kr = task_threads(mach_task_self(), &thread_list, &thread_count);
    if (kr != KERN_SUCCESS) {
        return -1;
    }
    if (thread_count > 0)
        stat_thread += thread_count;

    long tot_sec = 0;
    long tot_usec = 0;
    float tot_cpu = 0;
    int j;

    for (j = 0; j < thread_count; j++)
    {
        thread_info_count = THREAD_INFO_MAX;
        kr = thread_info(thread_list[j], THREAD_BASIC_INFO,
                         (thread_info_t)thinfo, &thread_info_count);
        if (kr != KERN_SUCCESS) {
            return -1;
        }

        basic_info_th = (thread_basic_info_t)thinfo;

        if (!(basic_info_th->flags & TH_FLAGS_IDLE)) {
            tot_sec = tot_sec + basic_info_th->user_time.seconds + basic_info_th->system_time.seconds;
            tot_usec = tot_usec + basic_info_th->user_time.microseconds + basic_info_th->system_time.microseconds;
            tot_cpu = tot_cpu + basic_info_th->cpu_usage / (float)TH_USAGE_SCALE * 100.0;
        }

    } // for each thread

    kr = vm_deallocate(mach_task_self(), (vm_offset_t)thread_list, thread_count * sizeof(thread_t));
    assert(kr == KERN_SUCCESS);

    return tot_cpu;
}

// 有的是除以1024，有的是除以1000。
+ (float)memoryUsage
{
    vm_size_t memory = memory_usage();
    return memory / 1024.0 /1024.0;
}


vm_size_t memory_usage(void) {
    struct task_basic_info info;
    mach_msg_type_number_t size = sizeof(info);
    kern_return_t kerr = task_info(mach_task_self(), TASK_BASIC_INFO, (task_info_t)&info, &size);
    return (kerr == KERN_SUCCESS) ? info.resident_size : 0; // size in bytes
}

//另一种内存计算方法
int64_t memoryUsageb(void) {
    int64_t memoryUsageInByte = 0;
    task_vm_info_data_t vmInfo;
    mach_msg_type_number_t count = TASK_VM_INFO_COUNT;
    kern_return_t kernelReturn = task_info(mach_task_self(), TASK_VM_INFO, (task_info_t) &vmInfo, &count);
    if(kernelReturn == KERN_SUCCESS) {
        memoryUsageInByte = (int64_t) vmInfo.phys_footprint;
        NSLog(@"APP占用内存: %lld字节(B)", memoryUsageInByte);
        int64_t mb = memoryUsageInByte / 1024 / 1024;
        NSLog(@"APP占用内存: %lld兆(MB)", mb);
    } else {
        NSLog(@"Error with task_info(): %s", mach_error_string(kernelReturn));
    }
    return memoryUsageInByte;

}

/**获取电量
 进入台监听一次，回到后台监听一次
 **/
- (int)getCurrentBatteryLevel
{

//UIApplication *app = [UIApplication sharedApplication];
//if (app.applicationState == UIApplicationStateActive||app.applicationState==UIApplicationStateInactive) {
//    Ivar ivar=  class_getInstanceVariable([app class],"_statusBar");
//    id status  = object_getIvar(app, ivar);
//    for (id aview in [status subviews]) {
//        double batteryLevel = 0;
//        for (id bview in [aview subviews]) {
//            if ([NSStringFromClass([bview class]) caseInsensitiveCompare:@"UIStatusBarBatteryItemView"] == NSOrderedSame&&[[[UIDevice currentDevice] systemVersion] floatValue] >=6.0)
//            {
//            
//                    Ivar ivar=  class_getInstanceVariable([bview class],"_capacity");
//                    if(ivar)
//                    {
//                        batteryLevel = ((int (*)(id, Ivar))object_getIvar)(bview, ivar);
//                        //这种方式也可以
//                        /*ptrdiff_t offset = ivar_getOffset(ivar);
//                         unsigned char *stuffBytes = (unsigned char *)(__bridge void *)bview;
//                         batteryLevel = * ((int *)(stuffBytes + offset));*/
//                        NSLog(@"电池电量:%.2f",batteryLevel);
//                        if (batteryLevel > 0 && batteryLevel <= 100) {
//                            return batteryLevel;
//                            
//                        } else {
//                            return 0;
//                        }
//                    }
//                
//            }
//            
//        }
//    }
//  }
    
    return 0;
}


-(void)clearAllRecord{
    //清除plist文件，可以根据我上面讲的方式进去本地查看plist文件是否被清除
      NSFileManager *fileMger = [NSFileManager defaultManager];
      NSString *filePatch = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"batteryUseList.plist"];
    
     NSString *filePatch2 = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"memoryUseList.plist"];
    
    
     NSString *filePatch3 = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"CPUUseList.plist"];
    
    
     NSString *filePatch4 = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"URLResponseList.plist"];
    
    NSString *filePatch5 = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"VCResponseList.plist"];
      //如果文件路径存在的话
      BOOL bRet = [fileMger fileExistsAtPath:filePatch];
      if (bRet) {
          NSError *err;
          [fileMger removeItemAtPath:filePatch error:&err];
       }
    
    
    BOOL bRet2 = [fileMger fileExistsAtPath:filePatch2];
        if (bRet2) {
            NSError *err;
            [fileMger removeItemAtPath:filePatch2 error:&err];
        }
    
    BOOL bRet3 = [fileMger fileExistsAtPath:filePatch3];
           if (bRet3) {
               NSError *err;
               [fileMger removeItemAtPath:filePatch3 error:&err];
           }
    
    BOOL bRet4 = [fileMger fileExistsAtPath:filePatch4];
              if (bRet4) {
                  NSError *err;
                  [fileMger removeItemAtPath:filePatch4 error:&err];
    }
    
    BOOL bRet5 = [fileMger fileExistsAtPath:filePatch5];
                if (bRet5) {
                    NSError *err;
                    [fileMger removeItemAtPath:filePatch5 error:&err];
    }
    
}

/**获取页面本地存储的响应数据**/
-(NSArray *)getVCDurationList{
    
    NSString *filePatch = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"VCResponseList.plist"];
     
    NSMutableArray *array =[[NSMutableArray alloc] initWithContentsOfFile:filePatch];
      NSMutableArray *array1 =[[NSMutableArray alloc]init];
     [array1 writeToFile:filePatch atomically:true];
     return array;
}

/**获取url本地存储的响应数据**/
-(NSArray *)getUrlDurationList{
    
    NSString *filePatch = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"URLResponseList.plist"];
       
       NSMutableArray *array =[[NSMutableArray alloc] initWithContentsOfFile:filePatch];
       NSMutableArray *array1 =[[NSMutableArray alloc]init];
          [array1 writeToFile:filePatch atomically:true];
       return array;
    
}
/**获取内存，cpu本地存储数据**/
-(NSArray *)getCPUAndMemoryList{
    NSString *filePatch = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"CPUUseList.plist"];
              
        NSMutableArray *array =[[NSMutableArray alloc] initWithContentsOfFile:filePatch];
    
        NSMutableArray *array1 =[[NSMutableArray alloc]init];
        [array1 writeToFile:filePatch atomically:true];
    
    return array;
    
}

-(NSString *)getNowTimeTimestamp3{

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;

    [formatter setDateStyle:NSDateFormatterMediumStyle];

    [formatter setTimeStyle:NSDateFormatterShortStyle];

    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss SSS"]; // 设置想要的格式，hh与HH的区别:分别表示12小时制,24小时制

    //设置时区,这一点对时间的处理有时很重要

    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];

    [formatter setTimeZone:timeZone];

    NSDate *datenow = [NSDate date];

    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]*1000];

    return timeSp;

}

@end
