//
//  NSObject+Property.h
//  DragDemo
//
//  Created by chen on 2017/6/10.
//  Copyright © 2017年 玩图网络. All rights reserved.
//

#import <Foundation/Foundation.h>


#define metamacro_concat(A, B) \
metamacro_concat_(A, B)
#define metamacro_concat_(A, B) A ## B

#pragma mark - strong类型
/// .h定义属性
#define dk_property_strong( __type, __name) \
@property (nonatomic, strong, setter=set__##__name:, getter=__##__name) __type __name;

/// .m实现setter、getter
#define dk_def_property_strong( __type, __name) \
- (__type)__##__name   \
{ return [self dk_getAssociatedObjectForKey:#__name]; }   \
- (void)set__##__name:(id)__##__name   \
{ [self dk_retainAssociatedObject:__##__name forKey:#__name]; }

// assign
// .h属性定义
#define dk_property_assign( __type, __name) \
@property (nonatomic, assign, setter=set__##__name:, getter=__##__name) __type __name;

// .m实现setter、getter
#define dk_def_property_assign( __type, __name) \
- (__type)__##__name   \
{   \
NSNumber *number = [self dk_getAssociatedObjectForKey:#__name];    \
return metamacro_concat(metamacro_concat(__dk_, __type), _value)( number ); \
}   \
- (void)set__##__name:(__type)__##__name   \
{ \
id value = @(__##__name);\
[self dk_retainAssociatedObject:value forKey:#__name];     \
}

// 支持的assign类型(常用部分)
#define __dk_int_value( __nubmer ) [__nubmer intValue]
#define __dk_NSInteger_value( __nubmer ) [__nubmer integerValue]
#define __dk_CGFloat_value( __nubmer ) [__nubmer floatValue]
#define __dk_BOOL_value( __nubmer ) [__nubmer boolValue]
#define __dk_NSTimeInterval_value( __nubmer ) [__nubmer doubleValue]



@interface NSObject (Property)

- (id)dk_getAssociatedObjectForKey:(const char *)key;
- (id)dk_retainAssociatedObject:(id)obj forKey:(const char *)key;
- (id)dk_setAssignAssociatedObject:(id)obj forKey:(const char *)key;

@end
