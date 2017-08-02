//
//  RegularVerifyModel.m
//  YiBang
//
//  Created by QzydeMac on 16/5/13.
//  Copyright © 2016年 Qzy. All rights reserved.
//

#import "RegularVerifyModel.h"

@implementation RegularVerifyModel
// 手机号码验证
+(BOOL)isValidateMobile:(NSString *)mobile
{
    NSString *phoneRegex = @"^[1][3|4|5|7|8]{1}[0-9]{9}$";
    NSPredicate *phonePre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phonePre evaluateWithObject:mobile];
}

// 手机号/固定电话号码验证
+(BOOL)isValidateFixedNumber:(NSString *)fixedNumber
{
    if ([RegularVerifyModel isValidateMobile:fixedNumber]) {
        return YES;
    }
    NSString *phoneRegex = @"\\d{3}-\\d{8}|\\d{4}-\\d{7,8}";
    NSPredicate *phonePre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phonePre evaluateWithObject:fixedNumber];
}

/**
 *  身份证号
 */
+ (BOOL) isValidateIdentityCard: (NSString *)identityCard
{
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

//密码格式验证(字母数字下划线)
+(BOOL)isValidatePassword:(NSString *)password
{
    NSString *passwordRegex = @"^[_0-9a-zA-Z]{8,22}$";
    NSPredicate *pasPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passwordRegex];
    return [pasPre evaluateWithObject:password];
}

//验证码格式验证
+(BOOL)isValidateCode:(NSString *)code
{
    NSString *codeRegex = @"^[0-9a-bA-Z]{4}$";
    NSPredicate *codePre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",codeRegex];
    return [codePre evaluateWithObject:code];
}

// 验证登录用户名
+ (BOOL)isValidateLoginUser:(NSString *)user
{
    if (user.length > 20) {
        return NO;
    }
    NSString *codeRegex = @"^[A-Za-z0-9]+$";
    NSPredicate *codePre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",codeRegex];
    
    return [codePre evaluateWithObject:user];
}

//验证修改用户名
+(BOOL)isValidateUserName:(NSString *)userName
{
    if (userName.length > 20) {
        return NO;
    }
    NSString *codeRegex = @"^[A-Za-z0-9]{1,20}$";
    NSString *charRegex = @"^(?![^a-zA-Z]+$).{1,20}$";
    
    NSPredicate *codePre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",codeRegex];
    NSPredicate *charPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",charRegex];
    
    if (([codePre evaluateWithObject:userName] && [charPre evaluateWithObject:userName])) {
        return YES;
    }
    return NO;
}

#pragma mark 空白字符验证

+(BOOL)isNullString:(NSString *)str
{
    str = [str description];
    if (str == nil) {
        return YES;
    }else if ([str isKindOfClass:[NSNull class]]){
        return YES;
    }else if ([str isEqual:[NSNull null]]) {
        return YES;
    }else if (str.length == 0) {
        return YES;
    }else if ([str isEqualToString:@"null"]) {
        return YES;
    }else if ([str isEqualToString:@"<null>"]) {
        return YES;
    }
    NSString *strUrl = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    return [strUrl isEqualToString:@""];
}

/**
 *  换算年龄   date 格式  (yyyy-MM-dd HH:mm:ss) 返回年龄
 */
+ (NSString *)isValidateAge:(NSString *)date
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *today = [formatter stringFromDate:[NSDate date]];
    
    NSString *oldString = [date substringToIndex:4];
    NSString *newString = [today substringToIndex:4];
    
    NSString *returnString = [NSString stringWithFormat:@"%zd",[newString integerValue] - [oldString integerValue]];
    return returnString;
}

/**
 *  是否能下预约订单 date:(yyyy-MM-dd HH:mm:ss)
 *  预约订单要比当前时间晚8小时
 */
+ (BOOL)isValidateIsBespeakWithDate:(NSString *)date
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSTimeInterval currentInterval = [[NSDate date] timeIntervalSince1970] + 8 * 3600;
    NSTimeInterval dateInterval = [[formatter dateFromString:date] timeIntervalSince1970];

    BOOL compareResult;
    if (dateInterval > currentInterval) {
        compareResult = YES;
    }else
    {
        compareResult = NO;
    }
    return compareResult;
}

