//
//  NSData+Encryption.m
//  MyStashForCoreDataSecurity
//
//  Created by lyfing lee on 13-11-17.
//  Copyright (c) 2013年 lyfing.inc. All rights reserved.
//

#import "NSData+Encryption.h"
#import <CommonCrypto/CommonCrypto.h>
@implementation NSData (Encryption)

- (NSData *)transposeWithAES256:(NSString *)keyValue forOperation:(NSInteger)operation
{
    char key[kCCKeySizeAES256 + 1];
    bzero(key, sizeof(key));
    
    [keyValue getCString:key maxLength:sizeof(key) encoding:NSUTF8StringEncoding];
    size_t allocatedSize = self.length + kCCBlockSizeAES128;
    void *output = malloc(allocatedSize);
    
    size_t actualSize = 0;
    CCCryptorStatus resultCode = CCCrypt((u_int32_t)operation,
                                         kCCAlgorithmAES128,
                                         kCCOptionPKCS7Padding,
                                         key,
                                         kCCKeySizeAES256,
                                         nil,
                                         self.bytes,
                                         self.length,
                                         output,
                                         allocatedSize,
                                         &actualSize);
    if ( resultCode != kCCSuccess ) {
        free(output);
        
        return nil;
    }
    
    return [NSData dataWithBytesNoCopy:output length:actualSize];
}

- (NSData *)transposeWithAES128:(NSString *)keyValue andViKey:(NSString *)viKey forOperation:(NSInteger)operation
{
    char keyPtr[kCCKeySizeAES128 + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [keyValue getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    char ivPtr[kCCBlockSizeAES128 + 1];
    memset(ivPtr, 0, sizeof(ivPtr));
    [viKey getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [self length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesCrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt((u_int32_t)operation,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding,
                                          keyPtr,
                                          kCCBlockSizeAES128,
                                          ivPtr,
                                          [self bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
    }
    free(buffer);
    return nil;
}

- (NSData *)encryptWithKey:(NSString *)key
{
    return [self transposeWithAES256:key forOperation:kCCEncrypt];
}

- (NSData *)decryptWithKey:(NSString *)key
{
    return [self transposeWithAES256:key forOperation:kCCDecrypt];
}

- (NSData *)encryptWithKey:(NSString *)key andViKey:(NSString *)viKey
{
    return [self transposeWithAES128:key andViKey:viKey forOperation:kCCEncrypt];
}

- (NSData *)decryptWithKey:(NSString *)key andViKey:(NSString *)viKey
{
    return [self transposeWithAES128:key andViKey:viKey forOperation:kCCDecrypt];
}


- (NSData *)transposeDES:(NSString *)keyValue forOperation:(NSInteger)operation
{
    size_t numBytesEncrypted = 0;
    size_t bufferSize = self.length + kCCBlockSizeDES;
    void *buffer = malloc(bufferSize);
    
    char key[kCCKeySizeDES + 1];
    bzero(key, sizeof(key));
    
    [keyValue getCString:key maxLength:sizeof(key) encoding:NSUTF8StringEncoding];
    
    CCCryptorStatus result = CCCrypt( (u_int32_t)operation,
                                     kCCAlgorithmDES,
                                     kCCOptionPKCS7Padding,
                                     key,
                                     kCCKeySizeDES,
                                     NULL,
                                     self.bytes,
                                     self.length,
                                     buffer,
                                     bufferSize,
                                     &numBytesEncrypted);
    if( result == kCCSuccess )
    {
        NSData *output = [NSData dataWithBytes:buffer length:numBytesEncrypted];
        free(buffer);
        return output;
    } else {
        NSLog(@"Failed DES encrypt...");
        return nil;
    }
}

- (NSData *)encryptDESWithKey:(NSString *)key
{
    return [self transposeDES:key forOperation:kCCEncrypt];
}

- (NSData *)decryptDESWithKey:(NSString *)key
{
    return [self transposeDES:key forOperation:kCCDecrypt];
}
@end
