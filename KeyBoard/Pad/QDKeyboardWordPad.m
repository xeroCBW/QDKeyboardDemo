
//
//  QDKeyboardWordPad.m
//  QDKeyboard
//
//  Created by chenbowen on 17/7/24.
//  Copyright © 2017年 chenbowen. All rights reserved.
//

#import "QDKeyboardWordPad.h"
#import "QDKeyboardBtn.h"
#import "UIImage+ImageWithColor.h"
#import "QHKeyBoradDefine.h"


#define darkNormal [UIColor colorWithRed:171.0/255.0 green:178.0/255.0 blue:191.0/255.0 alpha:1.0]
#define colGap 12 //行间距 12
#define topColGap colGap
#define bottomColGap 0.4*colGap
#define rowGap 5 //列间距 5

@interface QDKeyboardWordPad ()

@property (nonatomic, weak) UITextField *responder;

@property (nonatomic, strong) NSMutableArray *btnArray;
@property (nonatomic, strong) NSMutableArray <NSString *>*wordArray;
@property (nonatomic, strong) UIButton *trasitionWordBtn;
@property (nonatomic, strong) UIButton *deleteBtn;
@property (nonatomic, strong) UIButton *numPadCheckBtn;
@property (nonatomic, strong) UIButton *okBtn;
@property (nonatomic, strong) UIButton *spaceBtn;

@end

@implementation QDKeyboardWordPad


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
    for (int i = 0; i< 26; i++) {// 添加26个英文字母
        QDKeyboardBtn *btn = [QDKeyboardBtn buttonWithTitle:self.wordArray[i] tag:i delegate:self];
        
        [btn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:11/255.0 green:98/255.0 blue:224/255.0 alpha:1]] forState:UIControlStateHighlighted];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
        [btnArray addObject:btn];
        [self addSubview:btn];
    }
    self.btnArray = btnArray;
    // 大小写装换
   
    [self addSubview:self.trasitionWordBtn];
    [self addSubview:self.deleteBtn];
    [self addSubview:self.numPadCheckBtn];
    [self addSubview:self.okBtn];
    [self addSubview:self.spaceBtn];


    
    self.okBtn.layer.cornerRadius = 5.0;
    self.okBtn.layer.masksToBounds = YES;
    
    self.numPadCheckBtn.layer.cornerRadius = 5.0;
    self.numPadCheckBtn.layer.masksToBounds = YES;
    
    self.deleteBtn.layer.cornerRadius = 5.0;
    self.deleteBtn.layer.masksToBounds = YES;
    
    self.trasitionWordBtn.layer.cornerRadius = 5.0;
    self.trasitionWordBtn.layer.masksToBounds = YES;
}

