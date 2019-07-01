//
//  SJCustomKeyboardView.m
//  SJCustomKeyboard
//
//  Created by sj on 2019/5/28.
//  Copyright © 2019 sj. All rights reserved.
//

#import "SJCustomKeyboardView.h"

#define SJColorFromHexA(hexValue, a)     [UIColor colorWithRed:(((hexValue & 0xFF0000) >> 16))/255.0f green:(((hexValue & 0xFF00) >> 8))/255.0f blue:((hexValue & 0xFF))/255.0f alpha:a]
#define SJColorFromHex(hexValue)        SJColorFromHexA(hexValue, 1.0f)
#define SJColorFrom255RGBA(r, g, b, a)  ([UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a])
#define SJColorFrom255RGB(r, g, b)      SJColorFrom255RGBA(r,g,b,1.0f)

@interface SJCustomKeyboardView ()

@property (weak, nonatomic) IBOutlet UIButton *inputButtonOne;
@property (weak, nonatomic) IBOutlet UIButton *inputButtonTwo;
@property (weak, nonatomic) IBOutlet UIButton *inputButtonThree;
@property (weak, nonatomic) IBOutlet UIButton *inputButtonFour;
@property (weak, nonatomic) IBOutlet UIButton *inputButtonFive;
@property (weak, nonatomic) IBOutlet UIButton *inputButtonSix;
@property (weak, nonatomic) IBOutlet UIButton *inputButtonSeven;
@property (weak, nonatomic) IBOutlet UIButton *inputButtonEight;
@property (weak, nonatomic) IBOutlet UIButton *inputButtonNine;
@property (weak, nonatomic) IBOutlet UIButton *inputButtonPoint;
@property (weak, nonatomic) IBOutlet UIButton *inputButtonZero;
@property (weak, nonatomic) IBOutlet UIButton *minusButton;
@property (weak, nonatomic) IBOutlet UIButton *positiveButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;

@end

@implementation SJCustomKeyboardView

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self configSubviews];
}

