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

- (SJKeyboardType)sjKeyboardType
{
    return [objc_getAssociatedObject(self, &sjKeyboardTypeKey) integerValue];
}

- (void)setSjKeyboardType:(SJKeyboardType)sjKeyboardType
{
    objc_setAssociatedObject(self, &sjKeyboardTypeKey, @(sjKeyboardType), OBJC_ASSOCIATION_ASSIGN);
    [self setupKeyboard:sjKeyboardType];
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
            numberInputView.textFieldReplacementString = ^(NSString * _Nonnull string) {
                BOOL canEditor = YES;
                if ([self.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
                    canEditor = [self.delegate textField:self shouldChangeCharactersInRange:NSMakeRange(self.text.length, 0) replacementString:string];
                }
                
                if (canEditor) {
                    [self replaceRange:self.selectedTextRange withText:string];
                }
            };
            numberInputView.textFieldShouldDelete = ^{
                BOOL canEditor = YES;
                if ([self.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)] && self.text.length) {
                    canEditor = [self.delegate textField:self shouldChangeCharactersInRange:NSMakeRange(self.text.length - 1, 1) replacementString:@""];
                }
                if (canEditor) {
                    [self deleteBackward];
                }
            };
            numberInputView.textFieldShouldClear = ^{
                BOOL canClear = YES;
                if ([self.delegate respondsToSelector:@selector(textFieldShouldClear:)]) {
                    canClear = [self.delegate textFieldShouldClear:self];
                }
                if (canClear) {
                    [self setText:@""];
                }
            };
            numberInputView.textFieldShouldReturn = ^{
                if ([self.delegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
                    [self.delegate textFieldShouldReturn:self];
                }
            };
            break;
        }
    }
}

@end
