//
//  NSString+MD5.m
//  MD5hash
//
//  Created by Web on 10/27/12.
//  Copyright (c) 2012 HappTech. All rights reserved.
//

#import "NSString+MD5.h"
@implementation NSString (MD5)
- (id)MD5
{
    const char *cStr = [self UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call

    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];

    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];

    return  output;
}
//判断是否是电话号码
- (BOOL)isMobileNumber
{

    if (self.length != 11)
    {
        return NO;
    }
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[0, 1, 6, 7, 8], 18[0-9]
     * 移动号段: 134,135,136,137,138,139,147,150,151,152,157,158,159,170,178,182,183,184,187,188
     * 联通号段: 130,131,132,145,155,156,170,171,175,176,185,186
     * 电信号段: 133,149,153,170,173,177,180,181,189
     */
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|7[0135678]|8[0-9])\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,147,150,151,152,157,158,159,170,178,182,183,184,187,188
     */
    NSString *CM = @"^1(3[4-9]|4[7]|5[0-27-9]|7[08]|8[2-478])\\d{8}$";
    /**
     * 中国联通：China Unicom
     * 130,131,132,145,155,156,170,171,175,176,185,186
     */
    NSString *CU = @"^1(3[0-2]|4[5]|5[56]|7[0156]|8[56])\\d{8}$";
    /**
     * 中国电信：China Telecom
     * 133,149,153,170,173,177,180,181,189
     */
    NSString *CT = @"^1(3[3]|4[9]|53|7[037]|8[019])\\d{8}$";
    
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:self] == YES)
        || ([regextestcm evaluateWithObject:self] == YES)
        || ([regextestct evaluateWithObject:self] == YES)
        || ([regextestcu evaluateWithObject:self] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
//字符串的替换
-(NSString *)replaceStringWithLocation:(NSInteger)start andLenth:(NSInteger)length withString:(NSString *)replaceStr
{
    if (self.length < (start + length + 1)) return nil;
    NSString *str_subString = [self substringWithRange:NSMakeRange(start, length)];
    
    NSString *string = [self stringByReplacingOccurrencesOfString:str_subString withString:replaceStr];
    return string;
}
+(long long)getCurrentDate{
    NSDate *date = [NSDate date];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];//格式化
    
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    [df setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"] ];
    
    NSString * timeStr =[df stringFromDate:date];
    NSDate *currentDate = [df dateFromString:timeStr];
    return [currentDate timeIntervalSince1970]*1000;
}
+(NSString *)getCurrentDateStr{
    NSDate *date = [NSDate date];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];//格式化
    
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    [df setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"] ];
    
    NSString * timeStr =[df stringFromDate:date];
    return timeStr;
}
//时间的转换(long long)--->date  2015-12-12  00:00:00
- (NSString *)getDate

{
    
    NSDate *d = [[NSDate alloc]initWithTimeIntervalSince1970:[self longLongValue]/1000.0];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];//格式化
    
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    [df setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"] ];
    
    NSString * timeStr =[df stringFromDate:d];
    
    return timeStr;
    
}
//时间的转换(long long)--->date  2015年12月12日  周几  00:00
- (NSString *)getDate_Weakday

{
    
    NSDate *d = [[NSDate alloc]initWithTimeIntervalSince1970:[self longLongValue]/1000.0];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];//格式化
    
    [df setDateFormat:@"yyyy年MM月dd日 eee HH:mm"];
    
    [df setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"] ];
    
    NSString * timeStr =[df stringFromDate:d];
    
    return timeStr;
    
}
- (NSString *)getDate_small
{
    NSDate *d = [[NSDate alloc]initWithTimeIntervalSince1970:[self longLongValue]/1000.0];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];//格式化
    
    [df setDateFormat:@"yy-MM-dd HH:mm:ss"];
    
    [df setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"] ];
    
    NSString * timeStr =[df stringFromDate:d];
    
    return timeStr;

}

- (NSString *)getDateYearMonthDayHoursMinutes
{
    NSDate *d = [[NSDate alloc]initWithTimeIntervalSince1970:[self longLongValue]/1000.0];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];//格式化
    
    [df setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    [df setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"] ];
    
    NSString * timeStr =[df stringFromDate:d];
    
    return timeStr;
    
}

- (NSString *)getDateWithMonthAndDay

{
    
    NSDate *d = [[NSDate alloc]initWithTimeIntervalSince1970:[self longLongValue]/1000.0];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];//格式化
    
    [df setDateFormat:@"MM-dd"];
    
    [df setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"] ];
    
    NSString * timeStr =[df stringFromDate:d];
    
    return timeStr;
    
}
- (NSString *)getDateWithMonthAndDayAndHour

{
    
    NSDate *d = [[NSDate alloc]initWithTimeIntervalSince1970:[self longLongValue]/1000.0];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];//格式化
    
    [df setDateFormat:@"MM-dd HH"];
    
    [df setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"] ];
    
    NSString * timeStr =[df stringFromDate:d];
    
    return timeStr;
    
}
- (NSString *)getDateWithYearAndMonthAndDay

{
    
    NSDate *d = [[NSDate alloc]initWithTimeIntervalSince1970:[self longLongValue]/1000.0];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];//格式化
    
    [df setDateFormat:@"yyyy-MM-dd"];
    
    [df setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"] ];
    
    NSString * timeStr =[df stringFromDate:d];
    
    return timeStr;
    
}
- (NSString *)getDateWithYearAndMonth

{
    NSDate *d = [[NSDate alloc]initWithTimeIntervalSince1970:[self longLongValue]/1000.0];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];//格式化
    
    [df setDateFormat:@"yyyy-MM"];
    
    [df setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"] ];
    
    NSString * timeStr =[df stringFromDate:d];
    
    return timeStr;
}
-(long long)formateFormStringWithMonthDayToLong
{
    NSDateFormatter *formate = [[NSDateFormatter alloc]init];
    [formate setDateFormat:@"MM-dd"];
    NSDate *date = [formate dateFromString:self];
    return [date timeIntervalSince1970]*1000;
}
-(long long)formateFromStringToLong
{
    NSDateFormatter *formate = [[NSDateFormatter alloc]init];
    [formate setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [formate dateFromString:self];
    
    return [date timeIntervalSince1970]*1000;
}

-(long long)formateFormStringWithMonthDayHourToLong
{
    NSDateFormatter *formate = [[NSDateFormatter alloc]init];
    [formate setDateFormat:@"MM-dd-HH"];
    NSDate *date = [formate dateFromString:self];
    
    return [date timeIntervalSince1970]*1000;
}
-(long long)formateFormStringWithYearMonthToLong;
{
    NSDateFormatter *formate = [[NSDateFormatter alloc]init];
    [formate setDateFormat:@"yyyy-MM"];
    NSDate *date = [formate dateFromString:self];
    return [date timeIntervalSince1970]*1000;
}
//月+日   09-09
- (NSString *)getMonthAndDay

{
    
    NSDate *d = [[NSDate alloc]initWithTimeIntervalSince1970:[self longLongValue]/1000.0];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];//格式化
    
    [df setDateFormat:@"MM-dd"];
    
    [df setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"] ];
    
    NSString * timeStr =[df stringFromDate:d];
    
    return timeStr;
    
}
-(float)getStringHight:(int)text_size distance:(int)distance
{
    CGSize size = [self boundingRectWithSize:CGSizeMake(kScreenWidth-distance, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:text_size]} context:nil].size;
    float hight = size.height;
    return hight;
}

//根据字符串设置长度
+ (CGSize)labelAutoCalculateRectWith:(NSString*)text FontSize:(CGFloat)fontSize MaxSize:(CGSize)maxSize
{
    if ([text isEqual:[NSNull null]] || [text isEqual:nil]) {
        return CGSizeMake(0, 0);
    }
    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode=NSLineBreakByWordWrapping;
    NSDictionary* attributes =@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize],NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize labelSize = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    
    labelSize.height=ceil(labelSize.height);
    labelSize.width=ceil(labelSize.width);
    return labelSize;
}
//判断日期是今天，昨天还是前天
+(NSString *)compareDate:(NSDate *)date{
    
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSDate *today = [[NSDate alloc] init];
    NSDate *theDayBeforeYesterday, *yesterday;
    
    theDayBeforeYesterday = [today dateByAddingTimeInterval: -secondsPerDay*2];
    yesterday = [today dateByAddingTimeInterval: -secondsPerDay];
    
    // 10 first characters of description is the calendar date:
    NSString * todayString = [[today description] substringToIndex:10];
    NSString * yesterdayString = [[yesterday description] substringToIndex:10];
    NSString * theDayBeforeYesterdayString = [[theDayBeforeYesterday description] substringToIndex:10];
    
    NSString * dateString = [[date description] substringToIndex:10];
    
    if ([dateString isEqualToString:todayString])
    {
        return @"今天";
    } else if ([dateString isEqualToString:yesterdayString])
    {
        return @"昨天";
    }else if ([dateString isEqualToString:theDayBeforeYesterdayString])
    {
        return @"前天";
    }
    else
    {
        return dateString;
    }
}
//判断是不是浮点型
+ (BOOL)isPureFloat:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}
//判断字符是否为全空格
-(BOOL) isEmptyString
{
    if (!self)
    {
        return YES;
    }
    else
    {
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        
        NSString *trimedString = [self stringByTrimmingCharactersInSet:set];
        
        if ([trimedString length] == 0)
        {
            return YES;
            
        }
        else
        {
            return NO;
        }
    }
}

