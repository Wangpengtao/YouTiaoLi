//
//  RegularVerifyModel.h
//  YiBang
//
//  Created by QzydeMac on 16/5/13.
//  Copyright © 2016年 Qzy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegularVerifyModel : NSObject
/**
 *  手机号码验证
 */
+(BOOL)isValidateMobile:(NSString *)mobile;

/**
 *  手机号/固定电话号码验证
 */
+(BOOL)isValidateFixedNumber:(NSString *)fixedNumber;

/**
 *  身份证号
 */
+ (BOOL) isValidateIdentityCard: (NSString *)identityCard;

/**
 *  密码格式验证
 */
+(BOOL)isValidatePassword:(NSString *)password;

/**
 *  验证登录用户名
 */
+ (BOOL)isValidateLoginUser:(NSString *)user;
/**
 *  验证修改用户名
 */
+(BOOL)isValidateUserName:(NSString *)userName;

/**
 *  验证码格式验证
 */
+(BOOL)isValidateCode:(NSString *)code;

#pragma mark 字符验证
/**
 *  判断空白字符
 */
+(BOOL)isNullString:(NSString *)str;

/**
 *  对比当前时间 date:(yyyy-MM-dd)
 *  返回yes 早于当前时间  否则晚于当前时间
 */
+ (BOOL)isValidateCurrentDate:(NSString *)date;

/**
 *  对比两个时间的先后 time:(yyyy-MM-dd)
 *  返回yes time1 >= time2(t2先发生, t1后发生)  否则返回no
 */
+ (BOOL)isMaxTime:(NSString *)time1 minTime:(NSString *)time2;

/**
 计算现在时间距离结束时间的间隔天数, 超过结束时间则返回0, 否则返回1,2,3..
 endTime  :  (yyyy-MM-dd)
 */
+ (NSInteger)nowDataToEndTime:(NSString *)endTime;


/**
 *  是否能下预约订单 date:(yyyy-MM-dd HH:mm:ss)
 *  预约订单要比当前时间晚8小时
 */
+ (BOOL)isValidateIsBespeakWithDate:(NSString *)date;

/**
 *  换算年龄   date 格式  (yyyy-MM-dd HH:mm:ss) 返回年龄
 */
+ (NSString *)isValidateAge:(NSString *)date;

/**
 获取今天多少号
 */
+ (NSString *)getDay;

/**
 获取今天是周几
 */
+ (NSString*)getWeek;

/**
 获取今天是本周的第几天(0...6[周日...周六])
 */
+ (NSInteger)getWeekThisDay;


/**
 获取当前周的日期(周日到周六的多少号[23,24...29])
 */
+ (NSMutableArray *)getCurrentWeekDay;

/**
 获取当前一周的时间, 带有年月日的数组
 */
+ (NSMutableArray *)getCurrentWeekYearMonthDay;

/**
 *  换算星座   date 格式  (yyyy-MM-dd HH:mm:ss) 返回星座
 */
+ (NSString *)isValidateConstellation:(NSString *)date;

/**
 *  转换金钱的格式 返回(67,789,786.00)
 */
+ (NSString *)changeMoneyStyleWithStr:(NSString *)newStr;

/**
 *  验证银行卡号
 */
+ (BOOL) isVerificationCardNo:(NSString*) cardNo;

+ (NSDate *)dateFromStr:(NSString *)str;

/**
 计算当前时间与结束时间的间隔
 
 @param endTime 结束时间
 @param type 1-倒计时  2-逾期
 @return    时间间隔
 */
+ (NSString *)timeIntervalWithEndTime:(NSString *)endTime type:(NSString **)type;


/**
 计算完成时间与结束时间的间隔
 
 @param finishTime 完成时间
 @param endTime 结束时间
 @param type 1-提前完成  2-逾期完成
 @return    时间间隔
 */
+ (NSString *)timeIntervalWithFinishTime:(NSString *)finishTime endTime:(NSString *)endTime type:(NSString **)type;

@end
