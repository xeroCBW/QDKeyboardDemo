//
//  QDKeyboard.m
//  QDKeyboard
//
//  Created by chenbowen on 17/7/24.
//  Copyright © 2017年 chenbowen. All rights reserved.
//

#import "QDKeyboard.h"
#import "QDKeyboardNumPad.h"
#import "QDKeyboardWordPad.h"
#import "QDKeyboardNewNumPad.h"
#import "QDKeyboardSymbolPad.h"
#import <AudioToolbox/AudioToolbox.h>

#define  iPhone4     ([[UIScreen mainScreen] bounds].size.height==480)
#define  iPhone5     ([[UIScreen mainScreen] bounds].size.height==568)
#define  iPhone6     ([[UIScreen mainScreen] bounds].size.height==667)
#define  iPhone6plus ([[UIScreen mainScreen] bounds].size.height==736)


@interface QDKeyboard ()<QDKeyboardNumPadDelegate,QDKeyboardWordPadDelegate,QDKeyboardSymbolPadDelegate>{
    
    struct {
        unsigned int textInputSupportsShouldChangeTextInRange : 1;
        unsigned int delegateSupportsTextFieldShouldChangeCharactersInRange : 1;
        unsigned int delegateSupportsTextViewShouldChangeTextInRange : 1;
    } _delegateFlags;

}


@property (weak, readwrite, nonatomic) UIResponder<UITextInput> *textInput;

//@property (nonatomic, strong) QDKeyboardNumPad *numPad;
@property (nonatomic, strong) QDKeyboardWordPad *wordPad;
@property (nonatomic, strong) QDKeyboardSymbolPad *symbolPad;
@property (nonatomic, strong) QDKeyboardNewNumPad *numPad;

@property (nonatomic,readwrite,assign) QDKeyboardStyle style;//对于外面readOnly属性;里面设置readWrite
@property (nonatomic ,assign)BOOL clearButtonLongPressGesture;;

@end

@implementation QDKeyboard

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithRed:116/255.0 green:144/255.0 blue:194/255.0 alpha:0.2];
        CGRect rect = CGRectZero;
        if (iPhone4 || iPhone5) {
            //            rect = CGRectMake(0, 0, 320, 180);
            rect = CGRectMake(0, 0, 320, 216);
        }else if (iPhone6){
            //            rect = CGRectMake(0, 0, 375, 375/320*180);
            rect = CGRectMake(0, 0, 375, 216);
        }else{
            //            rect = CGRectMake(0, 0, 414, 414/320*180);
            rect = CGRectMake(0, 0, 414, 226);
        }
        
        self.frame = rect;
        [self addNotificationsObservers];
    }
    return self;
}

- (instancetype)initWithStyle:(QDKeyboardStyle )style{
    
    self = [self init];
    if (self) {
        
        self.style = style;
        [self addSubview:self.numPad];
    }
    return self;
}


- (void)dealloc {
    
    NSLog(@"%s",__func__);
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Notifications

- (void)addNotificationsObservers {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textDidBeginEditing:)
                                                 name:UITextFieldTextDidBeginEditingNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textDidBeginEditing:)
                                                 name:UITextViewTextDidBeginEditingNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textDidEndEditing:)
                                                 name:UITextFieldTextDidEndEditingNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textDidEndEditing:)
                                                 name:UITextViewTextDidEndEditingNotification
                                               object:nil];
    
//    [[NSNotificationCenter defaultCenter]addObserver:self
//                                            selector:@selector(didTakeScreenshot:)
//                                                name:UIApplicationUserDidTakeScreenshotNotification
//                                              object:nil];
}

