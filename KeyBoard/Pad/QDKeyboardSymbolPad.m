//
//  QDKeyboardSymbolPad.m
//  QDKeyboard
//
//  Created by chenbowen on 2017/7/25.
//  Copyright © 2017年 chenbowen. All rights reserved.
//

#import "QDKeyboardSymbolPad.h"
#import "UIImage+ImageWithColor.h"


#define darkNormal [UIColor colorWithRed:171.0/255.0 green:178.0/255.0 blue:191.0/255.0 alpha:1.0]
#define colGap 12 //行间距 12
#define topColGap colGap
#define bottomColGap 0.4*colGap
#define rowGap 5 //列间距 5



@interface QDKeyboardSymbolPad ()

@property (nonatomic, weak) UITextField *responder;

@property (nonatomic, strong) NSMutableArray <NSString *>*symbolArray;
@property (nonatomic, strong) NSMutableArray *btnArray;
@property (nonatomic, strong) UIButton *deleteBtn;
@property (nonatomic, strong) UIButton *numBtn;
@property (nonatomic, strong) UIButton *wordButton;

@end

@implementation QDKeyboardSymbolPad


#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addControl];
    }
    return self;
}

- (void)addControl {
    
    NSMutableArray *btnArray = [NSMutableArray array];
    for (int i = 0; i< self.symbolArray.count; i++) {// 添加26个英文字母
        QDKeyboardBtn *btn = [QDKeyboardBtn buttonWithTitle:self.symbolArray[i] tag:i delegate:self];
        
        [btn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:11/255.0 green:98/255.0 blue:224/255.0 alpha:1]] forState:UIControlStateHighlighted];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
        [btnArray addObject:btn];
        [self addSubview:btn];
    }
    
    
    // 删除键/数字键/字母键
    [btnArray addObject:self.deleteBtn];
    [btnArray addObject:self.numBtn];
    [btnArray addObject:self.wordButton];
    
    [self addSubview:self.deleteBtn];
    [self addSubview:self.numBtn];
    [self addSubview:self.wordButton];
    
   self.btnArray = btnArray;
}


