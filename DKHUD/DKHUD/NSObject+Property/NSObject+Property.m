//
//  NSObject+Property.m
//  DragDemo
//
//  Created by chen on 2017/6/10.
//  Copyright © 2017年 玩图网络. All rights reserved.
//

#import "NSObject+Property.h"
#import <objc/runtime.h>

@implementation NSObject (Property)

- (id)dk_getAssociatedObjectForKey:(const char *)key {
    const char * propName = key;
    id currValue = objc_getAssociatedObject( self, propName );
    return currValue;
}

- (id)dk_retainAssociatedObject:(id)obj forKey:(const char *)key {
    const char * propName = key;
    id oldValue = objc_getAssociatedObject( self, propName );
    objc_setAssociatedObject( self, propName, obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC );
    return oldValue;
}

- (id)dk_setAssignAssociatedObject:(id)obj forKey:(const char *)key {
    const char * propName = key;
    id oldValue = objc_getAssociatedObject( self, propName );
    objc_setAssociatedObject( self, propName, obj, OBJC_ASSOCIATION_ASSIGN );
    return oldValue;
}

@end
