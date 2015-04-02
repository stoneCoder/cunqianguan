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

#import "SFHFKeychainUtils.h"


#define SERVICE_NAME @"baoxianqi"
@implementation PersonInfo
DEFINE_SINGLETON_FOR_CLASS(PersonInfo)

-(void)loadUserData{
    // 存储在Library路径下，文件名为001.dat。不要取有意义的文件名。
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:kCryptFile];
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:kCryptFilePath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDictionary *dic;
    if (![fileManager fileExistsAtPath:filePath]) {
        if ([fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil]) {
            [fileManager createFileAtPath:filePath contents:nil attributes:nil];
        }
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
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:kCryptFile];
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
    NSError *error = nil;
    self.userId = [dic objectForKey:@"uid"];
    self.username = [dic objectForKey:@"username"];
    self.email = [dic objectForKey:@"email"];
    if ([SFHFKeychainUtils storeUsername:self.email andPassword:self.password forServiceName:SERVICE_NAME updateExisting:YES error:&error]) {
        [[NSUserDefaults standardUserDefaults] setObject:self.email forKey:@"email"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self saveUserData];
    } else {
        NSLog(@"%@", error);
    }
}

- (NSString*)getAccountPassword:(NSString*)userName
{
    NSError *error = nil;
    NSString *password = [SFHFKeychainUtils getPasswordForUsername:userName andServiceName:SERVICE_NAME error:&error];
    if (error) {
        NSLog(@"%@", error);
    }
    return password;
}

-(void)loginOut
{
    NSError *error = nil;
    if ([SFHFKeychainUtils deleteItemForUsername:self.email andServiceName:SERVICE_NAME error:&error]) {
        self.userId = nil;
        self.email = nil;
        self.username = nil;
        self.password = nil;
        self.cashAll = 0;
        self.pointSite = 0;
        self.pointTb = 0;
        [self saveUserData];
    } else {
        NSLog(@"%@", error);
    }
}

#pragma MARK - check isLogin
-(void)isLoginWithcompletion:(void (^)(BOOL flag))completion
{
    [self isLoginWithPresent:completion WithType:YES];
}
-(void)isLoginWithPresent:(void (^)(BOOL flag))completion WithType:(BOOL)presentType
{
    _password = [self getAccountPassword:self.email];
    if (_password && _password.length > 0) {
        completion(YES);
        return;
    }else
    {
        if (presentType) {
             LoginVC *loginVC = [[LoginVC alloc] init];
             loginVC.leftTitle = @"登录";
             BaseNC *nai = [[NSClassFromString(@"BaseNC") alloc] initWithRootViewController:loginVC];
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nai animated:YES completion:nil];
        }else
        {
           completion(NO);
        }
    }
}

-(void)presentNav:(UIViewController *)controller WithCompletion:(id)completion
{
    LoginVC *loginVC = [[LoginVC alloc] init];
    loginVC.leftTitle = @"登录";
    BaseNC *nai = [[NSClassFromString(@"BaseNC") alloc] initWithRootViewController:loginVC];
    [controller presentViewController:nai animated:YES completion:completion];
}

-(void)getUserInfo:(NSString *)userName withPwd:(NSString *)pwd success:(void (^)(id json))success failure:(void (^)(id json))failure
{
    NSString *url = @"getUserInfo";
    NSDictionary *dic = @{@"email":userName,@"password":pwd};
    
    [BaseConnect post:url Parameters:dic success:^(id json) {
        NSDictionary *dic = (NSDictionary *)json;
        if ([BaseConnect isSucceeded:json]) {
            NSDictionary *data = [dic objectForKey:@"data"];
            _consignee = [data objectForKey:@"consignee"];
            _location = [data objectForKey:@"location"];
            _qq = [data objectForKey:@"qq"];
            _zipCode = [data objectForKey:@"zip_code"];
            _phone = [data objectForKey:@"phone"];
            _collectionCount = [[data objectForKey:@"collection_count"] intValue];
            _level = [[data objectForKey:@"level"] intValue];
            _userExp = [[data objectForKey:@"exp"] intValue];
            _nextUserExp = [[data objectForKey:@"exp_next"] intValue];
            _cash = [[data objectForKey:@"cash"] floatValue];
            _pointTb = [[data objectForKey:@"point_tb"] integerValue];
            _pointSite = [[data objectForKey:@"point_site"] integerValue];
            _cashAll = [[data objectForKey:@"cash_all"] floatValue];
            _messageCount = [[data objectForKey:@"message_count"] integerValue];
            _orderCount = [[data objectForKey:@"order_count"] integerValue];
            _pointTbTo = [[data objectForKey:@"point_tb_to"] integerValue];
            _cashTo = [[data objectForKey:@"cash_to"] integerValue];
            _isBindAli = [[data objectForKey:@"isbind_tb"] boolValue];
            _isBindQQ = [[data objectForKey:@"isbind_qq"] boolValue];
            _isBindSina = [[data objectForKey:@"isbind_sina"] boolValue];
            [self saveUserData];
        }
         success(json);
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

#pragma mark -- 足迹相关
- (BOOL)isNewTrace
{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"newFoot"] boolValue];
}

- (void)saveTraceFlag:(NSString *)flag
{
    [[NSUserDefaults standardUserDefaults] setObject:flag forKey:@"newFoot"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
