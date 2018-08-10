//
//  ViewController.m
//  DKHUD
//
//  Created by easy on 2018/7/25.
//  Copyright © 2018年 简单互娱. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+HUD.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)buttonClicked:(UIButton *)sender {
    
    [self showMessage:@"动物园里有小猴几🐒、大脑斧🐯还有小西几🦁️小脑许🐭"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
