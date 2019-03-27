//
//  HomeViewController.m
//  yuyan
//
//  Created by tangfeimu on 2019/3/27.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationTitle:@"首页" LeftBtnHidden:YES RightBtnHidden:YES];
    
    
}

- (void)leftBtnAcion:(id)sender{
    NSLog(@"------");
}


@end