-(NSMutableArray *)findAllTheIntCharacter{
    if (self.length == 1) {
        NSAssert(NO, @"字符串长度不能小于1") ;
    }
    NSMutableArray *array = [NSMutableArray array];
    NSRange range;
    for (int i = 0; i<self.length; i++) {
        range = [self rangeOfComposedCharacterSequenceAtIndex:i];
        NSString *str = [self substringWithRange:range];
        if ([str isPureInt]) {
            [array addObject:str];
        }
    }
    return array;
}
- (BOOL)isPureInt
{
    NSScanner *scan = [NSScanner scannerWithString:self];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}
-(BOOL)isBlank{
    if (self == nil || self == NULL || [self containsString:@"null"]) {
        return YES;
    }
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0) {
        return YES;
    }
    return NO;
}
-(BOOL)isNotBlank{
    return ![self isBlank];
}
-(NSString *)removeBlankSpace{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}
-(NSMutableArray *)componentsSeparatedByString:(nonnull NSString *)string andRemoveNullElement:(BOOL)removeNullElement{
    if (![self containsString:string]) return nil;
    NSMutableArray *array = [NSMutableArray arrayWithArray:[self componentsSeparatedByString:string]];
    if (removeNullElement) {
        [array removeObject:@""];
    }
    return array;
}
- (NSDictionary *)toDictionaryAsJSON {
    id result = [NSJSONSerialization JSONObjectWithData: [self dataUsingEncoding:NSUTF8StringEncoding]
                                                options: NSJSONReadingAllowFragments
                                                  error: nil];
    if ([result isKindOfClass:[NSString class]]) {
        result = [result toDictionaryAsJSON];
    }
    return result;
}

