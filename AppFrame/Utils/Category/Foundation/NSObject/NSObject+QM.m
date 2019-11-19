//
//  NSObject+QM.m
//  Module
//

#import "NSObject+QM.h"
#import <objc/runtime.h>

@implementation NSObject (QM)

- (id)valueForUndefinedKey:(NSString *)key
{
    return nil;
}

- (NSDictionary *)properties_aps {
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        id propertyValue = [self valueForKey:(NSString *)propertyName];
        if (propertyValue) [props setObject:propertyValue forKey:propertyName];
    }
    free(properties);
    return props;
}
- (BOOL)isNotEmpty
{
    if ([self isKindOfClass:[NSNull class]])
    {
        return false;
    }
    else if ([self isKindOfClass:[NSString class]])
    {
        return [(NSString *)self length] > 0;
    }
    else if ([self isKindOfClass:[NSData class]])
    {
        
        return [(NSData *)self length] > 0;
    }
    else if ([self isKindOfClass:[NSArray class]])
    {
        
        return [(NSArray *)self count] > 0;
    }
    else if ([self isKindOfClass:[NSDictionary class]])
    {
        
        return [(NSDictionary *)self count] > 0;
    }
    
    return true;
}

+ (void)swizzleClassMethodOriginSel:(SEL)oriSel swizzledSel:(SEL)swiSel
{
    Class cls = object_getClass(self);
    Method originClassMethod = class_getClassMethod(cls, oriSel);
    Method swizzleClassMethod = class_getClassMethod(cls, swiSel);
    
    [self swizzleMethodWithOriginSel:oriSel oriMethod:originClassMethod swizzledSel:swiSel swizzledMethod:swizzleClassMethod class:cls];
}

+ (void)swizzleClassInstanceMethodWithOriginSel:(SEL)oriSel swizzleSel:(SEL)swiSel
{
    Method originClassMethod = class_getInstanceMethod(self, oriSel);
    Method swizzleClassMethod = class_getInstanceMethod(self, swiSel);
    
    [self swizzleMethodWithOriginSel:oriSel oriMethod:originClassMethod swizzledSel:swiSel swizzledMethod:swizzleClassMethod class:self];
}

+ (void)swizzleMethodWithOriginSel:(SEL)oriSel
                         oriMethod:(Method)oriMethod
                       swizzledSel:(SEL)swizzledSel
                    swizzledMethod:(Method)swizzledMethod
                             class:(Class)cls {
    BOOL didAddMethod = class_addMethod(cls, oriSel, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(cls, swizzledSel, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
    } else {
        method_exchangeImplementations(oriMethod, swizzledMethod);
    }
}

- (NSString*)analysisConvertToString{
    if ([self isKindOfClass:[NSNull class]] || !self) {
        return @"";
    }else if([self isKindOfClass:[NSNumber class]]){
        return [NSString stringWithFormat:@"%@", self];
    }else if([[NSString stringWithFormat:@"%@",self] isEqualToString:@"null"]){
        return @"";
    }else{
        return (NSString*)self;
    }
}

+ (UIViewController *)qm_currentViewController
{
    UIViewController* rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    return [self currentViewControllerFrom:rootViewController];
}

/**
 *  返回当前的控制器,以viewController为节点开始寻找
 */
+ (UIViewController*)currentViewControllerFrom:(UIViewController*)viewController
{
    //传入的根节点控制器是导航控制器
    if ([viewController isKindOfClass:[UINavigationController class]])
    {
        UINavigationController* navigationController = (UINavigationController *)viewController;
        return [self currentViewControllerFrom:navigationController.viewControllers.lastObject];
    }
    else if([viewController isKindOfClass:[UITabBarController class]]) //传入的根节点控制器是UITabBarController
    {
        UITabBarController* tabBarController = (UITabBarController *)viewController;
        return [self currentViewControllerFrom:tabBarController.selectedViewController];
    }
    else if(viewController.presentedViewController != nil)  //传入的根节点控制器是被展现出来的控制器
    {
        return [self currentViewControllerFrom:viewController.presentedViewController];
    }
    else
    {
        return viewController;
    }
}

@end
