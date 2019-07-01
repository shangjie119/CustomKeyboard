//
//  UITextField+SJCustomKeyboard.m
//  SJCustomKeyboard
//
//  Created by sj on 2019/5/28.
//  Copyright © 2019 sj. All rights reserved.
//

#import "UITextField+SJCustomKeyboard.h"

#import <objc/runtime.h>

#import "SJCustomKeyboardView.h"



static NSString *sjKeyboardTypeKey = @"sjKeyboardTypeKey";

#define SJNumberKeyboardHeight 260
#define SJCustomKeyboardBottomMargin  ((([[UIApplication sharedApplication] statusBarFrame].size.height) == 20) ? 0 : 34)

@implementation UITextField (SJCustomKeyboard)

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (SJKeyboardType)sjKeyboardType
{
    return [objc_getAssociatedObject(self, &sjKeyboardTypeKey) integerValue];
}

- (void)setSjKeyboardType:(SJKeyboardType)sjKeyboardType
{
    objc_setAssociatedObject(self, &sjKeyboardTypeKey, @(sjKeyboardType), OBJC_ASSOCIATION_ASSIGN);
    if (sjKeyboardType == SJKeyboardTypeSafeNumber) {
        [self configData:sjKeyboardType];
    } else {
        [self setupKeyboard:sjKeyboardType];
    }
}


// 如果不是安全键盘需要每次刷新的话  直接执行setupKeyboard即可
- (void)configData:(SJKeyboardType)sjKeyboardType
{
    // 这个判断是为了使当有多个输入框时，输入框切换也会触发UIKeyboardWillShowNotification通知
    if (!self.inputAccessoryView) {
        self.inputAccessoryView = [UIView new];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow) name:UIKeyboardWillShowNotification object:nil];
    [self setupKeyboard:sjKeyboardType];
}

- (void)keyboardWillShow
{
    [self setupKeyboard:self.sjKeyboardType];
}

- (void)setupKeyboard:(SJKeyboardType)sjKeyboardType
{
    
    switch (sjKeyboardType) {
        case SJKeyboardTypeDefault:
            break;
        case SJKeyboardTypeNumber: {
            SJCustomKeyboardView *numberInputView = [[[NSBundle mainBundle] loadNibNamed:@"SJCustomKeyboardView" owner:self options:nil] lastObject];
            numberInputView.frame = CGRectMake(0, 0, SJSCREEN_WIDTH, SJNumberKeyboardHeight + SJCustomKeyboardBottomMargin);
            self.inputView = numberInputView;
            __weak typeof(self) weakSelf = self;
            numberInputView.textFieldReplacementString = ^(NSString * _Nonnull string) {
                BOOL canEditor = YES;
                if ([weakSelf.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
                    canEditor = [weakSelf.delegate textField:weakSelf shouldChangeCharactersInRange:NSMakeRange(weakSelf.text.length, 0) replacementString:string];
                }
                
                if (canEditor) {
                    [weakSelf replaceRange:weakSelf.selectedTextRange withText:string];
                }
            };
            numberInputView.textFieldShouldDelete = ^{
                BOOL canEditor = YES;
                if ([weakSelf.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)] && weakSelf.text.length) {
                    canEditor = [weakSelf.delegate textField:weakSelf shouldChangeCharactersInRange:NSMakeRange(weakSelf.text.length - 1, 1) replacementString:@""];
                }
                if (canEditor) {
                    [weakSelf deleteBackward];
                }
            };
            numberInputView.textFieldShouldClear = ^{
                BOOL canClear = YES;
                if ([weakSelf.delegate respondsToSelector:@selector(textFieldShouldClear:)]) {
                    canClear = [weakSelf.delegate textFieldShouldClear:weakSelf];
                }
                if (canClear) {
                    [weakSelf setText:@""];
                }
            };
            numberInputView.textFieldShouldReturn = ^{
                if ([weakSelf.delegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
                    [weakSelf.delegate textFieldShouldReturn:weakSelf];
                }
            };
            break;
        }
        case SJKeyboardTypeSafeNumber: {
            SJCustomKeyboardView *numberInputView = [[[NSBundle mainBundle] loadNibNamed:@"SJCustomKeyboardView" owner:self options:nil] lastObject];
            [numberInputView updateSaveNumberButton];
            numberInputView.frame = CGRectMake(0, 0, SJSCREEN_WIDTH, SJNumberKeyboardHeight + SJCustomKeyboardBottomMargin);
            self.inputView = numberInputView;
            __weak typeof(self) weakSelf = self;
            numberInputView.textFieldReplacementString = ^(NSString * _Nonnull string) {
                BOOL canEditor = YES;
                if ([weakSelf.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
                    canEditor = [weakSelf.delegate textField:weakSelf shouldChangeCharactersInRange:NSMakeRange(weakSelf.text.length, 0) replacementString:string];
                }
                
                if (canEditor) {
                    [weakSelf replaceRange:weakSelf.selectedTextRange withText:string];
                }
            };
            numberInputView.textFieldShouldDelete = ^{
                BOOL canEditor = YES;
                if ([weakSelf.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)] && weakSelf.text.length) {
                    canEditor = [weakSelf.delegate textField:weakSelf shouldChangeCharactersInRange:NSMakeRange(weakSelf.text.length - 1, 1) replacementString:@""];
                }
                if (canEditor) {
                    [weakSelf deleteBackward];
                }
            };
            numberInputView.textFieldShouldClear = ^{
                BOOL canClear = YES;
                if ([weakSelf.delegate respondsToSelector:@selector(textFieldShouldClear:)]) {
                    canClear = [weakSelf.delegate textFieldShouldClear:weakSelf];
                }
                if (canClear) {
                    [weakSelf setText:@""];
                }
            };
            numberInputView.textFieldShouldReturn = ^{
                if ([weakSelf.delegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
                    [weakSelf.delegate textFieldShouldReturn:weakSelf];
                }
            };
            break;
        }
    }
}

@end
