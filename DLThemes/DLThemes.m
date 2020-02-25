//
//  DLThemes.m
//  DLThemesDemo
//
//  Created by Autel_Ling on 2020/2/25.
//  Copyright © 2020 DL_muyang. All rights reserved.
//

#import "DLThemes.h"
#import <objc/runtime.h>

static const int kColortContainerKey;

@implementation NSString (DLThemes)

- (NSString *)dlThemesValue
{
    NSInteger themeNum = [DLThemeManager defaultManager].themeNum;
    if (themeNum >= 0) {
        return [self stringByAppendingFormat:@"_theme_%@", @(themeNum)];
    }
    return self;
}

@end

/** 私有类 - color 容器 */
@interface DLColorContainer : NSObject

@property (nonatomic ,weak) id target;// 这里一定要用weak, 避免循环引用造成内存泄漏
@property (nonatomic ,strong) NSMutableArray * values;

- (instancetype)initWithTarget:(id)target;
- (void)addSelector:(SEL)sel object:(id)object, ... NS_REQUIRES_NIL_TERMINATION;

@end

@implementation DLColorContainer

- (instancetype)initWithTarget:(id)target
{
    self = [super init];
    if (self) {
        /** 弱引用target */
        self.target = target;
        _values = [NSMutableArray array];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onSceneChange:) name:@"l_notification_theme_change" object:nil];
    }
    return self;
}

- (void)onSceneChange:(NSNotification *)note {
    for (NSDictionary * dict in self.values) {
        NSString * selector = dict[@"sel"];
        id obj = dict[@"obj"];
        SEL _sel = NSSelectorFromString(selector);
        NSMethodSignature * methodSignature = [[self.target class] instanceMethodSignatureForSelector:_sel];
        if(methodSignature == nil)
        {
            @throw [NSException exceptionWithName:@"抛异常错误" reason:@"没有这个方法，或者方法名字错误" userInfo:nil];
        }
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
        [invocation setTarget:self.target];
        [invocation setSelector:_sel];
        NSInteger argsCount = methodSignature.numberOfArguments - 2; // 参数里有 self, _cmd  所以-2
        NSInteger paramsCount = [obj count];
        if (paramsCount >= argsCount) {
            for (int i = 0; i < argsCount; i++) {
                id param = obj[i];
                [invocation setArgument:&param atIndex:i+2];
            }
            [invocation invoke];
        }
    }
}


- (void)addSelector:(SEL)sel object:(id)object, ... NS_REQUIRES_NIL_TERMINATION
{
    if (sel == nil || object == nil) {
        return;
    }
    va_list args;
    id item;
    va_start(args, object);
    NSMutableArray * params = [NSMutableArray arrayWithObjects:object, nil];
    while ((item = va_arg(args, id))) {
        [params addObject:item];
    }
    va_end(args);
    [_values addObject:@{@"sel":NSStringFromSelector(sel), @"obj":params}];
}

@end

@implementation UIView (DLThemes)

- (DLTuple)backgroundDLTuple{return nil;}
- (void)setBackgroundDLTuple:(DLTuple)backgroundDLTuple {
    self.backgroundColor = lValueFromTuple(backgroundDLTuple);
    DLColorContainer * container = self.colorContainer;
    [container addSelector:@selector(_setBackgroundDLTuple:) object:backgroundDLTuple, nil];
}

- (void)_setBackgroundDLTuple:(DLTuple)tuple {
    self.backgroundColor = lValueFromTuple(tuple);
}

- (DLColorContainer *)colorContainer
{
    DLColorContainer * container = objc_getAssociatedObject(self, &kColortContainerKey);
    if (container == nil) {
        container = [[DLColorContainer alloc] initWithTarget:self];
        objc_setAssociatedObject(self, &kColortContainerKey, container, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return container;
}

@end

@implementation UILabel (DLThemes)
- (DLTuple)textDLTuple{return nil;}
- (void)setTextDLTuple:(DLTuple)textDLTuple {
    self.textColor = lValueFromTuple(textDLTuple);
    DLColorContainer * container = self.colorContainer;
    [container addSelector:@selector(_setTextDLTuple:) object:textDLTuple, nil];
}
- (void)_setTextDLTuple:(DLTuple)tuple{
    self.textColor = lValueFromTuple(tuple);
}
@end

@implementation UIButton (DLThemes)
- (void)setTitleDLTuple:(DLTuple)tuple forState:(UIControlState)state {
    [self setTitleColor:lValueFromTuple(tuple) forState:state];
    DLColorContainer * container = self.colorContainer;
    [container addSelector:@selector(_setTitleDLTuple:state:) object:tuple, @(state), nil];
}
- (void)_setTitleDLTuple:(DLTuple)tuple state:(id)state {
    [self setTitleColor:lValueFromTuple(tuple) forState:(UIControlState)[state integerValue]];
}
- (void)setImageTuple:(DLTuple)tuple forState:(UIControlState)state {
    [self setImage:lValueFromTuple(tuple) forState:state];
    DLColorContainer * container = self.colorContainer;
    [container addSelector:@selector(_setImageTuple:forState:) object:tuple, @(state), nil];
}
- (void)_setImageTuple:(DLTuple)tuple forState:(id)state {
    [self setImage:lValueFromTuple(tuple) forState:(UIControlState)[state integerValue]];
}
- (void)setBackgroundImageTuple:(DLTuple)tuple forState:(UIControlState)state {
    [self setBackgroundImage:lValueFromTuple(tuple) forState:state];
    DLColorContainer * container = self.colorContainer;
    [container addSelector:@selector(_setBackgroundImageTuple:forState:) object:tuple, @(state), nil];
}
- (void)_setBackgroundImageTuple:(DLTuple)tuple forState:(id)state {
    [self setBackgroundImage:lValueFromTuple(tuple) forState:(UIControlState)[state integerValue]];
}
@end

@implementation UIImageView (DLThemes)
- (DLTuple)imageTuple {return nil;}
- (void)setImageTuple:(DLTuple)imageTuple {
    self.image = lValueFromTuple(imageTuple);
    DLColorContainer * container = self.colorContainer;
    [container addSelector:@selector(_setImageTuple:) object:imageTuple, nil];
}
- (void)_setImageTuple:(DLTuple)imageTuple {
    self.image = lValueFromTuple(imageTuple);
}
@end

@implementation UITextField (DLThemes)
- (DLTuple)textDLTuple{return nil;}
- (void)setTextDLTuple:(DLTuple)textDLTuple {
    self.textColor = lValueFromTuple(textDLTuple);
    DLColorContainer * container = self.colorContainer;
    [container addSelector:@selector(_setTextDLTuple:) object:textDLTuple, nil];
}
- (void)_setTextDLTuple:(DLTuple)tuple{
    self.textColor = lValueFromTuple(tuple);
}
@end

@implementation UITextView (DLThemes)
- (DLTuple)textDLTuple{return nil;}
- (void)setTextDLTuple:(DLTuple)textDLTuple {
    self.textColor = lValueFromTuple(textDLTuple);
    DLColorContainer * container = self.colorContainer;
    [container addSelector:@selector(_setTextDLTuple:) object:textDLTuple, nil];
}
- (void)_setTextDLTuple:(DLTuple)tuple{
    self.textColor = lValueFromTuple(tuple);
}
@end

