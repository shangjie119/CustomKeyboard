//
//  ViewController.m
//  SJCustomKeyboard
//
//  Created by sj on 2019/5/28.
//  Copyright © 2019 sj. All rights reserved.
//

#import "ViewController.h"

#import "UITextField+SJCustomKeyboard.h"

@interface ViewController ()<UITextFieldDelegate>


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITextField *numberTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 100, SJSCREEN_WIDTH - 40, 40)];
    numberTextField.placeholder = @"input number";
    numberTextField.borderStyle = UITextBorderStyleBezel;
    numberTextField.delegate = self;
    [self.view addSubview:numberTextField];
    numberTextField.sjKeyboardType = SJKeyboardTypeNumber;
    
    UITextField *safeNumberTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 160, SJSCREEN_WIDTH - 40, 40)];
    safeNumberTextField.placeholder = @"input safe number";
    safeNumberTextField.borderStyle = UITextBorderStyleBezel;
    safeNumberTextField.delegate = self;
    [self.view addSubview:safeNumberTextField];
    safeNumberTextField.sjKeyboardType = SJKeyboardTypeSafeNumber;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}


@end
