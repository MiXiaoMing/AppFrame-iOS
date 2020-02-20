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

+ (NSBundle *)bundleWithPodName:(NSString *)podName{
    if (podName == nil || podName.length == 0) {
        return [NSBundle mainBundle];
    }
    NSBundle * bundle = [NSBundle bundleForClass:NSClassFromString(podName)];
    NSURL * url = [bundle URLForResource:podName withExtension:@"bundle"];
    if (!url) {
        NSArray *frameWorks = [NSBundle allFrameworks];
        BOOL isContain = false;
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
        if (!isContain) {
            return [NSBundle mainBundle];
        }
    }else{
        bundle =[NSBundle bundleWithURL:url];
        return bundle;
    }
    return nil;
}

+ (NSBundle *)bundleWithBundleName:(NSString *)bundleName{
    if (!bundleName) {
        return [NSBundle mainBundle];
    }
    
    NSString *bundlePath = [NSBundle mainBundle].bundlePath;
    bundlePath = [NSString stringWithFormat:@"%@/%@.bundle",bundlePath,bundleName];
    NSURL *url;
    if (@available(iOS 9.0,*)) {
        NSString *charactersToEscape = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
        NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
        url = [NSURL URLWithString:[[NSString stringWithFormat:@"file://%@",bundlePath] stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters]];
    }else
    {
        url = [NSURL URLWithString:[[NSString stringWithFormat:@"file://%@",bundlePath] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    NSBundle *bundle =[NSBundle bundleWithURL:url];
    return bundle;
}

+ (NSString *)localizedStringForKey:(NSString *)key language:(NSString *)language podName:(nullable NSString *)podName{
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle bundleWithPodName:podName] pathForResource:language ofType:@"lproj"]];
    NSString *value = [bundle localizedStringForKey:key value:nil table:nil];
    if (value) {
        return value;
    }
    return [[NSBundle mainBundle] localizedStringForKey:key value:value table:nil];
}

+ (UIImage *)getPodImageWith:(nullable NSString *)podName fileName:(NSString *)fileName type:(NSString *)type
{
    NSBundle * pod_bundle =[self bundleWithPodName:podName];
    if (!pod_bundle) {
        return nil;
    }
    if (!pod_bundle.loaded) {
        [pod_bundle load];
    }
    UIImage *image = [UIImage imageNamed:fileName inBundle:pod_bundle compatibleWithTraitCollection:nil];
    return image;
}

+ (NSString *)pathWithFileName:(NSString *)fileName podName:(NSString *)podName ofType:(NSString *)ext
{
    
    if (!fileName ) {
        return nil;
    }
    NSBundle * pod_bundle =[self bundleWithPodName:podName];
    if (!pod_bundle) {
        return nil;
    }
    if (!pod_bundle.loaded) {
        [pod_bundle load];
    }
    NSString *filePath =[pod_bundle pathForResource:fileName ofType:ext];
    return filePath;
}

@end
