//
//  UIImageView+HZExtend.m
//  mcapp
//
//  Created by xzh on 16/1/8.
//  Copyright © 2016年 zhuchao. All rights reserved.
//

#import "UIImageView+HZExtend.h"
#import "NSObject+HZExtend.h"
@implementation UIImageView (HZExtend)

- (void)safeSetImageWithURL:(NSString *)url placeholder:(UIImage *)image
{
    if (url.isNoEmpty) {
        //去掉头尾空格（编辑录入失误的容错）
        url = [url stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        NSURL *imageURL = [NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//        [[SDWebImageDownloader sharedDownloader] setValue:@"iPhone" forHTTPHeaderField:@"User-Agent"];
        [[SDWebImageManager sharedManager] cachedImageExistsForURL:imageURL completion:^(BOOL isInCache) {
            if (isInCache) {
                NSString *key = [[SDWebImageManager sharedManager] cacheKeyForURL:imageURL];
                self.image = [[SDWebImageManager sharedManager].imageCache imageFromDiskCacheForKey:key];
            }else {
                [self sd_setImageWithURL:imageURL placeholderImage:image];
                //            [self sd_setImageWithURL:imageURL placeholderImage:image options:SDWebImageAllowInvalidSSLCertificates];
            }
        }];
    }else {
        self.image = image;
    }
}


- (void)safeSetImageWithURL:(NSString *)url placeholder:(UIImage *)image loadfinishBlock:(void (^)()) finishBlock{
    if (url.isNoEmpty) {
        //去掉头尾空格（编辑录入失误的容错）
        url = [url stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        NSURL *imageURL = [NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        //        [[SDWebImageDownloader sharedDownloader] setValue:@"iPhone" forHTTPHeaderField:@"User-Agent"];
        [[SDWebImageManager sharedManager] cachedImageExistsForURL:imageURL completion:^(BOOL isInCache) {
            if (isInCache) {
                NSString *key = [[SDWebImageManager sharedManager] cacheKeyForURL:imageURL];
                self.image = [[SDWebImageManager sharedManager].imageCache imageFromDiskCacheForKey:key];
                finishBlock();
            }else {
                [self sd_setImageWithURL:imageURL placeholderImage:image completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                    finishBlock();
                }];
                [self sd_setImageWithURL:imageURL placeholderImage:image];
                //            [self sd_setImageWithURL:imageURL placeholderImage:image options:SDWebImageAllowInvalidSSLCertificates];
            }
        }];
    }else {
        self.image = image;
    }
    
}

@end
