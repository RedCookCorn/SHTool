//
//  SHBaseKeyChain.h
//  SHTool
//
//  Created by 四郎 on 31/01/2018.
//  Copyright © 2018 郑浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHBaseKeyChain : NSObject

/**
 dickey 格式可为：com.xxx.dictionaryKey
 */
+ (void)keyChainSave:(NSString *)value keyInfo:(NSString *)dickey;

/**
 dickey 格式可为：com.xxx.keychainKey
 */
+ (NSString *)keyChainLoad:(NSString *)chainKey;
+ (void)keyChaineDelete:(NSString *)chainkey;

@end
