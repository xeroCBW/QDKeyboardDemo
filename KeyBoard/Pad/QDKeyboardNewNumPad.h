//
//  QDKeyboardNewNumPad.h
//  QDKeyboard
//
//  Created by chenbowen on 2017/7/24.
//  Copyright © 2017年 chenbowen. All rights reserved.
//


#import "QDKeyBoardBasePad.h"

#import "QHKeyBoradDefine.h"
#import "QDKeyboardNumPad.h"

@interface QDKeyboardNewNumPad :QDKeyBoardBasePad

@property (nonatomic, weak) id <QDKeyboardNumPadDelegate> delegate;

@property (nonatomic, readonly,assign) QDKeyboardStyle style;

- (instancetype)initWithFrame:(CGRect )frame Style:(QDKeyboardStyle )style;

@end