/**
 *  对比当前时间 date:(yyyy-MM-dd)
 *  返回yes 早于当前时间  否则晚于或等于当前时间
 */
+ (BOOL)isValidateCurrentDate:(NSString *)date
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *currentDate = [formatter stringFromDate:[NSDate date]];

    BOOL compareResult;
    if ([currentDate compare:date] == NSOrderedDescending) {
        compareResult = YES;
    }else
    {
        compareResult = NO;
    }
    return compareResult;
}

/**
 *  对比两个时间的先后 time:(yyyy-MM-dd)
 *  返回yes t2早于t1  否则返回no
 */
+ (BOOL)isMaxTime:(NSString *)time1 minTime:(NSString *)time2
{
    if ([time1 compare:time2] == NSOrderedAscending) {
        return NO;
    }
    return YES;
}


/**
 计算现在时间距离结束时间的间隔天数, 超过结束时间则返回0, 否则返回1,2,3..
 */
+ (NSInteger)nowDataToEndTime:(NSString *)endTime
{
    if (endTime.length >= 10)
    {
        endTime = [endTime substringToIndex:10];
    }else
    {
        return 0;
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *currentStr = [formatter stringFromDate:[NSDate date]];
    NSDate *endDate = [formatter dateFromString:endTime];
    NSDate *currentData = [formatter dateFromString:currentStr];
    
    CGFloat ends = [endDate timeIntervalSince1970];
    CGFloat currents = [currentData timeIntervalSince1970];
    
    if (ends >= currents) {
        return (ends - currents)/(3600*24);
    }
    
    return 0;
}

// 获取今天多少号
+ (NSString *)getDay
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *current = [formatter stringFromDate:[NSDate date]];
    return [current substringWithRange:NSMakeRange(8, 2)];
}

// 获取今天是周几
+ (NSString *)getWeek
{
    NSDate *todate = [NSDate date];//今天
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    NSDateComponents *comps_today= [calendar components:(NSCalendarUnitYear |
                                                         NSCalendarUnitMonth |
                                                         NSCalendarUnitDay |
                                                         NSCalendarUnitWeekday) fromDate:todate];
    NSInteger weekday = [comps_today weekday];
    NSString *str_week = nil;
    
    switch (weekday) {
        case 1:
            str_week = @"星期天";
            break;
        case 2:
            str_week = @"星期一";
            break;
        case 3:
            str_week = @"星期二";
            break;
        case 4:
            str_week = @"星期三";
            break;
        case 5:
            str_week = @"星期四";
            break;
        case 6:
            str_week = @"星期五";
            break;
        case 7:
            str_week = @"星期六";
            break;
    }
    return str_week;
}

/**
 获取今天是本周的第几天
 */
+ (NSInteger)getWeekThisDay
{
    NSDate *todate = [NSDate date];//今天
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    NSDateComponents *comps_today= [calendar components:(NSCalendarUnitYear |
                                                         NSCalendarUnitMonth |
                                                         NSCalendarUnitDay |
                                                         NSCalendarUnitWeekday) fromDate:todate];
    NSInteger weekday = [comps_today weekday] - 1;
    return weekday;
}

// 获取当前周的日期
+ (NSMutableArray *)getCurrentWeekDay
{
    NSDate *todate = [NSDate date];//今天
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    NSDateComponents *comps_today= [calendar components:(NSCalendarUnitYear |
                                                         NSCalendarUnitMonth |
                                                         NSCalendarUnitDay |
                                                         NSCalendarUnitWeekday) fromDate:todate];
    /*
    weekday (0...6)(周日...周六)
    */
    NSInteger weekday = [comps_today weekday] - 1;

    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 7; i++)
    {
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        if (i <= weekday)
        {
            [comps setDay:-(weekday-i)];
        }else if (i > weekday)
        {
            [comps setDay:(i-weekday)];
        }
        NSDate *newDate = [calendar dateByAddingComponents:comps toDate:[NSDate date] options:0];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSString * beforDate = [formatter stringFromDate:newDate];
        NSString *str = [beforDate substringWithRange:NSMakeRange(8, 2)];
        [array addObject:str];
    }
    return array;
}


