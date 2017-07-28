//
//  TestViewController.m
//  QDKeyboard
//
//  Created by chenbowen on 2017/7/27.
//  Copyright © 2017年 chenbowen. All rights reserved.
//

#import "TestViewController.h"
#import "QDKeyboard.h"
#import "QDKeyboardNewNumPad.h"

@interface TestViewController ()

@end

@implementation TestViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(70, 100, [UIScreen mainScreen].bounds.size.width - 140, 30);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:25];
    titleLabel.textColor = [UIColor redColor];
    titleLabel.text = @"自定义键盘";
    [self.view addSubview:titleLabel];
    
    
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(70, 350, [UIScreen mainScreen].bounds.size.width - 140, 40)];
    [textField setTintColor:[UIColor redColor]];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.placeholder = @"这是一个输入框";
    [self.view addSubview:textField];
    textField.inputView = [[QDKeyboard alloc] initWithStyle:QDKeyboardStyleDefault];
    
    UITextField *textField2 = [[UITextField alloc] initWithFrame:CGRectMake(70, 400, [UIScreen mainScreen].bounds.size.width - 140, 40)];
    [textField2 setTintColor:[UIColor redColor]];
    textField2.borderStyle = UITextBorderStyleRoundedRect;
    textField2.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField2.placeholder = @"这是一个纯数字输入框";
    //    self.testTF = textField;
    [self.view addSubview:textField2];
    textField2.inputView = [[[QDKeyboard alloc] init]initWithStyle:QDKeyboardStyleNumberPad];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(70, 450, [UIScreen mainScreen].bounds.size.width - 140, 40)];
    [textView setTintColor:[UIColor redColor]];
    textView.layer.borderWidth = 1.0f;
    textView.layer.borderColor = [[UIColor grayColor] CGColor];
    [self.view addSubview:textView];
    textView.inputView = [[[QDKeyboard alloc] init]initWithStyle:QDKeyboardStyleNumberPad];
    
    UITextView *textView2 = [[UITextView alloc] initWithFrame:CGRectMake(70, 500, [UIScreen mainScreen].bounds.size.width - 140, 40)];
    [textView2 setTintColor:[UIColor redColor]];
    textView2.layer.borderWidth = 1.0f;
    textView2.layer.borderColor = [[UIColor grayColor] CGColor];
    [self.view addSubview:textView2];
    textView2.inputView = [[[QDKeyboard alloc] init]initWithStyle:QDKeyboardStyleDefault];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [super touchesBegan: touches withEvent:event];
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
