//
//  MBProgressHUD+MeHUD.m
//  YiBang
//
//  Created by 天蓝 on 16/5/18.
//  Copyright © 2016年 Qzy. All rights reserved.
//

#import "MBProgressHUD+MeHUD.h"

@implementation MBProgressHUD (MeHUD)

+ (MBProgressHUD *)show
{
    [MBProgressHUD dismiss];
    UIWindow * mainWindow = [(NSObject *)[UIApplication sharedApplication].delegate valueForKey:@"window"];
    return [MBProgressHUD showHUDAddedTo:mainWindow animated:YES];
}

+ (void)dismiss
{
    UIWindow * mainWindow = [(NSObject *)[UIApplication sharedApplication].delegate valueForKey:@"window"];
    [MBProgressHUD hideHUDForView:mainWindow animated:YES];
}
@end
