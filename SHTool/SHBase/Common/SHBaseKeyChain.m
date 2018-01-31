//
//  SHBaseKeyChain.m
//  SHTool
//
//  Created by 四郎 on 31/01/2018.
//  Copyright © 2018 郑浩. All rights reserved.
//

#import "SHBaseKeyChain.h"

@implementation SHBaseKeyChain

+ (void)keyChainSave:(NSString *)value keyInfo:(NSString *)dickey {
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
    [tempDic setObject:value forKey:dickey];
    [self save:dickey data:tempDic];
}

+ (NSString *)keyChainLoad:(NSString *)chainkey;{
    NSMutableDictionary *tempDic = (NSMutableDictionary *)[self load:chainkey];
    return [tempDic objectForKey:chainkey];
}

+ (void)keyChaineDelete:(NSString *)chainkey {
    [self del:chainkey];
}

+ (NSMutableDictionary *)getKeyChainQuery:(NSString *)service {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (id)kSecClassGenericPassword,(id)kSecClass,
            service,(id)kSecAttrService,
            service, (id)kSecAttrAccount,
            (id)kSecAttrAccessibleAfterFirstUnlock,(id)kSecAttrAccessible,
            nil];
}

+ (void)save:(NSString *)service data:(id)data {
    // Get search dictionary
    NSMutableDictionary *keyChainQuery = [self getKeyChainQuery:service];
    // Delete old item before add new item
    SecItemDelete((CFDictionaryRef)keyChainQuery);
    // Add new object to search dictionary(Attention:the data format)
    [keyChainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(id)kSecValueData];
    // Add item to keychain with the search dictionary
    SecItemAdd((CFDictionaryRef)keyChainQuery, NULL);
}

+ (id)load:(NSString *)service {
    id ret = nil;
    NSMutableDictionary *keyChainQuery = [self getKeyChainQuery:service];
    
    [keyChainQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    [keyChainQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((CFDictionaryRef)keyChainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        } @catch (NSException *exception) {
            NSLog(@"unarchive of %@ failed:%@", service, exception);
        } @finally {
            
        }
    }
    
    if (keyData) {
        CFRelease(keyData);
    }
    return ret;
}

+ (void)del:(NSString *)service {
    NSMutableDictionary *keyChainQuery = [self getKeyChainQuery:service];
    SecItemDelete((CFDictionaryRef)keyChainQuery);
}

@end
