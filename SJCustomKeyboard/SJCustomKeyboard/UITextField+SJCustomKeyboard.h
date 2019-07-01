//
//  UITextField+SJCustomKeyboard.h
//  SJCustomKeyboard
//
//  Created by sj on 2019/5/28.
//  Copyright © 2019 sj. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SJSCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SJSCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

typedef NS_ENUM(NSUInteger, SJKeyboardType)
{
    SJKeyboardTypeDefault,      // 使用默认键盘
    SJKeyboardTypeNumber,       // 使用自定义数字键盘
    SJKeyboardTypeSafeNumber,   // 使用自定义数字安全键盘
    // 还可以根据需求 自定义其他样式...
};

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (SJCustomKeyboard)

/*
 * 设置键盘样式
 */
@property (nonatomic, assign) SJKeyboardType sjKeyboardType;

@end

NS_ASSUME_NONNULL_END
