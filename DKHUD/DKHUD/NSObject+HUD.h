//
//  NSObject+HUD.h
//  DKHUD
//
//  Created by easy on 2018/6/25.
//  Copyright © 2018年 简单互娱. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HUDContentView.h"
#import "NSObject+Property.h"

@interface NSObject (HUD)

dk_property_strong(HUDContentView *, hudView)

- (UIView *)HUDSuperView;

// 展示2s
- (void)showMessage:(NSString *)text;
// 一直展示
- (void)keepShowMessage:(NSString *)text;

- (void)dismiss;
// 延时自动消失
- (void)dismissAfterDelay;

@end
