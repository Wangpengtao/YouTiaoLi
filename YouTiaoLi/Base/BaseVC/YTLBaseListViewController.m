//
//  YTLBaseListViewController.m
//  YouTiaoLi
//
//  Created by 天蓝 on 2017/8/1.
//  Copyright © 2017年 PT. All rights reserved.
//

#import "YTLBaseListViewController.h"
#import "UIScrollView+EmptyDataSet.h"

@interface YTLBaseListViewController ()<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@end

@implementation YTLBaseListViewController

- (void)loadEmptyTableView
{
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    switch (self.nullViewType) {
        case NullViewTypeDefault:
            
            break;
    }
    NSMutableAttributedString * att = [[NSMutableAttributedString alloc]initWithString:@"" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor grayColor]}];
    return att;
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *str;
    switch (self.nullViewType) {
        case NullViewTypeDefault:
            str = @"telephone";
            break;
    }
    return [UIImage imageNamed:str];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *str;
    switch (self.nullViewType) {
        case NullViewTypeDefault:
            str = @"暂无数据源";
            break;
    }
    NSMutableAttributedString * att = [[NSMutableAttributedString alloc]initWithString:str attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor grayColor]}];
    return att;
}

// 中心点向上偏移的距离
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{

    return -80;
}

// 图片与文字的距离
- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView
{
    return 20;
}

// 为空是否能够滚动
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}

@end
