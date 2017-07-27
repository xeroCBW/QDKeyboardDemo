//
//  QDKeyboardWordPad.h
//  QDKeyboard
//
//  Created by chenbowen on 17/7/24.
//  Copyright © 2017年 chenbowen. All rights reserved.
//

#import "QDKeyBoardBasePad.h"
#import "QDKeyboardBtn.h"

@protocol QDKeyboardWordPadDelegate <NSObject,QDKeyBoardBasePadDelegate>

@required

- (void)KeyboardWordPadDidClickSwitchBtn:(UIButton *)btn;

@end

@interface QDKeyboardWordPad : QDKeyBoardBasePad <QDKeyboardBtnDelegate>

@property (nonatomic, weak) id <QDKeyboardWordPadDelegate> delegate;

@end

