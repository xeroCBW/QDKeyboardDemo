//
//  QDKeyboardSymbolPad.h
//  QDKeyboard
//
//  Created by chenbowen on 2017/7/25.
//  Copyright © 2017年 chenbowen. All rights reserved.
//

#import "QDKeyBoardBasePad.h"
#import "QDKeyboardBtn.h"
#import "QHKeyBoradDefine.h"

#define wordBtnTag 100
#define numBtnTag 200

@protocol QDKeyboardSymbolPadDelegate <NSObject,QDKeyBoardBasePadDelegate>

@required

- (void)KeyboardSymbolPadDidClickSwitchBtn:(UIButton *)btn;

@end

@interface QDKeyboardSymbolPad : QDKeyBoardBasePad<QDKeyboardBtnDelegate>

@property (nonatomic, weak) id <QDKeyboardSymbolPadDelegate> delegate;

@end
