//
//  SHTool.h
//  SHTool
//
//  Created by senyuhao on 24/01/2018.
//  Copyright © 2018 郑浩. All rights reserved.
//

#import <Foundation/Foundation.h>

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

@end