// 设置视图
- (void)configSubviews
{
    [self.inputButtonOne addTarget:self action:@selector(inputButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.inputButtonOne setBackgroundImage:[self imageColor:SJColorFromHex(0xE7E8E9)] forState:UIControlStateHighlighted];
    self.inputButtonOne.tag = 7701;
    
    [self.inputButtonTwo addTarget:self action:@selector(inputButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.inputButtonTwo setBackgroundImage:[self imageColor:SJColorFromHex(0xE7E8E9)] forState:UIControlStateHighlighted];
    self.inputButtonTwo.tag = 7702;
    
    [self.inputButtonThree addTarget:self action:@selector(inputButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.inputButtonThree setBackgroundImage:[self imageColor:SJColorFromHex(0xE7E8E9)] forState:UIControlStateHighlighted];
    self.inputButtonThree.tag = 7703;
    
    [self.inputButtonFour addTarget:self action:@selector(inputButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.inputButtonFour setBackgroundImage:[self imageColor:SJColorFromHex(0xE7E8E9)] forState:UIControlStateHighlighted];
    self.inputButtonFour.tag = 7704;
    
    [self.inputButtonFive addTarget:self action:@selector(inputButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.inputButtonFive setBackgroundImage:[self imageColor:SJColorFromHex(0xE7E8E9)] forState:UIControlStateHighlighted];
    self.inputButtonFive.tag = 7705;
    
    [self.inputButtonSix addTarget:self action:@selector(inputButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.inputButtonSix setBackgroundImage:[self imageColor:SJColorFromHex(0xE7E8E9)] forState:UIControlStateHighlighted];
    self.inputButtonSix.tag = 7706;
    
    [self.inputButtonSeven addTarget:self action:@selector(inputButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.inputButtonSeven setBackgroundImage:[self imageColor:SJColorFromHex(0xE7E8E9)] forState:UIControlStateHighlighted];
    self.inputButtonSeven.tag = 7707;
    
    [self.inputButtonEight addTarget:self action:@selector(inputButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.inputButtonEight setBackgroundImage:[self imageColor:SJColorFromHex(0xE7E8E9)] forState:UIControlStateHighlighted];
    self.inputButtonEight.tag = 7708;
    
    [self.inputButtonNine addTarget:self action:@selector(inputButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.inputButtonNine setBackgroundImage:[self imageColor:SJColorFromHex(0xE7E8E9)] forState:UIControlStateHighlighted];
    self.inputButtonNine.tag = 7709;
    
    [self.inputButtonZero addTarget:self action:@selector(inputButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.inputButtonZero setBackgroundImage:[self imageColor:SJColorFromHex(0xE7E8E9)] forState:UIControlStateHighlighted];
    self.inputButtonZero.tag = 7700;
    
    [self.inputButtonPoint addTarget:self action:@selector(inputButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.inputButtonPoint setBackgroundImage:[self imageColor:SJColorFromHex(0xE7E8E9)] forState:UIControlStateHighlighted];
    self.inputButtonPoint.tag = 7710;
    
    [self.positiveButton addTarget:self action:@selector(positiveButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.positiveButton setBackgroundImage:[self imageColor:SJColorFromHex(0xE7E8E9)] forState:UIControlStateHighlighted];
    self.positiveButton.tag = 7711;
    
    [self.minusButton addTarget:self action:@selector(minusButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.minusButton setBackgroundImage:[self imageColor:SJColorFromHex(0xE7E8E9)] forState:UIControlStateHighlighted];
    self.minusButton.tag = 7712;
    
    [self.minusButton addTarget:self action:@selector(minusButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.minusButton setBackgroundImage:[self imageColor:SJColorFromHex(0xE7E8E9)] forState:UIControlStateHighlighted];
    
    [self.deleteButton addTarget:self action:@selector(deleteButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.deleteButton setBackgroundImage:[self imageColor:SJColorFromHex(0xE7E8E9)] forState:UIControlStateHighlighted];
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(deleteButtonLongPress)];
    [self.deleteButton addGestureRecognizer:longPress];
    
    [self.confirmButton addTarget:self action:@selector(confirmButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)updateSaveNumberButton
{
    NSMutableArray *numberArray = [NSMutableArray arrayWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", nil];
    
    [self.inputButtonOne addTarget:self action:@selector(inputButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.inputButtonOne setBackgroundImage:[self imageColor:SJColorFromHex(0xE7E8E9)] forState:UIControlStateHighlighted];
    {
        NSInteger index = arc4random() % 10;
        [self.inputButtonOne setTitle:numberArray[index] forState:UIControlStateNormal];
        self.inputButtonOne.tag = 7700 + [numberArray[index] integerValue];
        [numberArray removeObjectAtIndex:index];
    }
    
    [self.inputButtonTwo addTarget:self action:@selector(inputButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.inputButtonTwo setBackgroundImage:[self imageColor:SJColorFromHex(0xE7E8E9)] forState:UIControlStateHighlighted];
    {
        NSInteger index = arc4random() % 9;
        [self.inputButtonTwo setTitle:numberArray[index] forState:UIControlStateNormal];
        self.inputButtonTwo.tag = 7700 + [numberArray[index] integerValue];
        [numberArray removeObjectAtIndex:index];
    }
    
    [self.inputButtonThree addTarget:self action:@selector(inputButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.inputButtonThree setBackgroundImage:[self imageColor:SJColorFromHex(0xE7E8E9)] forState:UIControlStateHighlighted];
    {
        NSInteger index = arc4random() % 8;
        [self.inputButtonThree setTitle:numberArray[index] forState:UIControlStateNormal];
        self.inputButtonThree.tag = 7700 + [numberArray[index] integerValue];
        [numberArray removeObjectAtIndex:index];
    }
    
    [self.inputButtonFour addTarget:self action:@selector(inputButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.inputButtonFour setBackgroundImage:[self imageColor:SJColorFromHex(0xE7E8E9)] forState:UIControlStateHighlighted];
    {
        NSInteger index = arc4random() % 7;
        [self.inputButtonFour setTitle:numberArray[index] forState:UIControlStateNormal];
        self.inputButtonFour.tag = 7700 + [numberArray[index] integerValue];
        [numberArray removeObjectAtIndex:index];
    }
    
    [self.inputButtonFive addTarget:self action:@selector(inputButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.inputButtonFive setBackgroundImage:[self imageColor:SJColorFromHex(0xE7E8E9)] forState:UIControlStateHighlighted];
    {
        NSInteger index = arc4random() % 6;
        [self.inputButtonFive setTitle:numberArray[index] forState:UIControlStateNormal];
        self.inputButtonFive.tag = 7700 + [numberArray[index] integerValue];
        [numberArray removeObjectAtIndex:index];
    }
    
    [self.inputButtonSix addTarget:self action:@selector(inputButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.inputButtonSix setBackgroundImage:[self imageColor:SJColorFromHex(0xE7E8E9)] forState:UIControlStateHighlighted];
    {
        NSInteger index = arc4random() % 5;
        [self.inputButtonSix setTitle:numberArray[index] forState:UIControlStateNormal];
        self.inputButtonSix.tag = 7700 + [numberArray[index] integerValue];
        [numberArray removeObjectAtIndex:index];
    }
    
    [self.inputButtonSeven addTarget:self action:@selector(inputButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.inputButtonSeven setBackgroundImage:[self imageColor:SJColorFromHex(0xE7E8E9)] forState:UIControlStateHighlighted];
    {
        NSInteger index = arc4random() % 4;
        [self.inputButtonSeven setTitle:numberArray[index] forState:UIControlStateNormal];
        self.inputButtonSeven.tag = 7700 + [numberArray[index] integerValue];
        [numberArray removeObjectAtIndex:index];
    }
    
    [self.inputButtonEight addTarget:self action:@selector(inputButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.inputButtonEight setBackgroundImage:[self imageColor:SJColorFromHex(0xE7E8E9)] forState:UIControlStateHighlighted];
    {
        NSInteger index = arc4random() % 3;
        [self.inputButtonEight setTitle:numberArray[index] forState:UIControlStateNormal];
        self.inputButtonEight.tag = 7700 + [numberArray[index] integerValue];
        [numberArray removeObjectAtIndex:index];
    }
    
    [self.inputButtonNine addTarget:self action:@selector(inputButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.inputButtonNine setBackgroundImage:[self imageColor:SJColorFromHex(0xE7E8E9)] forState:UIControlStateHighlighted];
    {
        NSInteger index = arc4random() % 2;
        [self.inputButtonNine setTitle:numberArray[index] forState:UIControlStateNormal];
        self.inputButtonNine.tag = 7700 + [numberArray[index] integerValue];
        [numberArray removeObjectAtIndex:index];
    }
    
    [self.inputButtonZero addTarget:self action:@selector(inputButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.inputButtonZero setBackgroundImage:[self imageColor:SJColorFromHex(0xE7E8E9)] forState:UIControlStateHighlighted];
    {
        NSInteger index = 0;
        [self.inputButtonZero setTitle:numberArray[index] forState:UIControlStateNormal];
        self.inputButtonZero.tag = 7700 + [numberArray[index] integerValue];
        [numberArray removeObjectAtIndex:index];
    }
}

// 点击数字 和 .
- (void)inputButtonClicked:(UIButton *)button
{
    NSInteger number = button.tag - 7700;
    if (self.textFieldReplacementString) {
        if (10 == number) {
            self.textFieldReplacementString(@".");
        } else {
            self.textFieldReplacementString(@(number).stringValue);
        }
    }
}

// 点击负数按钮
- (void)minusButtonClicked:(UIButton *)button
{
    if (self.textFieldReplacementString) {
        self.textFieldReplacementString(@"-");
    }
}

// 点击正数按钮
- (void)positiveButtonClicked:(UIButton *)button
{
    if (self.textFieldReplacementString) {
        self.textFieldReplacementString(@"+");
    }
}

// 删除
- (void)deleteButtonClicked:(UIButton *)button
{
    if (self.textFieldShouldDelete) {
        self.textFieldShouldDelete();
    }
}

// 清空
- (void)deleteButtonLongPress
{
    if (self.textFieldShouldClear) {
        self.textFieldShouldClear();
    }
}

// 确定
- (void)confirmButtonClicked:(UIButton *)button
{
    if (self.textFieldShouldReturn) {
        self.textFieldShouldReturn();
    }
}

- (UIImage *)imageColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapSquare);
    CGContextSetLineWidth(context, 1.0);
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
