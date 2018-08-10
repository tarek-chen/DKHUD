//
//  NSObject+HUD.m
//  DKHUD
//
//  Created by easy on 2018/6/25.
//  Copyright © 2018年 简单互娱. All rights reserved.
//

#import "NSObject+HUD.h"

@implementation NSObject (HUD)
dk_def_property_strong(HUDContentView *, hudView)

- (UIView *)HUDSuperView {
    UIView *hudSuperView;
    if ([self.class isSubclassOfClass:[UIView class]]) {
        hudSuperView = (UIView *)self;
    }
    else if ([self.class isSubclassOfClass:[UIViewController class]]) {
        hudSuperView = (UIView *)[self valueForKey:@"view"];
    }
    return hudSuperView;
}

#pragma mark - 展示后延时自动消失
- (void)showMessage:(NSString *)text {
    if (!self.HUDSuperView) {
        return;
    }
    if (!self.hudView) {
       self.hudView = [HUDContentView viewWithText:text];
    } else {
        self.hudView.text = text;
    }
    [self.hudView showOnView:self.HUDSuperView];
    [self.hudView dismissAfterDelay:2];
}

- (void)keepShowMessage:(NSString *)text {
    [self showMessage:text];
}

- (void)dismiss {
    [self.hudView dismiss];
}

- (void)dismissAfterDelay {
    [self.hudView dismissAfterDelay:2];
}

@end
