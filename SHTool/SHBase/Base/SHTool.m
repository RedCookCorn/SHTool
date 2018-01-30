//
//  SHTool.m
//  SHTool
//
//  Created by senyuhao on 24/01/2018.
//  Copyright © 2018 郑浩. All rights reserved.
//

#import "SHTool.h"

@implementation SHTool

// judge phonenumber whether ok
+ (BOOL)validPhone:(NSString *)phone {
    NSString *mobileRegex = @"^(0|86|17951)?(13[0-9]|15[012356789]|17[01678]|18[0-9]|14[57])[0-9]{8}$";
    NSPredicate *mobileTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileRegex];
    return [mobileTest evaluateWithObject:phone];
}

// judge paperId whether ok
+ (BOOL)validIDCard:(NSString *)sPaperId {
    //判断位数
    if ([sPaperId length] != 15 && [sPaperId length] != 18) {
        return NO;
    }
    NSString *carid = sPaperId;
    long lSumQT =0;
    //加权因子
    int R[] ={7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 };
    //校验码
    unsigned char sChecker[11]={'1','0','X', '9', '8', '7', '6', '5', '4', '3', '2'};
    
    //将15位身份证号转换成18位
    NSMutableString *mString = [NSMutableString stringWithString:sPaperId];
    if ([sPaperId length] == 15) {
        [mString insertString:@"19" atIndex:6];
        long p = 0;
        const char *pid = [mString UTF8String];
        for (int i=0; i<=16; i++)
        {
            p += (pid[i]-48) * R[i];
        }
        int o = p%11;
        NSString *string_content = [NSString stringWithFormat:@"%c",sChecker[o]];
        [mString insertString:string_content atIndex:[mString length]];
        carid = mString;
    }
    //判断地区码
    NSString * sProvince = [carid substringToIndex:2];
    if (![self areaCode:sProvince]) {
        return NO;
    }
    //判断年月日是否有效
    //年份
    int strYear = [[self getStringWithRange:carid Value1:6 Value2:4] intValue];
    //月份
    int strMonth = [[self getStringWithRange:carid Value1:10 Value2:2] intValue];
    //日
    int strDay = [[self getStringWithRange:carid Value1:12 Value2:2] intValue];
    NSTimeZone *localZone = [NSTimeZone localTimeZone];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setTimeZone:localZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date=[dateFormatter dateFromString:[NSString stringWithFormat:@"%d-%d-%d 12:01:01",strYear,strMonth,strDay]];
    if (date == nil) {
        return NO;
    }
    const char *PaperId  = [carid UTF8String];
    //检验长度
    if( 18 != strlen(PaperId)) return -1;
    //校验数字
    for (int i=0; i<18; i++)
    {
        if ( !isdigit(PaperId[i]) && !(('X' == PaperId[i] || 'x' == PaperId[i]) && 17 == i) )
        {
            return NO;
        }
    }
    //验证最末的校验码
    for (int i=0; i<=16; i++)
    {
        lSumQT += (PaperId[i]-48) * R[i];
    }
    if (sChecker[lSumQT%11] != PaperId[17] )
    {
        return NO;
    }
    return YES;
}

+ (NSString *)getStringWithRange:(NSString *)str Value1:(NSInteger)value1 Value2:(NSInteger )value2 {
    return [str substringWithRange:NSMakeRange(value1,value2)];
}

+ (BOOL)areaCode:(NSString *)code {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    dic[@"11"] = @"北京";
    dic[@"12"] = @"天津";
    dic[@"13"] = @"河北";
    dic[@"14"] = @"山西";
    dic[@"15"] = @"内蒙古";
    dic[@"21"] = @"辽宁";
    dic[@"22"] = @"吉林";
    dic[@"23"] = @"黑龙江";
    dic[@"31"] = @"上海";
    dic[@"32"] = @"江苏";
    dic[@"33"] = @"浙江";
    dic[@"34"] = @"安徽";
    dic[@"35"] = @"福建";
    dic[@"36"] = @"江西";
    dic[@"37"] = @"山东";
    dic[@"41"] = @"河南";
    dic[@"42"] = @"湖北";
    dic[@"43"] = @"湖南";
    dic[@"44"] = @"广东";
    dic[@"45"] = @"广西";
    dic[@"46"] = @"海南";
    dic[@"50"] = @"重庆";
    dic[@"51"] = @"四川";
    dic[@"52"] = @"贵州";
    dic[@"53"] = @"云南";
    dic[@"54"] = @"西藏";
    dic[@"61"] = @"陕西";
    dic[@"62"] = @"甘肃";
    dic[@"63"] = @"青海";
    dic[@"64"] = @"宁夏";
    dic[@"65"] = @"新疆";
    dic[@"71"] = @"台湾";
    dic[@"81"] = @"香港";
    dic[@"82"] = @"澳门";
    dic[@"91"] = @"国外";
    if (dic[code] == nil) {
        return NO;
    }
    return YES;
}

// judge whether contain emoji
+ (BOOL)containEmoji:(NSString *)string {
    __block BOOL returnValue =NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring,NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    
                                    if (substring.length > 1) {
                                        
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue =YES;
                                        }
                                    }
                                }else if (substring.length > 1) {
                                    
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue =YES;
                                    }
                                }else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue =NO;
                                    }else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue =YES;
                                    }else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue =YES;
                                    }else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue =YES;
                                    }else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue =YES;
                                    }
                                    
                                }
                                
                            }];
    return returnValue;
}

+ (BOOL)pureInt:(NSString *)string {
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

+ (BOOL)pureFloat:(NSString *)string {
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

// 邮箱判断
+ (BOOL)validEmail:(NSString *)string {
    NSString *regex = @"\\b([a-zA-Z0-9%_.+\\-]+)@([a-zA-Z0-9.\\-]+?\\.[a-zA-Z]{2,6})\\b";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:string];
}

// 固话判断
+ (BOOL)validTelephone:(NSString *)string {
    NSString * PHS = @"\\d{3}-\\d{8}|\\d{4}-\\d{7}|\\d{4}-\\d{8}";
    NSPredicate *regextestphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    return [regextestphs evaluateWithObject:string];
}
@end
