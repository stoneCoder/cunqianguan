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

static NSString *const cryptPassword = @"0123456789abcdef";
static NSString *const cryptViKey = @"0123456789123456";
static NSString *const hmacPassword = @"4318sqzs";
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

+(NSDate*)convertDateFromString:(NSString*)dateTime WithType:(NSString *)type
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:type];
    NSDate *date=[formatter dateFromString:dateTime];
    return date;
}

+ (NSString *)convertStringFromDate:(NSDate *)date WithType:(NSString *)type
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:type];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
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
    data = [data encryptWithKey:cryptPassword andViKey:cryptViKey];
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
    data = [data decryptWithKey:cryptPassword andViKey:cryptViKey];
    if (!err) {
        retString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }else{
        NSLog(@"%@",err);
    }
    return retString;
}

+ (NSString *)hmac_sha1:(NSString *)data secret:(NSString *)key{
    if (!key) {
        key = hmacPassword;
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

+ (NSDictionary *)jsonStrToDic:(NSString *)str
{
    NSData *jsonData = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                         options:NSJSONReadingMutableContainers
                                                           error:&err];
    return dic;
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

#pragma mark -- 计算倒计时
+(NSString *)mathTime:(NSInteger)time
{
    NSString *timeString=@"";
    NSString *day = @"";
    NSString *house=@"";
    NSString *min=@"";
    NSString *sen=@"";
    //秒
    sen = [NSString stringWithFormat:@"%.2d",(int)time%60];
    //分
    min = [NSString stringWithFormat:@"%.2d", (int)time/60%60];
    //小时
    house = [NSString stringWithFormat:@"%.2d",(int)time/3600%24];
    //天
    day = [NSString stringWithFormat:@"%d天",(int)time/3600/24];
    timeString=[NSString stringWithFormat:@"%@%@:%@:%@",day,house,min,sen];
    return timeString;
}

#pragma mark -- 图片保存本地
+ (NSString*) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    NSData *imageData = UIImagePNGRepresentation(currentImage);
    
    if (!imageData) {
        imageData = UIImageJPEGRepresentation(currentImage, 1);
    }
    
    // 获取沙盒目录
    NSString *fullPath = [PHOTO_DIR_PATH stringByAppendingPathComponent:imageName];
    [BaseUtil createDirectory:PHOTO_DIR_PATH];
    // 将图片写入文件
    if (![imageData writeToFile:fullPath atomically:NO]) {
        return nil;
    }
    return fullPath;
}

+ (BOOL)saveImage:(UIImage *)currentImage withFullFilePath:(NSString *)filePath
{
    NSData *imageData = UIImagePNGRepresentation(currentImage);//(currentImage, 1);
    
    if (!imageData) {
        imageData = UIImageJPEGRepresentation(currentImage, 1);
    }
    NSString *directory = [filePath stringByDeletingLastPathComponent];
    
    [BaseUtil createDirectory:directory];
    // 将图片写入文件
    if (![imageData writeToFile:filePath atomically:NO]) {
        return NO;
    }
    return YES;
}

+ (NSString*) saveImageToPhotoDirectory:(UIImage *)currentImage withName:(NSString *)imageName
{
    // 获取沙盒目录
    NSString *fullPath = [PHOTO_DIR_PATH stringByAppendingPathComponent:imageName];
    if ([self saveImage:currentImage withFullFilePath:fullPath]) {
        return fullPath;
    }
    return nil;
}

+ (BOOL)moveFile:(NSString*)currentPath to:(NSString*)toPath{
    if (currentPath.length ==0 || toPath.length == 0){
        return NO;
    }
   
    NSString *toPathDir = [toPath stringByDeletingLastPathComponent];
    [BaseUtil createDirectory:toPathDir];
    NSError *err = nil;
    [[NSFileManager defaultManager] moveItemAtPath:currentPath toPath:toPath error:&err];
    if (err) {
        return NO;
    }else{
        NSLog(@"================File Moved To: ===============\n%@",toPath);
    }
    return YES;
}

+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}



+ (UIImage*)getPhoto:(NSString*)photoName{
    NSString *imagePath = [PHOTO_DIR_PATH stringByAppendingPathComponent:photoName];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    return image;
}

+ (BOOL)createDirectory:(NSString*)path{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDIR = NO;
    [fileManager fileExistsAtPath:path isDirectory:&isDIR];
    if (!isDIR) {
        [fileManager removeItemAtPath:path error:nil];
        return [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return YES;
}

+ (NSString *)generateUUID
{
    NSString *result = nil;
    
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    if (uuid)
    {
        result = (__bridge_transfer NSString *)CFUUIDCreateString(NULL, uuid);
        CFRelease(uuid);
    }
    
    return result;
}

+ (NSString *)transformBankCard:(NSString *)cardNum
{
    if ([BaseUtil checkCardNo:cardNum]) {
        NSString *firstStr = [cardNum substringWithRange:NSMakeRange(0,4)];
        NSString *secondStr = [cardNum substringWithRange:NSMakeRange(cardNum.length - 5,4)];
        cardNum = [NSString stringWithFormat:@"%@ ******** %@",firstStr,secondStr];
    }
    return cardNum;
}

+ (BOOL)checkCardNo:(NSString*) cardNo{
    int sum = 0;
    int len = cardNo.length;
    int i = 0;
    
    while (i < len) {
        NSString *tmpString = [cardNo substringWithRange:NSMakeRange(len - 1 - i, 1)];
        int tmpVal = [tmpString intValue];
        if (i % 2 != 0) {
            tmpVal *= 2;
            if(tmpVal>=10) {
                tmpVal -= 9;
            }
        }
        sum += tmpVal;
        i++;
    }
    
    if((sum % 10) == 0)
        return YES;
    else
        return NO;
}

+ (BOOL)isInstallApp:(NSString *)url
{
  return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:url]];
}

+ (int)getRandomNumber:(int)from to:(int)to
{
    return (int)(from + (arc4random() % (to - from + 1))); //+1,result is [from to]; else is [from, to)!!!!!!!
}
@end
