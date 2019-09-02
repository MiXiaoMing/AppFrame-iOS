//
//  NSBundle+QMPod.m
//  AppFrame
//
//  Created by edz on 2019/9/2.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import "NSBundle+QMPod.h"

@implementation NSBundle (QMPod)

+ (NSString *)getPodResourcePathWith:(Class)cla fileName:(NSString *)fileName
{
    NSBundle *bundle = [NSBundle bundleForClass:cla];
    NSDictionary *bundleDic = bundle.infoDictionary;
    NSString *bundleName = [bundleDic objectForKey:@"CFBundleExecutable"];
    NSString *path = [bundle pathForResource:fileName ofType:nil inDirectory:[NSString stringWithFormat:@"%@.bundle",bundleName]];
    return path;
}

+ (UIImage *)getPodImageWith:(Class)cla fileName:(NSString *)fileName type:(NSString *)type
{
    NSInteger scale = [UIScreen mainScreen].scale;
    NSString *imageName = [NSString stringWithFormat:@"%@@%zdx.%@",fileName,scale,type];
    UIImage *image = [UIImage imageNamed:imageName];
    if (image) {
        return image;
    }
    NSString *path = [NSBundle getPodResourcePathWith:cla fileName:imageName];
    image = [UIImage imageWithContentsOfFile:path];
    return image;
}

+ (NSBundle *)bundleWithPodName:(NSString *)podName{
    if (!podName) {
        return [NSBundle mainBundle];
    }
    NSBundle * bundle = [NSBundle bundleForClass:NSClassFromString(podName)];
    NSURL * url = [bundle URLForResource:podName withExtension:@"bundle"];
    if (!url) {
        NSArray *frameWorks = [NSBundle allFrameworks];
        for (NSBundle *tempBundle in frameWorks) {
            url = [tempBundle URLForResource:podName withExtension:@"bundle"];
            if (url) {
                bundle =[NSBundle bundleWithURL:url];
                if (!bundle.loaded) {
                    [bundle load];
                }
                return bundle;
            }
        }
    }else{
        bundle =[NSBundle bundleWithURL:url];
        return bundle;
    }
    return nil;
}

+ (NSString *)localizedStringForKey:(NSString *)key language:(NSString *)language podName:(NSString *)podName{
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle bundleWithPodName:podName] pathForResource:language ofType:@"lproj"]];
    NSString *value = [bundle localizedStringForKey:key value:nil table:nil];
    return [[NSBundle mainBundle] localizedStringForKey:key value:value table:nil];
}

@end