- (void)textDidBeginEditing:(NSNotification *)notification {
    if (![notification.object conformsToProtocol:@protocol(UITextInput)]) {
        return;
    }
    
    UIResponder<UITextInput> *textInput = notification.object;
    
    if (textInput.inputView && self == textInput.inputView) {
        self.textInput = textInput;
        
        _delegateFlags.textInputSupportsShouldChangeTextInRange = NO;
        _delegateFlags.delegateSupportsTextFieldShouldChangeCharactersInRange = NO;
        _delegateFlags.delegateSupportsTextViewShouldChangeTextInRange = NO;
        
        if ([self.textInput respondsToSelector:@selector(shouldChangeTextInRange:replacementText:)]) {
            _delegateFlags.textInputSupportsShouldChangeTextInRange = YES;
        }
        else if ([self.textInput isKindOfClass:[UITextField class]]) {
            id<UITextFieldDelegate> delegate = [(UITextField *)self.textInput delegate];
            if ([delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
                _delegateFlags.delegateSupportsTextFieldShouldChangeCharactersInRange = YES;
            }
        }
        else if ([self.textInput isKindOfClass:[UITextView class]]) {
            id<UITextViewDelegate> delegate = [(UITextView *)self.textInput delegate];
            if ([delegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)]) {
                _delegateFlags.delegateSupportsTextViewShouldChangeTextInRange = YES;
            }
        }
    }
}


- (void)textDidEndEditing:(NSNotification *)notification {
    self.textInput = nil;
}

+ (NSRange)selectedRange:(id<UITextInput>)textInput {
    UITextRange *textRange = [textInput selectedTextRange];
    
    NSInteger startOffset = [textInput offsetFromPosition:textInput.beginningOfDocument toPosition:textRange.start];
    NSInteger endOffset = [textInput offsetFromPosition:textInput.beginningOfDocument toPosition:textRange.end];
    
    return NSMakeRange(startOffset, endOffset - startOffset);
}



#pragma mark - 系统自定义三种键盘切换
- (void)KeyboardNumPadDidClickSwitchBtn:(UIButton *)btn {
    
    if ([btn.titleLabel.text isEqualToString:@"abc"]) {
        
        [self addSubview:self.wordPad];
        [self.numPad removeFromSuperview];
    }
}

- (void)KeyboardWordPadDidClickSwitchBtn:(UIButton *)btn {
   
    if ([btn.titleLabel.text isEqualToString:@"123"]) {
        
        [self addSubview:self.numPad];
        [self.wordPad removeFromSuperview];
        
    }else if ([btn.titleLabel.text isEqualToString:@"#+="]){
        
        [self addSubview:self.symbolPad];
        [self.wordPad removeFromSuperview];
    }
}

- (void)KeyboardSymbolPadDidClickSwitchBtn:(UIButton *)btn {
    
    if ([btn.titleLabel.text isEqualToString:@"123"]) {
        
        [self addSubview:self.numPad];
        [self.symbolPad removeFromSuperview];
        
    } else if ([btn.titleLabel.text isEqualToString:@"abc"]) {
        
        [self addSubview:self.wordPad];
        [self.symbolPad removeFromSuperview];
        
    }
}


#pragma mark - 字符串处理

- (void)inputButtonAction:(UIButton *)sender {
    
    if (!self.textInput) {
        return;
    }
    
    NSString *text = sender.currentTitle;
    
    if (_delegateFlags.textInputSupportsShouldChangeTextInRange) {
        if ([self.textInput shouldChangeTextInRange:self.textInput.selectedTextRange replacementText:text]) {
            [self.textInput insertText:text];
        }
    }
    else if (_delegateFlags.delegateSupportsTextFieldShouldChangeCharactersInRange) {
        NSRange selectedRange = [[self class] selectedRange:self.textInput];
        UITextField *textField = (UITextField *)self.textInput;
        if ([textField.delegate textField:textField shouldChangeCharactersInRange:selectedRange replacementString:text]) {
            [self.textInput insertText:text];
        }
    }
    else if (_delegateFlags.delegateSupportsTextViewShouldChangeTextInRange) {
        NSRange selectedRange = [[self class] selectedRange:self.textInput];
        UITextView *textView = (UITextView *)self.textInput;
        if ([textView.delegate textView:textView shouldChangeTextInRange:selectedRange replacementText:text]) {
            [self.textInput insertText:text];
        }
    }
    else {
        [self.textInput insertText:text];
    }
}

