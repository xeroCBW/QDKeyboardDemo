//
//  ViewController.m
//  QDKeyboardDemo
//
//  Created by chenbowen on 2017/7/27.
//  Copyright © 2017年 chenbowen. All rights reserved.
//

#import "ViewController.h"

#import "ViewController.h"
#import "TestViewController.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextButtob;

@end

@implementation ViewController


-(void)viewDidLoad{
    
    
    [super viewDidLoad];
}


- (IBAction)nextButtonAction:(id)sender {
    
    TestViewController *test = [[TestViewController alloc]init];
    [self.navigationController pushViewController:test animated:YES];
}


@end
