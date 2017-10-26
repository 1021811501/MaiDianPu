//
//  NSString+MD5.h
//  MD5hash
//
//  Created by Web on 10/27/12.
//  Copyright (c) 2012 HappTech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>
@interface NSString (MD5)
- (id)MD5;

//判断是否是电话号码
- (BOOL)isMobileNumber;

//电话号码的替换
-(NSString *)replaceString;
//时间转换
- (NSString *)getDate;
//时间转换,转换成08-01格式
- (NSString *)getDateWithMonthAndDay;
- (NSString *)getDateWithYearAndMonthAndDay;
- (NSString *)getDateWithYearAndMonth;
//将字符(时间)串改为longlong类型
-(long long)formateFromStringToLong;
//将字符串(月日小时)改为longlong类型
-(long long)formateFormStringWithMonthDayHourToLong;
-(long long)formateFormStringWithYearMonthToLong;
//将字符串(月日)改为longlong类型
-(long long)formateFormStringWithMonthDayToLong;
//将longlong转换为月天时
- (NSString *)getDateWithMonthAndDayAndHour;
//去除年份前两位
- (NSString *)getDate_small;
//获取09-09
- (NSString *)getMonthAndDay;
//获取当前时间返回longlong型
+(long long)getCurrentDate;
//获取当前时间返回字符串
+(NSString *)getCurrentDateStr;
//获取字符串高度
-(float)getStringHight:(int)text_size distance:(int)distance;
//根据字符串设置长度
+ (CGSize)labelAutoCalculateRectWith:(NSString*)text FontSize:(CGFloat)fontSize MaxSize:(CGSize)maxSize;
//判断日期是今天，昨天还是前天
+(NSString *)compareDate:(NSDate *)date;
//2015年12月14日 00:00
- (NSString *)getDateYearMonthDayHoursMinutes;
//时间的转换(long long)--->date  2015年12月12日  周几  00:00
- (NSString *)getDate_Weakday;
//判断是不是浮点型
+ (BOOL)isPureFloat:(NSString *)string;

//判断字符是否为全空格
-(BOOL) isEmptyString;

//判断是否有特殊字符
- (BOOL)stringContainsEmoji;

//判断是否为纯数字
-(BOOL)isPureInt;

//找出字符串中所有的数字
-(NSMutableArray *)findAllTheIntCharacter;
-(BOOL)isNotBlank;
-(BOOL)isBlank;
-(NSMutableArray *)componentsSeparatedByString:(nonnull NSString *)string andRemoveNullElement:(BOOL)removeNullElement;
-(NSString *_Nullable)removeBlankSpace;
- (NSDictionary *_Nullable)toDictionaryAsJSON;

- (BOOL)isValidEmail;
- (BOOL)isValidCarNumber;
@end







