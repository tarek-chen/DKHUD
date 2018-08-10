//
//  DKHUDMacro.h
//  DKHUD
//
//  Created by easy on 2018/6/22.
//  Copyright © 2018年 简单互娱. All rights reserved.
//

#ifndef DKHUDMacro_h
#define DKHUDMacro_h


#define DKScreenWidth [UIScreen mainScreen].bounds.size.width
#define DKScreenHeight [UIScreen mainScreen].bounds.size.height

#define kNavBarHeight 44.0
//static CGFloat const kZero = .0f;
/// 状态栏高度
#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
/// 导航栏高度
//static CGFloat const kNaviBarHeight = 44.0f;
/// 顶部高度
#define kTopHeight (kStatusBarHeight + kNavBarHeight)
/// TabBar的高度
#define kTabBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)
/// iPhoneX底边栏
#define kSafeAreaBottomHeight (DKScreenHeight == 812.0 ? 34 : 0)

#endif /* DKHUDMacro_h */
