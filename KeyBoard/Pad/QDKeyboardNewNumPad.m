//
//  QDKeyboardNewNumPad.m
//  QDKeyboard
//
//  Created by chenbowen on 2017/7/24.
//  Copyright © 2017年 chenbowen. All rights reserved.
//

#import "QDKeyboardNewNumPad.h"
#import "QDKeyboardBtn.h"
#import "UIImage+ImageWithColor.h"

#define row 4 //行
#define col 3 //列
#define rowGap 0.5 //行间距
#define colGap 0.5 //列间距
#define colorHighLight [UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:0.9]

@interface QDKeyboardNewNumPad ()<QDKeyboardBtnDelegate>
@property (nonatomic, strong) NSMutableArray *btnArray;
@property (nonatomic, weak) UITextField *responder;
@property (nonatomic ,strong) NSMutableArray *digitArr;
@property (nonatomic, readwrite,assign) QDKeyboardStyle style;

@property (nonatomic ,strong) QDKeyBoardNormalButton *deleteButton;
@property (nonatomic ,strong) QDKeyBoardNormalButton *placeHoldButton;

@end
@implementation QDKeyboardNewNumPad


- (instancetype)initWithFrame:(CGRect )frame Style:(QDKeyboardStyle )style{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.style = style;
        self.backgroundColor = [UIColor clearColor];
        [self addControl];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addControl];
    }
    return self;
}

- (void)addControl {
    
    NSMutableArray *btnArray = [NSMutableArray array];
    
    //digitArr 0~9
    for (int i = 0; i < self.digitArr.count; i ++) {
        
        NSString *title = [self.digitArr objectAtIndex:i];
        QDKeyBoardNormalButton *button = [QDKeyBoardNormalButton buttonWithTitle:title tag:i delegate:self];
        
        if (i == self.digitArr.count -1) {
            button.tag = 10;//特殊设置第4行中间位置
        }
        
        [self addSubview:button];
        [btnArray addObject:button];
    }
    
    [self addSubview:self.deleteButton];
    [self addSubview:self.placeHoldButton];
    
    [btnArray addObject:self.deleteButton];
    [btnArray addObject:self.placeHoldButton];
    
    self.btnArray = btnArray;
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    CGFloat btnW = (self.frame.size.width - (col - 1)*colGap)/col;
    CGFloat btnH = (self.frame.size.height - (row - 1)*rowGap)/row;
    
    
    for (UIButton *button in self.btnArray) {
        
        NSInteger i = button.tag;
        
        int colNum = i % col;//列
        int rowNum = (int)(i / col);//列
        
        button.frame = CGRectMake(colNum * (btnW + colGap),rowNum * (btnH + rowGap), btnW, btnH);
    }
}


#pragma mark - QDKeyboardBtnDelegate
-(void)KeyboardBtnDidClick:(UIButton *)btn{
    
    //过滤空的按钮按钮
    if (btn.tag == 9) {
        //设置是换键盘还是占位
        if (self.style == QDKeyboardStyleNumberPad) {
            return;
        }else{
            if ([self.delegate respondsToSelector:@selector(KeyboardNumPadDidClickSwitchBtn:)]) {
                [self.delegate KeyboardNumPadDidClickSwitchBtn:btn];
            }
        }
    }else if (btn.tag == 11){
        
        if (self.responder.text.length) {
            if ([self.delegate respondsToSelector:@selector(clearButtonAction:)]) {
                [self.delegate clearButtonAction:btn];
            }
        }
    }else{
        
        if ([self.delegate respondsToSelector:@selector(inputButtonAction:)]) {
            [self.delegate inputButtonAction:btn];
        }
    }
}

- (void)longPressGestureRecognizerAction:(UILongPressGestureRecognizer *)gestureRecognizer{
    
    if([self.delegate respondsToSelector:@selector(longPressGestureRecognizerAction:)]){
        
        [self.delegate longPressGestureRecognizerAction:gestureRecognizer];
        
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

- (NSMutableArray *)digitArr{
    
    if (_digitArr == nil) {
        
        NSMutableArray *shuffledAlphabet = [NSMutableArray array];
        for (int i = 0; i < 10; i ++) {
            
            NSString *str = [NSString stringWithFormat:@"%zd",i];
            [shuffledAlphabet addObject:str];
        }
        
        
        for (NSUInteger i = 0; i < [shuffledAlphabet count]; ++i) {
            // Select a random element between i and end of array to swap with.
            long nElements = [shuffledAlphabet count] - i;
            long n = (random() % nElements) + i;
            [shuffledAlphabet exchangeObjectAtIndex:i withObjectAtIndex:n];
        }
        
        _digitArr = shuffledAlphabet;
        
    }
    return  _digitArr;
}

-(QDKeyBoardNormalButton *)placeHoldButton{
    
    if (_placeHoldButton == nil) {
        
        QDKeyBoardNormalButton *placeHoldButton = [QDKeyBoardNormalButton buttonWithTitle:@"" tag:9 delegate:self];
        [placeHoldButton setBackgroundImage:[UIImage imageWithColor:colorHighLight] forState:UIControlStateNormal];
        if (self.style!=QDKeyboardStyleNumberPad) {
            [placeHoldButton setTitle:@"abc" forState:UIControlStateNormal];
        }
        placeHoldButton.enabled = !(self.style==QDKeyboardStyleNumberPad);
        _placeHoldButton = placeHoldButton;
    }
    return _placeHoldButton;
    
}


-(QDKeyBoardNormalButton *)deleteButton{
    
    if (_deleteButton == nil) {
        
        QDKeyBoardNormalButton *deleteButton = [QDKeyBoardNormalButton buttonWithTitle:@"" tag:11 delegate:self];
        [deleteButton setBackgroundImage:[UIImage imageNamed:@"keypadDeleteBtn"] forState:UIControlStateNormal];
        UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc]
                                                                    initWithTarget:self
                                                                    action:@selector(longPressGestureRecognizerAction:)];
        longPressGestureRecognizer.cancelsTouchesInView = NO;
        [deleteButton addGestureRecognizer:longPressGestureRecognizer];
        _deleteButton = deleteButton;
    }
    return _deleteButton;
}

@end
