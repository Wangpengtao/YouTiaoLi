//
//  YTLBaseViewController.m
//  YouTiaoLi
//
//  Created by 天蓝 on 2017/8/1.
//  Copyright © 2017年 PT. All rights reserved.
//

#import "YTLBaseViewController.h"

@interface YTLBaseViewController ()

@end

@implementation YTLBaseViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSLog(@"**********  %@  **********",NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = kBackgroundColor;
}


@end
