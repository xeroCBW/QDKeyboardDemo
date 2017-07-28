//
//  NSArray+Shuffle.h
//  QDKeyboardDemo
//
//  Created by chenbowen on 2017/7/28.
//  Copyright © 2017年 chenbowen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Shuffle)

/** 随机之后的数组*/
@property (nonatomic ,strong,readonly) NSArray *shuffled;

@end
