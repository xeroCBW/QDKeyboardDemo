//
//  QDKeyboardBtn.h
//  QDKeyboard
//
//  Created by chenbowen on 17/7/24.
//  Copyright © 2017年 chenbowen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYRKeyboardButton.h"

#define margin 5

@class QDKeyboardBtn;
@protocol QDKeyboardBtnDelegate <NSObject>

@required
- (void)KeyboardBtnDidClick:(QDKeyboardBtn *)btn;

@end

@interface QDKeyboardBtn : CYRKeyboardButton

+ (QDKeyboardBtn *)buttonWithTitle:(NSString *)title tag:(NSInteger)tag  delegate:(id)delegate;

@property (nonatomic, assign) id <QDKeyboardBtnDelegate> delegate;

@end
