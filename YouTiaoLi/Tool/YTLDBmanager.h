//
//  YTLDBmanager.h
//  YouTiaoLi
//
//  Created by 天蓝 on 2017/8/1.
//  Copyright © 2017年 PT. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, SaveDataType) {
    
    // 任务
    SaveDataTypeTask = 1
};

@interface YTLDBmanager : NSObject

/**
 *  保存列表数据
 */
+ (void)saveListModels:(NSMutableArray *)modes type:(SaveDataType)type;

/**
 *  获取列表数据
 */
+ (NSMutableArray *)getListModelsWithType:(SaveDataType)type;

@end
