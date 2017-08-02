//
//  YTL_Macro.h
//  YouTiaoLi
//
//  Created by 天蓝 on 2017/8/1.
//  Copyright © 2017年 PT. All rights reserved.
//

#ifndef YTL_Macro_h
#define YTL_Macro_h

// 屏幕宽度
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
// 屏幕高度
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

// 控制台打印
#define QFLog(format, ...)  NSLog(format, ## __VA_ARGS__)

// 弱引用对象
#define __weakify(obj) @autoreleasepool {} __attribute__((objc_ownership(weak))) __typeof__(obj) obj##_weak_ = (obj);
// 强引用对象
#define __strongify(obj) @autoreleasepool {} __attribute__((objc_ownership(strong))) __typeof__(obj) obj = obj##_weak_;


#define kBackgroundColor [UIColor colorWithRed:0.97f green:0.97f blue:0.97f alpha:1.00f]


#endif /* YTL_Macro_h */