- (void)clearButtonAction:(UIButton *)sender{
    
//    AudioServicesPlaySystemSound(1105);//按键时播放系统声音
    
    if (!self.textInput) {
        return;
    }
    
    if (_delegateFlags.textInputSupportsShouldChangeTextInRange) {
        UITextRange *textRange = self.textInput.selectedTextRange;
        if ([textRange.start isEqual:textRange.end]) {
            UITextPosition *newStart = [self.textInput positionFromPosition:textRange.start inDirection:UITextLayoutDirectionLeft offset:1];
            textRange = [self.textInput textRangeFromPosition:newStart toPosition:textRange.end];
        }
        if ([self.textInput shouldChangeTextInRange:textRange replacementText:@""]) {
            [self.textInput deleteBackward];
        }
    }
    else if (_delegateFlags.delegateSupportsTextFieldShouldChangeCharactersInRange) {
        NSRange selectedRange = [[self class] selectedRange:self.textInput];
        if (selectedRange.length == 0 && selectedRange.location > 0) {
            selectedRange.location--;
            selectedRange.length = 1;
        }
        UITextField *textField = (UITextField *)self.textInput;
        if ([textField.delegate textField:textField shouldChangeCharactersInRange:selectedRange replacementString:@""]) {
            [self.textInput deleteBackward];
        }
    }
    else if (_delegateFlags.delegateSupportsTextViewShouldChangeTextInRange) {
        NSRange selectedRange = [[self class] selectedRange:self.textInput];
        if (selectedRange.length == 0 && selectedRange.location > 0) {
            selectedRange.location--;
            selectedRange.length = 1;
        }
        UITextView *textView = (UITextView *)self.textInput;
        if ([textView.delegate textView:textView shouldChangeTextInRange:selectedRange replacementText:@""]) {
            [self.textInput deleteBackward];
        }
    }
    else {
        [self.textInput deleteBackward];
    }
}

#pragma mark - Clear button long press

- (void)longPressGestureRecognizerAction:(UILongPressGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        _clearButtonLongPressGesture = YES;
        [self clearButtonActionLongPress];
    }
    else if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        _clearButtonLongPressGesture = NO;
    }
}

- (void)clearButtonActionLongPress{
    if (_clearButtonLongPressGesture) {
        if ([self.textInput hasText]) {
            [[UIDevice currentDevice] playInputClick];
            
            [self clearButtonAction:nil];
            [self performSelector:@selector(clearButtonActionLongPress) withObject:nil afterDelay:0.1]; // delay like in iOS keyboard
        }
        else {
            _clearButtonLongPressGesture = NO;
        }
    }
}



#pragma mark - lazy

//-(QDKeyboardNumPad *)numPad{
//    
//    if (_numPad == nil) {
//        
//        QDKeyboardNumPad *numPad = [[QDKeyboardNumPad alloc] initWithFrame:self.bounds Style:self.style];
//        numPad.delegate = self;
//       _numPad = numPad;
//    }
//    
//    return _numPad;
//}

-(QDKeyboardNewNumPad *)numPad{
    
    if (_numPad == nil) {
        QDKeyboardNewNumPad *numPad = [[QDKeyboardNewNumPad alloc]initWithFrame:self.bounds Style:self.style];
        numPad.delegate  = self;
        _numPad = numPad;
    }
    return _numPad;
}

- (QDKeyboardSymbolPad *)symbolPad{
    
    
    if (_symbolPad == nil) {

        QDKeyboardSymbolPad *symbolPad = [[QDKeyboardSymbolPad alloc] initWithFrame:self.bounds];
        symbolPad.delegate = self;
        _symbolPad = symbolPad;
    }
    
    return _symbolPad;
}

-(QDKeyboardWordPad *)wordPad{
    
    
    if (_wordPad == nil) {
        QDKeyboardWordPad *wordPad = [[QDKeyboardWordPad alloc] initWithFrame:self.bounds];
        wordPad.delegate = self;
        _wordPad = wordPad;
    }
    
    return _wordPad;
}


@end

