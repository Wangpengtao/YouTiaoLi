//
//  UIImage+ImageForColor.h
//  LinkspotOrder
//
//  Created by QzydeMac on 15/3/14.
//  Copyright (c) 2015年 Shanghai LinkSpot Intelligent Technology Company Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ImageForColor)
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageSize:(CGSize)size WithCornerRadius:(CGFloat)cornerRadius fillColor:(UIColor *)color;
+ (UIImage *)imageSize:(CGSize)size WithCornerRadius:(CGFloat)cornerRadius stokeColor:(UIColor *)color stokeWith:(CGFloat)width;
+ (UIImage *)imageWithContainFileName:(NSString *)imageName;

+ (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize image:(UIImage *)image;
+ (UIImage*)imageByScalingForSize:(CGSize)targetSize image:(UIImage *)image;
// 修正图片方向
+ (UIImage *)fixOrientation:(UIImage *)image;
@end
