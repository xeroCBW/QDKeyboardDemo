//
//  QDKeyBoardNormalButton.h
//  QDKeyboard
//
//  Created by chenbowen on 2017/7/25.
//  Copyright © 2017年 chenbowen. All rights reserved.
//

#import <UIKit/UIKit.h>

#define margin 5

@class QDKeyBoardNormalButton;

@protocol QDKeyBoardNormalButtonDelegate <NSObject>

@required
- (void)KeyboardBtnDidClick:(QDKeyBoardNormalButton *)btn;
@end


@interface QDKeyBoardNormalButton : UIButton

+ (QDKeyBoardNormalButton *)buttonWithTitle:(NSString *)title tag:(NSInteger)tag  delegate:(id)delegate;

@property (nonatomic, assign) id <QDKeyBoardNormalButtonDelegate> delegate;

@end
