//
//  QDKeyboardNumPad.m
//  QDKeyboard
//
//  Created by chenbowen on 17/7/24.
//  Copyright © 2017年 chenbowen. All rights reserved.
//

#import "QDKeyboardNumPad.h"
#import "UIImage+ImageWithColor.h"


#define darkNormal [UIColor colorWithRed:171.0/255.0 green:178.0/255.0 blue:191.0/255.0 alpha:1.0]

@interface QDKeyboardNumPad ()

@property (nonatomic, strong) NSMutableArray *btnArray;
@property (nonatomic, weak) UITextField *responder;

@property (nonatomic ,strong) UIButton *wordSwitchBtn;
@property (nonatomic ,strong) UIButton *deleteBtn;
@property (nonatomic ,strong) UIButton *okBtn;

@property (nonatomic, readwrite,assign) QDKeyboardStyle style;

@end

@implementation QDKeyboardNumPad

- (instancetype)initWithFrame:(CGRect )frame Style:(QDKeyboardStyle )style{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.style = style;
        self.backgroundColor = [UIColor clearColor];
        [self addControl];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addControl];
    }
    return self;
}

- (void)addControl {
   
    NSMutableArray *btnArray = [NSMutableArray array];
    QDKeyBoardNormalButton *btn1 = [QDKeyBoardNormalButton buttonWithTitle:@"1" tag:0 delegate:self];
    [self addSubview:btn1];
    
    QDKeyBoardNormalButton *btn2 = [QDKeyBoardNormalButton buttonWithTitle:@"2" tag:1 delegate:self];
    [self addSubview:btn2];
    
    QDKeyBoardNormalButton *btn3 = [QDKeyBoardNormalButton buttonWithTitle:@"3" tag:2 delegate:self];
    [self addSubview:btn3];
    
    QDKeyBoardNormalButton *btn4 = [QDKeyBoardNormalButton buttonWithTitle:@"4" tag:4 delegate:self];
    [self addSubview:btn4];
    
    QDKeyBoardNormalButton *btn5 = [QDKeyBoardNormalButton buttonWithTitle:@"5" tag:5 delegate:self];
    [self addSubview:btn5];
    
    QDKeyBoardNormalButton *btn6 = [QDKeyBoardNormalButton buttonWithTitle:@"6" tag:6 delegate:self];
    [self addSubview:btn6];
    
    QDKeyBoardNormalButton *btn7 = [QDKeyBoardNormalButton buttonWithTitle:@"7" tag:8 delegate:self];
    [self addSubview:btn7];
    
    QDKeyBoardNormalButton *btn8 = [QDKeyBoardNormalButton buttonWithTitle:@"8" tag:9 delegate:self];
    [self addSubview:btn8];
    
    QDKeyBoardNormalButton *btn9 = [QDKeyBoardNormalButton buttonWithTitle:@"9" tag:10 delegate:self];
    [self addSubview:btn9];
    
    QDKeyBoardNormalButton *btn0 = [QDKeyBoardNormalButton buttonWithTitle:@"0" tag:13 delegate:self];
    [self addSubview:btn0];
    
    QDKeyBoardNormalButton *pointBtn = [QDKeyBoardNormalButton buttonWithTitle:@"." tag:14 delegate:self];
    [self addSubview:pointBtn];
    
    //设置数字键盘的abc
    [self addSubview:self.wordSwitchBtn];
    [self addSubview:self.deleteBtn];
    [self addSubview:self.okBtn];


    self.btnArray = btnArray;
    [self.btnArray addObject:btn1];
    [self.btnArray addObject:btn2];
    [self.btnArray addObject:btn3];
    [self.btnArray addObject:btn4];
    [self.btnArray addObject:btn5];
    [self.btnArray addObject:btn6];
    [self.btnArray addObject:btn7];
    [self.btnArray addObject:btn8];
    [self.btnArray addObject:btn9];
    [self.btnArray addObject:btn0];
    [self.btnArray addObject:pointBtn];
    
    [self.btnArray addObject:self.wordSwitchBtn];
    [self.btnArray addObject:self.deleteBtn];
    [self.btnArray addObject:self.okBtn];
    
    //两个很大的键
    for (int i = 0; i<self.btnArray.count; i++) {
       
        UIButton *btn = self.btnArray[i];
        btn.layer.cornerRadius = 5;
        btn.layer.masksToBounds = YES;
    }
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    CGFloat btnW = (self.frame.size.width - 5*margin)/4;
    CGFloat btnH = (self.frame.size.height - 5*margin)/4;
    
    for (QDKeyBoardNormalButton *btn in self.btnArray) {
        if (btn.tag == 7) {
            // 删除键
            btn.frame = CGRectMake(margin + 3 % 4 * (btnW + margin), margin, btnW, btnH*2 + margin);
        }  else if (btn.tag == 15) {
            // 确定键
            btn.frame = CGRectMake(margin + 11 % 4 * (btnW + margin), margin + 11 / 4 * (btnH + margin), btnW, btnH*2 + margin);
        } else {
            btn.frame = CGRectMake(margin + btn.tag % 4 * (btnW + margin), margin + btn.tag / 4 * (btnH + margin), btnW, btnH);
        }
    }
}

