//
//  YTLBaseListViewController.h
//  YouTiaoLi
//
//  Created by 天蓝 on 2017/8/1.
//  Copyright © 2017年 PT. All rights reserved.
//

#import <UIKit/UIKit.h>

// 空视图类型
typedef NS_ENUM(NSInteger, NullViewType) {
    
    // 默认
    NullViewTypeDefault = 0,
};


@interface YTLBaseListViewController : YTLBaseViewController

@property (nonatomic,strong) UITableView * tableView;
// 空视图的类型
@property (nonatomic, assign) NullViewType nullViewType;
// 空视图向上偏移量
@property (nonatomic, assign) CGFloat nullViewOffset;


- (void)loadEmptyTableView;

@end
