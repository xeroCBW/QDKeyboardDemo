//
//  QDKeyboardNumPad.h
//  QDKeyboard
//
//  Created by chenbowen on 17/7/24.
//  Copyright © 2017年 chenbowen. All rights reserved.
//

#import "QDKeyBoardBasePad.h"
#import "QDKeyBoardNormalButton.h"
#import "QHKeyBoradDefine.h"

@protocol QDKeyboardNumPadDelegate  <NSObject,QDKeyBoardBasePadDelegate>

@required

- (void)KeyboardNumPadDidClickSwitchBtn:(UIButton *)btn;

@end

@interface QDKeyboardNumPad : QDKeyBoardBasePad <QDKeyBoardNormalButtonDelegate>

@property (nonatomic, weak) id <QDKeyboardNumPadDelegate> delegate;

@property (nonatomic, readonly,assign) QDKeyboardStyle style;

- (instancetype)initWithFrame:(CGRect )frame Style:(QDKeyboardStyle )style;

@end
