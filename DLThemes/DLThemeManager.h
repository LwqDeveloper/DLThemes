//
//  DLThemeManager.h
//  DLThemesDemo
//
//  Created by Autel_Ling on 2020/2/25.
//  Copyright © 2020 DL_muyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DLThemeManager : NSObject <NSCopying>

+ (instancetype)defaultManager;

@property (nonatomic ,assign) NSInteger themeNum;

@end
