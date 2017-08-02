//
//  YTLMeCenterView.m
//  YouTiaoLi
//
//  Created by 天蓝 on 2017/8/2.
//  Copyright © 2017年 PT. All rights reserved.
//  个人中心侧滑视图

#import "YTLMeCenterView.h"

static YTLMeCenterView *_leftCenterView_only = nil;

@interface YTLMeCenterView ()
@property (nonatomic, strong) UIView *showBackView;
@end

@implementation YTLMeCenterView

#pragma mark ++++++

+ (void)show
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    if (_leftCenterView_only)
    {
        [[[UIApplication sharedApplication] keyWindow] addSubview:_leftCenterView_only];
        [UIView animateWithDuration:0.3 animations:^{
            _leftCenterView_only.alpha = 1;
            _leftCenterView_only.showBackView.transform = CGAffineTransformTranslate(_leftCenterView_only.showBackView.transform, _leftCenterView_only.showBackView.width, 0);
        }];
    }else{
        _leftCenterView_only = [[YTLMeCenterView alloc] initWithFrame:[UIScreen mainScreen].bounds];

        [self show];
    }
}

+ (void)dismiss
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [UIView animateWithDuration:0.3 animations:^{
        _leftCenterView_only.alpha = 0;
        _leftCenterView_only.showBackView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [_leftCenterView_only removeFromSuperview];
    }];
}

+ (void)reset
{
    _leftCenterView_only = nil;
}


#pragma mark ------

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
        
        UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:[self class] action:@selector(dismiss)];
        swipeRight.direction = UISwipeGestureRecognizerDirectionLeft;
        [self addGestureRecognizer:swipeRight];
        
        [self createShowCenterView];
    }
    return self;
}

- (void)createShowCenterView
{
    _showBackView = [[UIView alloc] initWithFrame:CGRectMake(-0.618*kScreenWidth, 0, 0.618*kScreenWidth, kScreenHeight)];
    _showBackView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_showBackView];
    
    
    UIImageView *heardImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    heardImgView.image = [UIImage imageNamed:@"add"];
    heardImgView.layer.masksToBounds = YES;
    heardImgView.layer.cornerRadius = heardImgView.width/2.0;
    heardImgView.center = CGPointMake(_showBackView.width/2.0, 0.18*kScreenHeight);
    [_showBackView addSubview:heardImgView];
    
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, heardImgView.maxY + 10, _showBackView.width, 60)];
    nameLabel.centerX = heardImgView.centerX;
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.numberOfLines = 0;
    nameLabel.font = [UIFont systemFontOfSize:15];
    nameLabel.textColor = [UIColor colorWithRed:0.20f green:0.20f blue:0.20f alpha:1.00f];
    [_showBackView addSubview:nameLabel];
    nameLabel.text = @"洛水天一\n15812345678";
    
    
    CGFloat originY = nameLabel.maxY + 10;
    NSArray *titleArray = @[@"个人信息",@"统计数据",@"账户信息",@"团队管理",@"意见反馈",@"分享有礼"];
    NSArray *imageArray = @[@"add",@"add",@"add",@"add",@"add",@"add"];
    
    for (int i = 0; i < titleArray.count; i++)
    {
        UIView *rowView = [[UIView alloc] initWithFrame:CGRectMake(0, originY, _showBackView.width, 44)];
        rowView.tag = i;
        [rowView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)]];
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, rowView.height, rowView.height)];
        imgView.image = [UIImage imageNamed:imageArray[i]];
        imgView.contentMode = UIViewContentModeCenter;
        imgView.center = CGPointMake(0.3 * rowView.width, rowView.height/2.0);
        [rowView addSubview:imgView];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(imgView.maxX, 0, 100, rowView.height)];
        titleLabel.text = titleArray[i];
        titleLabel.font = [UIFont systemFontOfSize:15];
        titleLabel.textColor = [UIColor colorWithRed:0.20f green:0.20f blue:0.20f alpha:1.00f];
        [rowView addSubview:titleLabel];
        
        [_showBackView addSubview:rowView];
        originY = rowView.maxY;
    }
}

- (void)tapAction:(UIGestureRecognizer *)ges
{
    [[self class] dismiss];
    
    NSString *vcStr = nil;
    switch (ges.view.tag) {
        case 0:
            vcStr = @"YTLChatVC";
            break;
        case 1:
            vcStr = @"YTLChatVC";
            break;
        case 2:
            vcStr = @"YTLChatVC";
            break;
        case 3:
            vcStr = @"YTLChatVC";
            break;
        case 4:
            vcStr = @"YTLChatVC";
            break;
        case 5:
            vcStr = @"YTLChatVC";
            break;
    }
    
    if (vcStr) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            UIViewController *vc = [[NSClassFromString(vcStr) alloc] init];
            UITabBarController *rootVC = (UITabBarController *)[[[UIApplication sharedApplication] keyWindow] rootViewController];
            UINavigationController *nav = rootVC.viewControllers[rootVC.selectedIndex];
            [nav pushViewController:vc animated:YES];
        });
    }
}

@end
