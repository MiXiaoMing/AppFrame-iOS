//
//  CLLocation+QMCalculate.m
//  AppFrame
//
//  Created by edz on 2019/8/30.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import "CLLocation+QMCalculate.h"

@implementation CLLocation (QMCalculate)

+ (double)getDistance:(double)lat1 withLng1:(double)lng1 withLat2:(double)lat2 withLng2:(double)lng2
{
    CLLocation *orig = [[CLLocation alloc] initWithLatitude:lat1 longitude:lng1];
    CLLocation* dist = [[CLLocation alloc] initWithLatitude:lat2 longitude:lng2];
    
    CLLocationDistance kilometers = [orig distanceFromLocation:dist] / 1000;
    
    //UI_LOG(@"kilometers = %f", kilometers);
    
    return kilometers;
}

@end
