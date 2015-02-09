//
//  BaseUtil.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/19.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "BaseUtil.h"
#import "NSData+Encryption.h"
#import "SWHex.h"
#import <CommonCrypto/CommonHMAC.h>
#import <CommonCrypto/CommonCryptor.h>

static NSString *const cryptPassword = @"me.baoxianqi.www";
@implementation BaseUtil
#pragma mark - 获取MD5字符串
+ (NSString *) stringFromMD5:(NSString*)string
{
    if(self == nil || [string length] == 0)   {   return nil; }
    
    const char *value = [string UTF8String];
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, strlen(value), outputBuffer);
    
    NSMutableString* outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(unsigned int count = 0; count < CC_MD5_DIGEST_LENGTH; count++)
    {
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    
    return outputString;
}

+ (NSString *) stringFromBASE64:(NSString*)string
{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64Encoding];
}

+ (NSString *)transformLongToStrDate:(long)dateTimeLong WithType:(NSString *)type
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:type];
    NSTimeInterval time= [[NSNumber numberWithLong:dateTimeLong] doubleValue];
    NSDate *detaildate=[NSDate dateWithTimeIntervalSinceNow:time];
    NSString *timestr = [formatter stringFromDate:detaildate];
    return timestr;
}

+ (NSDate *)transformLongToDate:(long)dateTimeLong WithType:(NSString *)type
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:type];
    NSTimeInterval time= [[NSNumber numberWithLong:dateTimeLong] doubleValue];
    NSDate *detaildate=[NSDate dateWithTimeIntervalSinceNow:time];
    return detaildate;
}

+(float)getHeightByString:(NSString *)text font:(UIFont*)widthfont allwidth:(float)allwidth{
    return ceilf([BaseUtil sizeOfTextInFont:text width:allwidth height:NSIntegerMax font:widthfont].height);
}

+(float)getWidthByString:(NSString *)text font:(UIFont*)widthfont allheight:(float)allheight andMaxWidth:(float)width{
    return ceilf([BaseUtil sizeOfTextInFont:text width:width height:allheight font:widthfont].width);
}

+(CGSize)sizeOfTextInFont:(NSString*)text width:(CGFloat)width height:(CGFloat)height font:(UIFont*)font
{
    CGSize size = CGSizeMake(0, 0);
    
    if (iOS7) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
        NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle};
        
        size = [text boundingRectWithSize:CGSizeMake(width, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    }else{
        size = [text sizeWithFont:font constrainedToSize:CGSizeMake(width, height) lineBreakMode:NSLineBreakByCharWrapping];
    }
    size = CGSizeMake(size.width, ceilf(size.height));
    return size;
}

+(BOOL)isPhoneNum:(NSString *)telphone
{
    NSString* regex = @"^[0-9]{11}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL isMatch = [pred evaluateWithObject:telphone];
    return isMatch;
}

#pragma mark - Encrypt / Decrypt With AES
+ (NSString*)encrypt:(NSString*)toBeEncString{
    NSString *retString = nil;
    NSError *err = nil;
    NSData *data = [toBeEncString dataUsingEncoding:NSUTF8StringEncoding];
    data = [data encryptWithKey:cryptPassword];
    if (!err) {
        retString = [data bytesString];
    }else{
        NSLog(@"%@",err);
    }
    return retString;
}
+ (NSString*)decrypt:(NSString*)toBeDecString{
    NSString *retString = nil;
    NSError *err = nil;
    NSData *data = [toBeDecString dataFromBytesString];
    data = [data decryptWithKey:cryptPassword];
    if (!err) {
        retString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }else{
        NSLog(@"%@",err);
    }
    return retString;
}

+ (NSString *)hmac_sha1:(NSString *)data secret:(NSString *)key{
    if (!key) {
        key = cryptPassword;
    }
    const char *cKey  = [key cStringUsingEncoding:NSUTF8StringEncoding];
    const char *cData = [data cStringUsingEncoding:NSUTF8StringEncoding];
    char cHMAC[CC_SHA1_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC length:CC_SHA1_DIGEST_LENGTH];
    NSString *hash = [HMAC base64Encoding];
    return hash;
}

/*获取手机通讯录*/
//+(NSMutableArray *)getAddressBookPersonInfo
//{
//    NSMutableArray *addressBookArray = [[NSMutableArray alloc] init];
//    //取得本地通信录名柄
//    ABAddressBookRef addressBook ;
//    
//    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0)    {
//        addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
//        //等待同意后向下执行
//        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
//        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error){                                                     dispatch_semaphore_signal(sema);
//        });
//        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
//    }else{
//        addressBook = ABAddressBookCreate();
//    }
//   
//    //取得本地所有联系人记录
//    CFArrayRef results = ABAddressBookCopyArrayOfAllPeople(addressBook);
//    for(int i = 0; i < CFArrayGetCount(results); i++)
//    {
//        ABRecordRef person = CFArrayGetValueAtIndex(results, i);
//        //读取firstname
//        NSString *first = (__bridge NSString*)ABRecordCopyValue(person, kABPersonFirstNameProperty);
//        if (first==nil) {
//            first = @"";
//        }
//        //读取lastname
//        NSString *last = (__bridge NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
//        if (last == nil) {
//            last = @"";
//        }
//        //读取手机号
//        ABMultiValueRef tmlphone =  ABRecordCopyValue(person, kABPersonPhoneProperty);
//        NSString* telphone = (__bridge NSString*)ABMultiValueCopyValueAtIndex(tmlphone, 0);
//        if (telphone == nil) {
//            telphone = @"";
//        }
//        RLAddressBookVO *addressBookVO = [[RLAddressBookVO alloc] init];
//        addressBookVO.name = [NSString stringWithFormat:@"%@%@",first,last];
//        addressBookVO.phoneNum = telphone;
//        if (telphone.length > 0 && ![telphone isEqualToString:@"1-800-MY-APPLE"]) {
//            [addressBookArray addObject:addressBookVO];
//        }
//        CFRelease(tmlphone);
//     
//    }
//    CFRelease(results);
//    CFRelease(addressBook);
//    return addressBookArray;
//}
+ (NSString *)toJSONData:(id)theData{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if ([jsonData length] > 0 && error == nil){
        return [[NSString alloc] initWithData:jsonData
                                     encoding:NSUTF8StringEncoding];
    }else{
        return nil;
    }
}

+(NSArray *)readCityTxt
{
    NSString* path = [[NSBundle mainBundle] pathForResource:@"area" ofType:@"txt"];
    NSString* content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    NSError *error = nil;
    NSArray *data = [NSJSONSerialization JSONObjectWithData:[content dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:&error];
    return data;
}
@end
