//
//  QMResponseObject.h
//  AppFrame
//
//  Created by edz on 2019/8/27.
//  Copyright © 2019 米晓明. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QMResponseObject : NSObject

@property (nonatomic,copy) NSString *status; 
@property (nonatomic,copy) NSString *error_msg;
@property (nonatomic,copy) NSString *timestamp;
@property (nonatomic,copy) NSDictionary *data;

@end

NS_ASSUME_NONNULL_END
