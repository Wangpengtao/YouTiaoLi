//
//  YTLDBmanager.m
//  YouTiaoLi
//
//  Created by 天蓝 on 2017/8/1.
//  Copyright © 2017年 PT. All rights reserved.
//

#import "YTLDBmanager.h"


static YTLDBmanager * gSharedInstance = nil;
static FMDatabase * db = nil;
static FMDatabaseQueue * dbQuene = nil;

@implementation YTLDBmanager

+ (void)initialize
{
    /**
     *  加载数据库
     */
    [YTLDBmanager sharedYTLDBmanager];
}

+(YTLDBmanager *)sharedYTLDBmanager
{
    @synchronized(self)
    {
        if (gSharedInstance == nil)
            gSharedInstance = [[YTLDBmanager alloc] init];
    }
    return gSharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        NSUserDefaults * standardUserDefaults = [NSUserDefaults standardUserDefaults];
        NSString * lastVersion = [standardUserDefaults valueForKey:@"lastVersion"];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        // 存在上一个版本
        if (lastVersion && ![lastVersion isEqualToString:app_Version])
        {
            NSString *lastVersionPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@",@"YouTiaoLiApp.db",lastVersion]];
            NSError * error;
            BOOL success = [fileManager removeItemAtPath:lastVersionPath error:&error];
            NSLog(@"%zd",success);
        }
        
        [standardUserDefaults setValue:app_Version forKey:@"lastVersion"];
        NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@",app_Version,@"YouTiaoLiApp.db"]];
        dbQuene = [FMDatabaseQueue databaseQueueWithPath:path];
        
        db = [dbQuene valueForKey:@"_db"];
        if (![db open]) {
            NSLog(@"Could not open db.");
            return 0;
        }

        // 列表数据
        [db executeUpdate:@"CREATE TABLE IF NOT EXISTS SaveList (id integer PRIMARY KEY AUTOINCREMENT,key text NOT NULL,model blob NOT NULL)"];

    }
    return self;
}


#pragma mark - ----------------- 所有的列表缓存  --------------------------

/**
 *  保存列表数据
 */
+ (void)saveListModels:(NSMutableArray *)modes type:(SaveDataType)type
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [dbQuene inTransaction:^(FMDatabase *db, BOOL *rollback) {
            UserInfo *info = [UserInfo shareUserInfo];
            NSString *key = [NSString stringWithFormat:@"SaveList_%@_%zd",info.userId,type];
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:modes];
            [db executeUpdate:@"DELETE FROM SaveList WHERE key = ?",key];
            [db executeUpdate:@"INSERT INTO SaveList (key, model) VALUES (?, ?);",key,data];
        }];
    });
}


/**
 *  获取列表数据
 */
+ (NSMutableArray *)getListModelsWithType:(SaveDataType)type
{
    UserInfo *info = [UserInfo shareUserInfo];
    NSString *key = [NSString stringWithFormat:@"SaveList_%@_%zd",info.userId,type];
    FMResultSet *resultSet = [db executeQuery:@"SELECT * FROM SaveList WHERE key = ?",key];
    NSMutableArray *models;
    while (resultSet.next)
    {
        NSData *data = [resultSet objectForColumn:@"model"];
        models = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    return models;
}

@end
