//
//  QDKeyBoardBasePad.h
//  QDKeyboard
//
//  Created by chenbowen on 2017/7/26.
//  Copyright © 2017年 chenbowen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QDKeyBoardBasePadDelegate <NSObject>

@required

- (void)inputButtonAction:(UIButton *)sender;

- (void)clearButtonAction:(UIButton *)sender;

@optional

- (void)longPressGestureRecognizerAction:(UILongPressGestureRecognizer *)gestureRecognizer;

@end

@interface QDKeyBoardBasePad : UIView

//@property (nonatomic, weak) id <QDKeyBoardBasePadDelegate> delegate;

@end
