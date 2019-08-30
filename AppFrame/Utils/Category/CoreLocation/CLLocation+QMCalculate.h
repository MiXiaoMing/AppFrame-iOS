//
//  CLLocation+QMCalculate.h
//  AppFrame
//
//  Created by edz on 2019/8/30.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CLLocation (QMCalculate)

/**
 根据经纬度算出两点之间的距离
 
 @param lat1 纬度1
 @param lng1 经度1
 @param lat2 纬度2
 @param lng2 经度2
 */
+ (double)getDistance:(double)lat1 withLng1:(double)lng1 withLat2:(double)lat2 withLng2:(double)lng2;

@end

NS_ASSUME_NONNULL_END