/**
 获取当前一周的时间, 带有年月日的数组
 */
+ (NSMutableArray *)getCurrentWeekYearMonthDay
{
    NSDate *todate = [NSDate date];//今天
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    NSDateComponents *comps_today= [calendar components:(NSCalendarUnitYear |
                                                         NSCalendarUnitMonth |
                                                         NSCalendarUnitDay |
                                                         NSCalendarUnitWeekday) fromDate:todate];
    /*
     weekday (0...6)(周日...周六)
     */
    NSInteger weekday = [comps_today weekday] - 1;
    
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 7; i++)
    {
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        if (i <= weekday)
        {
            [comps setDay:-(weekday-i)];
        }else if (i > weekday)
        {
            [comps setDay:(i-weekday)];
        }
        NSDate *newDate = [calendar dateByAddingComponents:comps toDate:[NSDate date] options:0];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSString * beforDate = [formatter stringFromDate:newDate];
        [array addObject:beforDate];
    }
    return array;
}

// 换算星座   date 格式  (yyyy-MM-dd HH:mm:ss)
+ (NSString *)isValidateConstellation:(NSString *)date
{    
    NSString *newDate = [date substringFromIndex:5];
    NSArray *array_1 = @[@"水瓶座",@"双鱼座",@"白羊座",@"金牛座",@"双子座",@"巨蟹座",@"狮子座",@"处女座",@"天秤座",@"天蝎座",@"射手座",@"摩羯座"];
    NSArray *startTimeArr = @[@"01-20",@"02-19",@"03-21",@"04-20",@"05-21",@"06-22",@"07-23",@"08-23",@"09-23",@"10-24",@"11-23",@"12-22",@"01-01"];
    NSArray *endTimeArr = @[@"02-18",@"03-20",@"04-19",@"05-20",@"06-21",@"07-22",@"08-22",@"09-22",@"10-23",@"11-22",@"12-21",@"12-31",@"01-19"];
    
    __block NSInteger index = 0;
    [startTimeArr enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (!([newDate compare:obj] == NSOrderedAscending) &&
            !([newDate compare:endTimeArr[idx]] == NSOrderedDescending)) {
            index = idx;
            *stop = YES;
        }
    }];
    
    if (index == 12) {
        index = 11;
    }
    
    return array_1[index];
}

/**
 *  验证银行卡号
 */
+ (BOOL) isVerificationCardNo:(NSString*) cardNo
{
    int oddsum = 0;     //奇数求和
    int evensum = 0;    //偶数求和
    int allsum = 0;
    int cardNoLength = (int)[cardNo length];
    int lastNum = [[cardNo substringFromIndex:cardNoLength-1] intValue];
    
    cardNo = [cardNo substringToIndex:cardNoLength - 1];
    for (int i = cardNoLength -1 ; i>=1;i--) {
        NSString *tmpString = [cardNo substringWithRange:NSMakeRange(i-1, 1)];
        int tmpVal = [tmpString intValue];
        if (cardNoLength % 2 ==1 ) {
            if((i % 2) == 0){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) == 0)
        return YES;
    else
        return NO;
}

/**
 *  转换金钱的格式
 */
+ (NSString *)changeMoneyStyleWithStr:(NSString *)newStr
{
    if ([RegularVerifyModel isNullString:newStr])
    {
        return @"0.00";
    }else
    {
        return [RegularVerifyModel changeMoneyStyleWithMoney:newStr];
    }
}

+ (NSString *)changeMoneyStyleWithMoney:(NSString *)moneyStr
{
    if ([moneyStr isEqualToString:@"0.00"]) {
        return @"0.00";
    }
    NSArray *array = [moneyStr componentsSeparatedByString:@"."];
    NSMutableString *newStr = [[NSMutableString alloc] init];
    NSString *str1 = [array firstObject];
    
    if (str1.length > 3) {
        
        NSInteger number1 = str1.length%3 != 0 ? str1.length%3 : 3;
        NSInteger number2 = str1.length%3 == 0 ? str1.length/3 : str1.length/3 + 1;
        
        for (int i = 0; i < number2; i++) {
            NSRange range ;
            if (i == 0) {
                range = NSMakeRange(0, number1);
            }else{
                range = NSMakeRange((i-1)*3 + number1, 3);
            }
            NSString *tempStr = [str1 substringWithRange:range];
            [newStr appendString:tempStr];
            if (i  == number2 - 1) {
                [newStr appendString:@"."];
            }else{
                [newStr appendString:@","];
            }
        }
    }else
    {
        [newStr appendString:str1];
        [newStr appendString:@"."];
    }
    
    if (array.count == 1)
    {
        [newStr appendString:@"00"];
    }else
    {
        NSString *lastStr = [array lastObject];
        if (lastStr.length) {
            [newStr appendString:[array lastObject]];
        }else{
            [newStr appendString:@"00"];
        }
    }
    return newStr;
}

+ (NSDate *)dateFromStr:(NSString *)str
{
    NSDateFormatter * format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"yyyy年MM月dd日"];
    return [format dateFromString:str];
}

