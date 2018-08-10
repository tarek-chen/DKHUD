//
//  HUDContentView.h
//  DKHUD
//
//  Created by easy on 2018/6/22.
//  Copyright © 2018年 简单互娱. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HUDContentView : UIView
@property (nonatomic, copy)     NSString *text;

+ (instancetype)viewWithText:(NSString *)text;
- (void)showOnView:(UIView *)superView;
- (void)dismiss;
- (void)dismissAfterDelay:(CGFloat)delay;

@end
