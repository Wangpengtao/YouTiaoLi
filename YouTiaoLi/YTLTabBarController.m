//
//  YTLTabBarController.m
//  YouTiaoLi
//
//  Created by 天蓝 on 2017/8/2.
//  Copyright © 2017年 PT. All rights reserved.
//

#import "YTLTabBarController.h"
#import "YTLMeCenterView.h"

@interface YTLTabBarController ()

@end

@implementation YTLTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *vcNameArray = @[@"YTLChatVC",@"YTLTaskVC",@"YTLProjectVC",@"YTLMemoVC"];
    NSArray *nImageArray = @[@"add",@"add",@"add",@"add"];
    NSArray *sImageArray = @[@"add",@"add",@"add",@"add"];
    NSArray *titleArray = @[@"消息",@"任务",@"项目",@"备忘录"];
    
    for (int i = 0; i < vcNameArray.count; i++)
    {
        UIViewController *vc = [[NSClassFromString(vcNameArray[i]) alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:titleArray[i]
                                                      image:[[UIImage imageNamed:nImageArray[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                              selectedImage:[[UIImage imageNamed:sImageArray[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        nav.navigationBar.translucent = NO;
        [nav.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -3)];
        [self addChildViewController:nav];
    }
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0.05f green:0.70f blue:1.00f alpha:1.00f]} forState:UIControlStateSelected];
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:14]}
                                                forState:UIControlStateNormal];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:16]}];
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage new] forBarMetrics:0];
    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0.01f green:0.57f blue:1.00f alpha:1.00f]];
    
    // 设置导航条的颜色为白色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    // 添加右滑手势
    [self addRightSwipeAction];
}

#pragma mark - 添加右滑手势

- (void)addRightSwipeAction
{
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRightAction:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRight];
}

- (void)swipeRightAction:(UISwipeGestureRecognizer *)swipe
{
    [YTLMeCenterView show];
}

@end
