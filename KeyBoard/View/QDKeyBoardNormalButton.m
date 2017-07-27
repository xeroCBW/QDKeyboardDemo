//
//  QDKeyBoardNormalButton.m
//  QDKeyboard
//
//  Created by chenbowen on 2017/7/25.
//  Copyright © 2017年 chenbowen. All rights reserved.
//

#import "QDKeyBoardNormalButton.h"
#import "UIImage+ImageWithColor.h"


@implementation QDKeyBoardNormalButton


+ (QDKeyBoardNormalButton *)buttonWithTitle:(NSString *)title tag:(NSInteger)tag delegate:(id)delegate
{
    QDKeyBoardNormalButton *btn = [QDKeyBoardNormalButton buttonWithType:UIButtonTypeCustom];
    btn.tag = tag;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:btn action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:18];
    
    [btn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
//    [btn setBackgroundImage:[UIImage imageWithColor:colorHighLight] forState:UIControlStateHighlighted];
//    btn.layer.cornerRadius = 5;
//    btn.layer.masksToBounds = YES;
    btn.delegate = delegate;
    
    return btn;
}


- (void)btnClick:(QDKeyBoardNormalButton *)btn {
    
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