//判断是否有特殊字符
- (BOOL)stringContainsEmoji
{
    __block BOOL returnValue = NO;
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                              const unichar hs = [substring characterAtIndex:0];
                              if (0xd800 <= hs && hs <= 0xdbff)
                              {
                                  if (substring.length > 1) {
                                      const unichar ls = [substring characterAtIndex:1];
                                      const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                      if (0x1d000 <= uc && uc <= 0x1f77f) {
                                          returnValue = YES;
                                      }
                                  }
                              }
                              else if (substring.length > 1)
                              {
                                  const unichar ls = [substring characterAtIndex:1];
                                  if (ls == 0x20e3)
                                  {
                                      returnValue = YES;
                                  }
                              }
                              else
                              {
                                  if (0x2100 <= hs && hs <= 0x27ff)
                                  {
                                      returnValue = YES;
                                  } else if (0x2B05 <= hs && hs <= 0x2b07)
                                  {
                                      returnValue = YES;
                                  } else if (0x2934 <= hs && hs <= 0x2935)
                                  {
                                      returnValue = YES;
                                  } else if (0x3297 <= hs && hs <= 0x3299)
                                  {
                                      returnValue = YES;
                                  } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50)
                                  {
                                      returnValue = YES;
                                  }
                              }
                          }];
    
    return returnValue;
}
- (BOOL)isValidEmail {
    BOOL stricterFilter = YES; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailPredicate evaluateWithObject:self];
}
- (BOOL)isValidCarNumber {
    NSString *pattern = @"^[京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领A-Z]{1}[A-Z]{1}[警京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼]{0,1}[A-Z0-9]{4}[A-Z0-9挂学警港澳]{1}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isValid = [pred evaluateWithObject:self];
    return isValid;
}
@end