- (void)switchBtnClick:(UIButton *)btn {
    
    if ([self.delegate respondsToSelector:@selector(KeyboardNumPadDidClickSwitchBtn:)]) {
        [self.delegate KeyboardNumPadDidClickSwitchBtn:btn];
    }
}

- (void)deleteBtnClick:(UIButton *)btn {
    
    if (self.responder.text.length) {
        if ([self.delegate respondsToSelector:@selector(clearButtonAction:)]) {
            [self.delegate clearButtonAction:btn];
        }

    }
}

- (void)longPressGestureRecognizerAction:(UILongPressGestureRecognizer *)gestureRecognizer{
    
    if([self.delegate respondsToSelector:@selector(longPressGestureRecognizerAction:)]){
        
        [self.delegate longPressGestureRecognizerAction:gestureRecognizer];
    }
}


- (void)okBtnClick{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

#pragma mark - QDKeyBoardNormalButtonDelegate
-(void)KeyboardBtnDidClick:(QDKeyBoardNormalButton *)btn{
    
    if ([self.delegate respondsToSelector:@selector(inputButtonAction:)]) {
        [self.delegate inputButtonAction:btn];
    }
}


#pragma mark - lazy

- (UITextField *)responder{
    if (!_responder) {  // 防止多个输入框采用同一个inputview
        UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
        UIView *firstResponder = [keyWindow valueForKey:@"firstResponder"];
        _responder = (UITextField *)firstResponder;
    }
    return _responder;
}


-(UIButton *)deleteBtn{
    
    if (_deleteBtn == nil) {
        
        //设置删除按钮的size
        UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [deleteBtn setTitle:@"x" forState:UIControlStateNormal];
        //    [deleteBtn setImage:[UIImage imageNamed:@"images.bundle/keypadDeleteBtn"] forState:UIControlStateNormal];
        [deleteBtn setBackgroundImage:[UIImage imageNamed:@"keypadDeleteBtn"] forState:UIControlStateNormal];
        [deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc]
                                                                    initWithTarget:self
                                                                    action:@selector(longPressGestureRecognizerAction:)];
        longPressGestureRecognizer.cancelsTouchesInView = NO;
        [deleteBtn addGestureRecognizer:longPressGestureRecognizer];
        deleteBtn.tag = 7;
        _deleteBtn = deleteBtn;
    }
    return _deleteBtn;
}

-(UIButton *)wordSwitchBtn{
    if (_wordSwitchBtn == nil) {
        
        UIButton *wordSwitchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        wordSwitchBtn.enabled = NO;
        wordSwitchBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        //    [wordSwitchBtn setBackgroundImage:[UIImage imageNamed:@"images.bundle/keypadLongBtn"] forState:UIControlStateNormal];
        [wordSwitchBtn setBackgroundImage:[UIImage imageWithColor:darkNormal] forState:UIControlStateNormal];
        
        if (self.style != QDKeyboardStyleNumberPad) {
             wordSwitchBtn.enabled = YES;
            [wordSwitchBtn setTitle:@"abc" forState:UIControlStateNormal];
            [wordSwitchBtn addTarget:self action:@selector(switchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        wordSwitchBtn.tag = 12;
        _wordSwitchBtn = wordSwitchBtn;
    }
    
    return _wordSwitchBtn;
}

-(UIButton *)okBtn{
    
    if (_okBtn == nil) {
        
        UIButton *okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [okBtn setTitle:@"完成" forState:UIControlStateNormal];
        [okBtn addTarget:self action:@selector(okBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [okBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:11/255.0 green:98/255.0 blue:224/255.0 alpha:1]] forState:UIControlStateNormal];
        [okBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:11/255.0 green:98/255.0 blue:224/255.0 alpha:1]] forState:UIControlStateHighlighted];
        okBtn.tag = 15;
        
        _okBtn = okBtn;
    }
    return _okBtn;
}

@end