- (void)trasitionWord:(UIButton *)trasitionWordBtn {
    
    trasitionWordBtn.selected = !trasitionWordBtn.selected;
    if (trasitionWordBtn.selected) {
        for (int i = 0; i<26; i++) {
            QDKeyboardBtn *btn = self.btnArray[i];
            [btn setTitle:self.wordArray[i].uppercaseString forState:UIControlStateNormal];
        }
    } else {
        for (int i = 0; i<26; i++) {
            QDKeyboardBtn *btn = self.btnArray[i];
            [btn setTitle:self.wordArray[i].lowercaseString forState:UIControlStateNormal];
        }
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



- (void)switchBtnClick:(UIButton *)btn {
    
    if ([self.delegate respondsToSelector:@selector(KeyboardWordPadDidClickSwitchBtn:)]) {
        [self.delegate KeyboardWordPadDidClickSwitchBtn:btn];
    }
}

- (void)spaceBtnClick {
    
    self.responder.text = [self.responder.text stringByAppendingString:@" "];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    CGFloat smallBtnW = (self.frame.size.width - 11*rowGap)/10;
    CGFloat btnH = (self.frame.size.height - 3*colGap - topColGap - bottomColGap)/4;
    
    for (int i = 0; i < 10; i++) {
        QDKeyboardBtn *btn = self.btnArray[i];
        btn.frame = CGRectMake(rowGap + i*(smallBtnW + rowGap), topColGap, smallBtnW, btnH);
    }
    
    CGFloat margin2 = (self.frame.size.width - 8*rowGap - 9*smallBtnW)/2;
    for (int i = 10; i < 19; i++) {
        QDKeyboardBtn *btn = self.btnArray[i];
        btn.frame = CGRectMake(margin2 + (i-10)*(smallBtnW + rowGap), topColGap +(colGap + btnH), smallBtnW, btnH);
    }
    
    CGFloat margin3 = (self.frame.size.width - 6*rowGap - 7*smallBtnW )/2;
    for (int i = 19; i<26; i++) {
        QDKeyboardBtn *btn = self.btnArray[i];
        btn.frame = CGRectMake(margin3 + (i-19)*(smallBtnW + rowGap), topColGap + 2*(colGap + btnH), smallBtnW, btnH);
    }
    
    self.trasitionWordBtn.frame = CGRectMake(rowGap, topColGap + 2*colGap + 2*btnH, smallBtnW, btnH);
    self.deleteBtn.frame = CGRectMake(self.frame.size.width - smallBtnW * 1.5 - rowGap, topColGap + 2*(colGap + btnH), smallBtnW * 1.5, btnH);
    
    CGFloat bigBtnW = (self.frame.size.width - 5*margin)/4;
    self.numPadCheckBtn.frame = CGRectMake(margin, topColGap + 3*(colGap + btnH), bigBtnW, btnH);
    self.spaceBtn.frame = CGRectMake(2*margin+bigBtnW, topColGap + 3*(colGap + btnH), bigBtnW * 2 + margin, btnH);
    self.okBtn.frame = CGRectMake(4*margin + 3*bigBtnW, topColGap + 3*(colGap + btnH), bigBtnW, btnH);
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
    //    if (!_responder) {  // 防止多个输入框采用同一个inputview
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    UIView *firstResponder = [keyWindow valueForKey:@"firstResponder"];
    _responder = (UITextField *)firstResponder;
    //    }
    return _responder;
}

- (NSMutableArray *)wordArray {
    
    if (!_wordArray) {
        
        NSString* plistPath = [[NSBundle mainBundle] pathForResource:@"word" ofType:@"plist"];
        NSArray *sybolArray = [NSArray arrayWithContentsOfFile:plistPath];
        _wordArray = sybolArray.mutableCopy;
        
    }
    return _wordArray;
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


-(UIButton *)numPadCheckBtn{
    
    if (_numPadCheckBtn == nil) {
        
        UIButton *numPadCheckBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [numPadCheckBtn setTitle:@"123" forState:UIControlStateNormal];
        //[numPadCheckBtn setBackgroundImage:[UIImage imageNamed:@"images.bundle/keypadLongBtn"] forState:UIControlStateNormal];
        [numPadCheckBtn setBackgroundImage:[UIImage imageWithColor:darkNormal] forState:UIControlStateNormal];
        [numPadCheckBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        numPadCheckBtn.titleLabel.font = [UIFont boldSystemFontOfSize:19];
        [numPadCheckBtn addTarget:self action:@selector(switchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        numPadCheckBtn.layer.cornerRadius = 5.0;
        numPadCheckBtn.layer.masksToBounds = YES;
        
        _numPadCheckBtn = numPadCheckBtn;
    }
    return _numPadCheckBtn;
}

-(UIButton *)okBtn{
    
    if (_okBtn == nil) {
        
        UIButton *okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [okBtn setTitle:@"#+=" forState:UIControlStateNormal];
        [okBtn setTitle:@"abc" forState:UIControlStateSelected];
        [okBtn setBackgroundImage:[UIImage imageWithColor:darkNormal] forState:UIControlStateNormal];
        [okBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [okBtn addTarget:self action:@selector(switchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        okBtn.layer.cornerRadius = 5.0;
        okBtn.layer.masksToBounds = YES;
        _okBtn = okBtn;
    }
    return _okBtn;
}


-(UIButton *)trasitionWordBtn{
    
    if (_trasitionWordBtn == nil) {
        
        UIButton *trasitionWordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [trasitionWordBtn setBackgroundImage:[UIImage imageNamed:@"trasition_normal"] forState:UIControlStateNormal];
        [trasitionWordBtn setBackgroundImage:[UIImage imageNamed:@"trasition_highlighted"] forState:UIControlStateSelected];
        [trasitionWordBtn addTarget:self action:@selector(trasitionWord:) forControlEvents:UIControlEventTouchUpInside];
        trasitionWordBtn.layer.cornerRadius = 5.0;
        trasitionWordBtn.layer.masksToBounds = YES;

        _trasitionWordBtn = trasitionWordBtn;
    }
    return _trasitionWordBtn;
}

-(UIButton *)spaceBtn{
    
    if (_spaceBtn == nil) {
        
        UIButton *spaceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [spaceBtn setTitle:spaceButtonTitle forState:UIControlStateNormal];
        [spaceBtn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [spaceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [spaceBtn addTarget:self action:@selector(spaceBtnClick) forControlEvents:UIControlEventTouchUpInside];
        spaceBtn.layer.cornerRadius = 5.0;
        spaceBtn.layer.masksToBounds = YES;
        _spaceBtn = spaceBtn;
    }
    return _spaceBtn;
}

#pragma mark - 随机产生26个字符串
- (NSString *)shuffledAlphabet {
    NSMutableArray * shuffledAlphabet = [NSMutableArray arrayWithArray:@[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"]];
    
//    for (NSUInteger i = 0; i < [shuffledAlphabet count]; ++i) {
//        // Select a random element between i and end of array to swap with.
//        long nElements = [shuffledAlphabet count] - i;
//        long n = (random() % nElements) + i;
//        [shuffledAlphabet exchangeObjectAtIndex:i withObjectAtIndex:n];
//    }
    
    NSString *string = [[NSString alloc] init];
    for (NSString *letter in shuffledAlphabet) {
        string = [NSString stringWithFormat:@"%@%@",string,letter];
    }
    
    return string;
}

- (NSArray *)toArray:(NSString *)string{
    
    NSMutableArray *array = [NSMutableArray array];

    for (int i = 0; i < [string length]; i++) {
        NSString *ch = [string substringWithRange:NSMakeRange(i, 1)];
        [array addObject:ch];
    }

    return array.mutableCopy;
}


@end

