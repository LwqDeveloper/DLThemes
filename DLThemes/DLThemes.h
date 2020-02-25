//
//  DLThemes.h
//  DLThemesDemo
//
//  Created by Autel_Ling on 2020/2/25.
//  Copyright © 2020 DL_muyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLThemeManager.h"

typedef NSArray * DLTuple;
CG_INLINE DLTuple lDLTupleMake(NSArray *values) {
    return values;
}
CG_INLINE id lValueFromTuple(DLTuple tuple) {
    if (tuple.count == 0) {
        return nil;
    }
    NSInteger num = [DLThemeManager defaultManager].themeNum;
    if (num >= 0 && num < tuple.count) {
        return tuple[num];
    }
    return tuple.firstObject;
}

@interface NSString (DLThemes)
- (NSString *)dlThemesValue;
@end

@class DLColorContainer;
@interface UIView (DLThemes)
@property (nonatomic, copy) DLTuple backgroundDLTuple; /** 写成属性只是为了 写代码的有 提示。。。 以下一样 */
- (DLColorContainer *)colorContainer;
@end

@interface UILabel (DLThemes)
@property (nonatomic, strong) DLTuple textDLTuple;
@end

@interface UIButton (DLThemes)
- (void)setTitleDLTuple:(DLTuple)tuple forState:(UIControlState)state; /** 设置 button 字体颜色 */
- (void)setImageTuple:(DLTuple)tuple forState:(UIControlState)state; /** 设置tuple */
- (void)setBackgroundImageTuple:(DLTuple)tuple forState:(UIControlState)state; /** 设置tuple */

@end

@interface UIImageView (DLThemes)
@property (nonatomic, copy) DLTuple imageTuple;
@end

@interface UITextField (DLThemes)
@property (nonatomic, strong) DLTuple textDLTuple;
@end

@interface UITextView (DLThemes)
@property (nonatomic, strong) DLTuple textDLTuple;
@end
