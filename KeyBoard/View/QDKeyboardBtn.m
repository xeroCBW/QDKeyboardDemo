//
//  QDKeyboardBtn.m
//  QDKeyboard
//
//  Created by chenbowen on 17/7/24.
//  Copyright © 2017年 chenbowen. All rights reserved.
//

#import "QDKeyboardBtn.h"
#import "UIImage+ImageWithColor.h"
#define colorHighLight [UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:0.9]


@implementation QDKeyboardBtn

+ (QDKeyboardBtn *)buttonWithTitle:(NSString *)title tag:(NSInteger)tag delegate:(id)delegate
{
    QDKeyboardBtn *btn = [QDKeyboardBtn buttonWithType:UIButtonTypeCustom];
    btn.tag = tag;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:btn action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:21];
//    [btn setBackgroundImage:[UIImage imageNamed:@"images.bundle/keypadBtn"] forState:UIControlStateNormal];
//    [btn setBackgroundImage:[UIImage imageNamed:@"images.bundle/keypadBtnHighLighted"] forState:UIControlStateHighlighted];
    [btn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageWithColor:colorHighLight] forState:UIControlStateHighlighted];
    

    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    btn.delegate = delegate;
    
    return btn;
}


//设置按钮的input
-(void)setTitle:(NSString *)title forState:(UIControlState)state{
    
    [super setTitle:title forState:state];
    
    self.input = title;
}

- (void)btnClick:(QDKeyboardBtn *)btn {
    
    if ([self.delegate respondsToSelector:@selector(KeyboardBtnDidClick:)]) {
        [self.delegate KeyboardBtnDidClick:btn];
    }
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    self.titleLabel.frame = self.bounds;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

@end
