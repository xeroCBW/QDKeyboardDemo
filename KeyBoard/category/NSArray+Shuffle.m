//
//  NSArray+Shuffle.m
//  QDKeyboardDemo
//
//  Created by chenbowen on 2017/7/28.
//  Copyright © 2017年 chenbowen. All rights reserved.
//

#import "NSArray+Shuffle.h"

@implementation NSArray (Shuffle)


-(NSArray *)shuffled{
    
    NSMutableArray * shuffledArray = self.mutableCopy;
    
    if (shuffledArray.count > 1) {
        
        for (NSUInteger i = 0; i < [shuffledArray count]; ++i) {
            // Select a random element between i and end of array to swap with.
            long nElements = [shuffledArray count] - i;
            long n = (random() % nElements) + i;
            [shuffledArray exchangeObjectAtIndex:i withObjectAtIndex:n];
        }
    }
    return shuffledArray;
}


@end
