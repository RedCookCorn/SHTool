//
//  SHTool.h
//  SHTool
//
//  Created by senyuhao on 24/01/2018.
//  Copyright © 2018 郑浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonCrypto.h>
#import <Security/Security.h>

@interface SHTool : NSObject

// judge phonenumber whether ok
+ (BOOL)validPhone:(NSString *)phone;

// judge paperId whether ok
+ (BOOL)validIDCard:(NSString *)paperId;

// judge whether contain emoji
+ (BOOL)containEmoji:(NSString *)string;

// judge whether pure int
+ (BOOL)pureInt:(NSString *)string;

// judge whether pure float
+ (BOOL)pureFloat:(NSString *)string;

// 邮箱判断
+ (BOOL)validEmail:(NSString *)string;

// 固话判断
+ (BOOL)validTelephone:(NSString *)string;

// MD5加密
+ (NSString *)encodeMd5String:(NSString *)srcString;

// 32位 MD5加密
+ (NSString *)encodeMd5_32Bit_String:(NSString *)srcString;

// 3Des加解密
+ (NSString *)tripleDES:(NSString *)srcString
                 desKey:(NSString *)keyString
       encryptOrDecrypt:(CCOperation)encryptOrDecrypt;

@end
