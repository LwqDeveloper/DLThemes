//
//  DLThemeManager.m
//  DLThemesDemo
//
//  Created by Autel_Ling on 2020/2/25.
//  Copyright © 2020 DL_muyang. All rights reserved.
//

#import "DLThemeManager.h"

@implementation DLThemeManager

- (void)setThemeNum:(NSInteger)themeNum
{
    if (_themeNum != themeNum) {
        _themeNum = themeNum;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"l_notification_theme_change" object:nil];
        [[NSUserDefaults standardUserDefaults] setInteger:themeNum forKey:@"l_theme_num"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}


+ (instancetype)defaultManager {
    static DLThemeManager * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[super allocWithZone:NULL] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _themeNum = [[NSUserDefaults standardUserDefaults] integerForKey:@"l_theme_num"];
    }
    return self;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [self defaultManager];
}

- (id)copyWithZone:(NSZone *)zone {
    return [[self class] defaultManager];
}


@end
