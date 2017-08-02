//
//  UserInfo.m
//  PGJOA
//
//  Created by QzydeMac on 16/9/12.
//  Copyright © 2016年 Qzy. All rights reserved.
//

#import "UserInfo.h"


@implementation UserInfo
static UserInfo * instance = nil;
+ (instancetype)shareUserInfo
{
    if (!instance)
    {
        instance = [[UserInfo alloc]init];
    }
    return instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    if (!instance) {
        instance = [[super allocWithZone:zone]init];
    }
    return instance;
}

+ (id)copyWithZone:(struct _NSZone *)zone
{
    return instance;
}

+ (void)resetInfo
{
    instance = nil;
}


@end
