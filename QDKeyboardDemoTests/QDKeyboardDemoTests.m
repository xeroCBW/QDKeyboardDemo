//
//  QDKeyboardDemoTests.m
//  QDKeyboardDemoTests
//
//  Created by chenbowen on 2017/7/28.
//  Copyright © 2017年 chenbowen. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "QDKeyboard.h"
#import "QDKeyboardNumPad.h"
#import "QDKeyboardNewNumPad.h"
#import "QDKeyboardSymbolPad.h"
#import "QDKeyboardWordPad.h"
#import "NSArray+Shuffle.h"

@interface QDKeyboardDemoTests : XCTestCase

@end

@implementation QDKeyboardDemoTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)test00Shuffle {
    
    NSString* plistPath = [[NSBundle mainBundle] pathForResource:@"word" ofType:@"plist"];
    NSArray *wordArray = [NSArray arrayWithContentsOfFile:plistPath];
    
    XCTAssertTrue(wordArray.shuffled.count == wordArray.shuffled.count);
    
    NSArray *shuffledArray = wordArray.shuffled;
    XCTAssertFalse([shuffledArray isEqualToArray:wordArray]);

}


- (void)test01Init {
    
    QDKeyboard *board = [[QDKeyboard alloc]initWithStyle:QDKeyboardStyleDefault];
    XCTAssertTrue(board.style == QDKeyboardStyleDefault);
    
    QDKeyboard *board2 = [[QDKeyboard alloc]initWithStyle:QDKeyboardStyleNumberPad];
    XCTAssertTrue(board2.style == QDKeyboardStyleNumberPad);
    
}


- (void)test02NumberBoard {

    CGRect frame = CGRectMake(20, 20, 200, 200);
    QDKeyboardNewNumPad *newNumPad = [[QDKeyboardNewNumPad alloc]initWithFrame:frame Style:QDKeyboardStyleDefault];
    XCTAssertTrue(newNumPad.style == QDKeyboardStyleDefault);
    
    QDKeyboardNewNumPad *newNumPad2 = [[QDKeyboardNewNumPad alloc]initWithFrame:frame Style:QDKeyboardStyleNumberPad];
    XCTAssertTrue(newNumPad2.style == QDKeyboardStyleNumberPad);
    
}

- (void)test03NumberBoard {
    
    
    CGRect frame = CGRectMake(20, 20, 200, 200);
    QDKeyboardNumPad *newNumPad = [[QDKeyboardNumPad alloc]initWithFrame:frame Style:QDKeyboardStyleDefault];
    XCTAssertTrue(newNumPad.style == QDKeyboardStyleDefault);
    
    QDKeyboardNumPad *newNumPad2 = [[QDKeyboardNumPad alloc]initWithFrame:frame Style:QDKeyboardStyleNumberPad];
    XCTAssertTrue(newNumPad2.style == QDKeyboardStyleNumberPad);

}

- (void)test04WordBoard {
    
    

    
}


- (void)test05SymbolBoard {
    
    

    
}







- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
