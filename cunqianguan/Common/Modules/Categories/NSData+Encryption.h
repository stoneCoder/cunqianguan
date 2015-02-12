//
//  NSData+Encryption.h
//  MyStashForCoreDataSecurity
//
//  Created by lyfing lee on 13-11-17.
//  Copyright (c) 2013年 lyfing.inc. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, CryptoType){
    CryptoTypeAES,
    CryptoTypeDES
};

@interface NSData (Encryption)
- (NSData *)encryptWithKey:(NSString *)key;
- (NSData *)decryptWithKey:(NSString *)key;

- (NSData *)encryptWithKey:(NSString *)key andViKey:(NSString *)viKey;
- (NSData *)decryptWithKey:(NSString *)key andViKey:(NSString *)viKey;

- (NSData *)encryptDESWithKey:(NSString *)key;
- (NSData *)decryptDESWithKey:(NSString *)key;

@end