- (void)layoutSubviews {
    
    [super layoutSubviews];
    CGFloat smallBtnW = (self.frame.size.width - 11*rowGap)/10;
    CGFloat btnH = (self.frame.size.height - 3*colGap - topColGap - bottomColGap)/4;
    
    
    for (int i = 0; i < 10; i++) {
        QDKeyboardBtn *btn = self.btnArray[i];
        btn.frame = CGRectMake(rowGap + (i%10)*(smallBtnW + rowGap), topColGap, smallBtnW, btnH);
    }
    
    
    for (int i = 10; i < 20; i++) {
        QDKeyboardBtn *btn = self.btnArray[i];
        btn.frame = CGRectMake(rowGap + (i%10)*(smallBtnW + rowGap), topColGap + colGap + btnH, smallBtnW, btnH);
    }
    
    
    for (int i = 20; i < 28; i++) {
        QDKeyboardBtn *btn = self.btnArray[i];
        btn.frame = CGRectMake(rowGap + (i%10)*(smallBtnW + rowGap), topColGap + 2*(colGap + btnH), smallBtnW, btnH);
    }
     self.deleteBtn.frame = CGRectMake(self.frame.size.width - smallBtnW * 1.5 - rowGap, topColGap + 2*(colGap + btnH), smallBtnW * 1.5, btnH);
    
    
    CGFloat margin3 = (self.frame.size.width - 6*rowGap - 7*smallBtnW )/2;//7个按钮的宽度
    for (int i = 28; i<35; i++) {
        QDKeyboardBtn *btn = self.btnArray[i];
        btn.frame = CGRectMake(margin3 + (i-28)*(smallBtnW + rowGap), topColGap + 3*(colGap + btnH), smallBtnW, btnH);
    }
    
    self.numBtn.frame = CGRectMake(rowGap, topColGap + 3*(colGap + btnH), smallBtnW * 1.5, btnH);
    self.wordButton.frame = CGRectMake(self.frame.size.width - smallBtnW * 1.5 - rowGap, topColGap + 3*(colGap + btnH), smallBtnW * 1.5, btnH);
    
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


- (void)switchBtnClick:(UIButton *)btn {
    
    if ([self.delegate respondsToSelector:@selector(KeyboardSymbolPadDidClickSwitchBtn:)]) {
        [self.delegate KeyboardSymbolPadDidClickSwitchBtn:btn];
    }
}

#pragma mark - QDKeyboardBtnDelegate
- (void)KeyboardBtnDidClick:(QDKeyboardBtn *)btn {
    
//    self.responder.text = [self.responder.text stringByAppendingString:btn.titleLabel.text];
    if ([self.delegate respondsToSelector:@selector(inputButtonAction:)]) {
        [self.delegate inputButtonAction:btn];
    }
    
}


#pragma mark - lazy

- (UITextField *)responder {
    if (!_responder) {  // 防止多个输入框采用同一个inputview
        UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
        UIView *firstResponder = [keyWindow valueForKey:@"firstResponder"];
        _responder = (UITextField *)firstResponder;
    }
    return _responder;
}


-(NSMutableArray *)symbolArray{
    
    if (_symbolArray == nil) {
        
        NSString* plistPath = [[NSBundle mainBundle] pathForResource:@"symbol" ofType:@"plist"];
       NSArray *sybolArray = [NSArray arrayWithContentsOfFile:plistPath];
        _symbolArray = sybolArray.mutableCopy;
    }
    return _symbolArray;
}



-(UIButton *)deleteBtn{
    
    if (_deleteBtn == nil) {
        
        UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [deleteBtn setBackgroundImage:[UIImage imageNamed:@"keypadDeleteBtn2"] forState:UIControlStateNormal];
        [deleteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc]
                                                                    initWithTarget:self
                                                                    action:@selector(longPressGestureRecognizerAction:)];
        longPressGestureRecognizer.cancelsTouchesInView = NO;
        [deleteBtn addGestureRecognizer:longPressGestureRecognizer];
        deleteBtn.layer.cornerRadius = 5.0;
        deleteBtn.layer.masksToBounds = YES;
        _deleteBtn = deleteBtn;
    }
    return _deleteBtn;
}

-(UIButton *)numBtn{
    
    if (_numBtn == nil) {
        
        UIButton *numPadCheckBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [numPadCheckBtn setTitle:@"123" forState:UIControlStateNormal];
        [numPadCheckBtn setBackgroundImage:[UIImage imageWithColor:darkNormal] forState:UIControlStateNormal];
        [numPadCheckBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        numPadCheckBtn.titleLabel.font = [UIFont boldSystemFontOfSize:19];
        [numPadCheckBtn addTarget:self action:@selector(switchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        numPadCheckBtn.tag = numBtnTag;
        numPadCheckBtn.layer.cornerRadius = 5.0;
        numPadCheckBtn.layer.masksToBounds = YES;
        _numBtn = numPadCheckBtn;
    }
    return _numBtn;
}

-(UIButton *)wordButton{
    
    if (_wordButton == nil) {
        
        UIButton *wordButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [wordButton setTitle:@"abc" forState:UIControlStateNormal];
        [wordButton setBackgroundImage:[UIImage imageWithColor:darkNormal] forState:UIControlStateNormal];
        [wordButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        wordButton.titleLabel.font = [UIFont boldSystemFontOfSize:19];
        [wordButton addTarget:self action:@selector(switchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        wordButton.tag = wordBtnTag;
        wordButton.layer.cornerRadius = 5.0;
        wordButton.layer.masksToBounds = YES;
        _wordButton = wordButton;
    }
    return _wordButton;
}

@end
