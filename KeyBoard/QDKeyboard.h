//
//  QDKeyboard.h
//  QDKeyboard
//
//  Created by chenbowen on 17/7/24.
//  Copyright © 2017年 chenbowen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QHKeyBoradDefine.h"


@interface QDKeyboard : UIView

@property (nonatomic, readonly,assign) QDKeyboardStyle style;

- (instancetype)initWithStyle:(QDKeyboardStyle )style;

@end
