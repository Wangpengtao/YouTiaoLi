//
//  NSObject+ZYArchiveManager.m
//  PocketMoney
//
//  Created by QzydeMac on 15/6/15.
//  Copyright (c) 2015年 China Continent Property & Casualty Insurance Company. All rights reserved.
//

#import "NSObject+ZYArchiveManager.h"
#import <objc/runtime.h>
@implementation NSObject (ZYArchiveManager)

-(void)encodeWithCoder:(NSCoder *)encoder
{
    unsigned int count = 0;
    Ivar * ivars = class_copyIvarList([self class], &count);
    
    for (int i = 0; i<count; i++) {
        
        // 取出i位置对应的成员变量
        Ivar ivar = ivars[i];
        
        // 查看成员变量
        const char *name = ivar_getName(ivar);

        // 归档
        NSString *key = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:key];
        [encoder encodeObject:value forKey:key];
    }
    
    free(ivars);
}

-(id)initWithCoder:(NSCoder *)decoder
{
    if (self = [self init]) {
        
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList([self class], &count);
        
        for (int i = 0; i<count; i++) {
            // 取出i位置对应的成员变量
            Ivar ivar = ivars[i];
            
            // 查看成员变量
            const char *name = ivar_getName(ivar);
            
            // 解归档
            NSString *key = [NSString stringWithUTF8String:name];
            id value = [decoder decodeObjectForKey:key];
            // 设置到成员变量身上
            if (key && value ) {
                [self setValue:value forKey:key];
            }
        }
        
        free(ivars);
    }
    return self;
}
@end