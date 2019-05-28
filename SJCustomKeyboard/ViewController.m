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

@property (nonatomic, strong) UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(20, 100, SJSCREEN_WIDTH - 40, 40)];
    self.textField.placeholder = @"input";
    self.textField.borderStyle = UITextBorderStyleBezel;
    self.textField.delegate = self;
    [self.view addSubview:self.textField];
    
    self.textField.sjKeyboardType = SJKeyboardTypeNumber;
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
