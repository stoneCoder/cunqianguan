//
//  CCUserInfo.m
//  Chat
//
//  Created by 怡龙谷 on 14/11/24.
//  Copyright (c) 2014年 Huang Xiu Yong. All rights reserved.
//

#import "PersonInfo.h"
#import "RNDecryptor.h"
#import "RNEncryptor.h"
#import "SWJSON.h"
#import <objc/runtime.h>
#import "Constants.h"
#import "BaseNC.h"
#import "LoginVC.h"
#import "BaseConnect.h"
#import "BMAlert.h"


@implementation PersonInfo
DEFINE_SINGLETON_FOR_CLASS(PersonInfo)

-(void)loadUserData{
    // 存储在Library路径下，文件名为001.dat。不要取有意义的文件名。
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:kCryptFilePath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDictionary *dic;
    if (![fileManager fileExistsAtPath:filePath]) {
        [fileManager createFileAtPath:filePath contents:nil attributes:nil];
    }
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    NSError *err = nil;
    NSData *decryData = [RNDecryptor decryptData:data withSettings:kRNCryptorAES256Settings password:kCryptPwd error:&err];
    if (err) {
        NSLog(@"Decrypt error: %@", err);
    }else{
        dic = [decryData objectFromJSONData];
        [self setValuesForKeysWithDictionary:dic];
    }
}

-(void)saveUserData{
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:kCryptFilePath];
    NSError *err;
    NSDictionary *dic = [self dictionaryValue];
    NSData *encryData = [RNEncryptor encryptData:[dic JSONData] withSettings:kRNCryptorAES256Settings password:kCryptPwd error:&err];
    [encryData writeToFile:filePath atomically:YES];
    if (err) {
        NSLog(@"Encrypt error: %@", err);
    }
}

-(NSData *)transformToData:(NSDictionary *)dic
{
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:dic forKey:@"Some Key Value"];
    [archiver finishEncoding];
    return data;
}

- (NSDictionary *)dictionaryValue
{
    NSMutableArray *propertyKeys = [NSMutableArray array];
    Class currentClass = self.class;
    
    while ([currentClass superclass]) { // avoid printing NSObject's attributes
        unsigned int outCount, i;
        objc_property_t *properties = class_copyPropertyList(currentClass, &outCount);
        for (i = 0; i < outCount; i++) {
            objc_property_t property = properties[i];
            const char *propName = property_getName(property);
            if (propName) {
                NSString *propertyName = [NSString stringWithUTF8String:propName];
                [propertyKeys addObject:propertyName];
            }
        }
        free(properties);
        currentClass = [currentClass superclass];
    }
    return [self dictionaryWithValuesForKeys:propertyKeys];
}

#pragma mark - 缓存用户数据

-(void)loginSuccessWith:(NSDictionary *)dic
{
    self.userId = [dic objectForKey:@"uid"];
    self.username = [dic objectForKey:@"username"];
    self.email = [dic objectForKey:@"email"];
    [self saveUserData];
}

-(void)loginOut
{
    self.userId = @"";
    self.username = @"";
    self.password = @"";
    [self saveUserData];
}

#pragma MARK - check isLogin
-(void)isLoginWithcompletion:(void (^)(BOOL flag))completion
{
    [self isLoginWithPresent:completion WithType:YES];
}
-(void)isLoginWithPresent:(void (^)(BOOL flag))completion WithType:(BOOL)presentType
{
    [self loadUserData];
    if (_password && _password.length > 0) {
        completion(YES);
        return;
    }else
    {
        if (presentType) {
             BaseNC *nai = [[NSClassFromString(@"BaseNC") alloc] initWithRootViewController:[[NSClassFromString(@"LoginVC") alloc] init]];
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nai animated:YES completion:nil];
        }else
        {
           completion(NO);
        }
    }
}

-(void)getUserInfo:(NSString *)userName withPwd:(NSString *)pwd success:(void (^)(id json))success failure:(void (^)(id json))failure
{
    NSString *url = @"getUserInfo";
    NSDictionary *dic = @{@"email":userName,@"password":pwd};
    
    [BaseConnect post:url Parameters:dic success:^(id json) {
        success(json);
        NSDictionary *dic = (NSDictionary *)json;
        if ([BaseConnect isSucceeded:json]) {
            NSDictionary *data = [dic objectForKey:@"data"];
            _consignee = [data objectForKey:@"consignee"];
            _location = [data objectForKey:@"location"];
            _qq = [data objectForKey:@"qq"];
            _collectionCount = [[data objectForKey:@"collection_count"] integerValue];
            _level = [[data objectForKey:@"level"] integerValue];
            _userExp = [[data objectForKey:@"exp"] integerValue];
            _nextUserExp = [[data objectForKey:@"exp_next"] integerValue];
            _cash = [[data objectForKey:@"cash"] integerValue];
            _pointTb = [[data objectForKey:@"point_tb"] integerValue];
            _pointSite = [[data objectForKey:@"point_site"] integerValue];
            _cashAll = [[data objectForKey:@"cash_all"] integerValue];
            _messageCount = [[data objectForKey:@"message_count"] integerValue];
            _pointTbTo = [[data objectForKey:@"point_tb_to"] integerValue];
            _cashTo = [[data objectForKey:@"cash_to"] integerValue];
            _isBindAli = [[data objectForKey:@"isbind_tb"] boolValue];
            _isBindQQ = [[data objectForKey:@"isbind_qq"] boolValue];
            _isBindSina = [[data objectForKey:@"isbind_sina"] boolValue];
        }
    } failure:^(id json) {
        failure(json);
    } connectionError:^(NSError *error) {
        if (error) {
            failure(error);
        }else{
            [[BMAlert sharedBMAlert] alert:@"网络连接异常" cancle:^(DoAlertView *alertView) {
            } other:nil];
            ;
        }
    } withView:nil];
}

-(void)getAvaterWithId:(NSString *)userId success:(void (^)(id json))success failure:(void (^)(id json))failure
{
    NSString *url = @"getAvatar";
    NSDictionary *dic = @{@"uid":userId};
    
    [BaseConnect post:url Parameters:dic success:^(id json) {
        success(json);
        NSDictionary *dic = (NSDictionary *)json;
        if ([BaseConnect isSucceeded:json]) {
            NSDictionary *data = [dic objectForKey:@"data"];
            _photo = [data objectForKey:@"avatar"];
        }
    } failure:^(id json) {
        failure(json);
    } connectionError:^(NSError *error) {
        if (error) {
            failure(error);
        }else{
            [[BMAlert sharedBMAlert] alert:@"网络连接异常" cancle:^(DoAlertView *alertView) {
            } other:nil];
            ;
        }
    } withView:nil];
}

@end
