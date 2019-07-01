//
//  SJCustomKeyboardView.h
//  SJCustomKeyboard
//
//  Created by sj on 2019/5/28.
//  Copyright © 2019 sj. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 用代理看的更清楚 但是分类不能实现代理 所以只能用block实现回调 如果自定义textField可以用代理
 
 @protocol SJCustomKeyboardViewDelegate <NSObject>
 
 - (void)textFieldReplacementString:(NSString *_Nullable)string;
 - (BOOL)textFieldShouldDelete;
 - (BOOL)textFieldShouldClear;
 - (BOOL)textFieldShouldReturn;
 
 @end
 */


NS_ASSUME_NONNULL_BEGIN

@interface SJCustomKeyboardView : UIView

//@property (nonatomic, weak) id<SJCustomKeyboardViewDelegate> delegate;

@property (nonatomic, copy) void (^textFieldReplacementString)(NSString *string);
@property (nonatomic, copy) void (^textFieldShouldDelete)(void);
@property (nonatomic, copy) void (^textFieldShouldClear)(void);
@property (nonatomic, copy) void (^textFieldShouldReturn)(void);

// 更新安全键盘布局
- (void)updateSaveNumberButton;

@end

NS_ASSUME_NONNULL_END
