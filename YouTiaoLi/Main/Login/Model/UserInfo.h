//
//  UserInfo.h
//  PGJOA
//
//  Created by QzydeMac on 16/9/12.
//  Copyright © 2016年 Qzy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject
@property (nonatomic, copy  ) NSString     *userId;

+ (instancetype)shareUserInfo;

+ (void)resetInfo;

@end