/**
 计算当前时间与结束时间的间隔
 
 @param endTime 结束时间
 @param type 1-倒计时  2-逾期
 @return    时间间隔
 */
+ (NSString *)timeIntervalWithEndTime:(NSString *)endTime type:(NSString **)type
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *currentStr = [formatter stringFromDate:[NSDate date]];
    NSDate *currentData = [formatter dateFromString:currentStr];
    NSDate *endDate = [formatter dateFromString:endTime];
    
    CGFloat ends = [endDate timeIntervalSince1970];
    CGFloat currents = [currentData timeIntervalSince1970];
    
    NSString *redStr = nil;
    NSInteger timeInterval = fabs(ends-currents);
    
    NSInteger day = timeInterval / (3600*24);
    NSInteger hh = timeInterval / 3600;
    NSInteger mm = timeInterval / 60;
    if (day > 0)
    {
        redStr = [NSString stringWithFormat:@"%zd天",day];
    }else if (hh > 0)
    {
        NSInteger m1 = (timeInterval-(hh*3600)) / 60;
        redStr = [NSString stringWithFormat:@"%zd小时",hh];
//        redStr = [NSString stringWithFormat:@"%zd小时%zd分钟",hh,m1];
    }else if (mm > 0)
    {
        redStr = [NSString stringWithFormat:@"%zd分钟",mm];
    }
    if (ends > currents)
    {// 倒计时
        *type = @"1";
    }else
    {// 逾期
        *type = @"2";
    }
    return redStr;
}

/**
 计算完成时间与结束时间的间隔
 
 @param SatrtTime 完成时间
 @param endTime 结束时间
 @param type 1-提前完成  2-逾期完成
 @return    时间间隔
 */
+ (NSString *)timeIntervalWithFinishTime:(NSString *)finishTime endTime:(NSString *)endTime type:(NSString **)type
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *currentData = [formatter dateFromString:finishTime];
    NSDate *endDate = [formatter dateFromString:endTime];
    
    CGFloat ends = [endDate timeIntervalSince1970];
    CGFloat currents = [currentData timeIntervalSince1970];
    
    NSString *redStr = nil;
    NSInteger timeInterval = fabs(ends-currents);
    
    NSInteger day = timeInterval / (3600*24);
    NSInteger hh = timeInterval / 3600;
    NSInteger mm = timeInterval / 60;
    if (day > 0)
    {
        redStr = [NSString stringWithFormat:@"%zd天",day];
    }else if (hh > 0)
    {
        NSInteger m1 = (timeInterval-(hh*3600)) / 60;
        redStr = [NSString stringWithFormat:@"%zd小时",hh];
//        redStr = [NSString stringWithFormat:@"%zd小时%zd分钟",hh,m1];
    }else if (mm > 0)
    {
        redStr = [NSString stringWithFormat:@"%zd分钟",mm];
    }
    if (ends > currents)
    {// 倒计时
        *type = @"1";
    }else
    {// 逾期
        *type = @"2";
    }
    return redStr;
}

@end
