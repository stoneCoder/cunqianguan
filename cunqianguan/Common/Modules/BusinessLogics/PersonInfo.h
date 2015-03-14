//
//  CCUserInfo.h
//  Chat
//
//  Created by 怡龙谷 on 14/11/24.
//  Copyright (c) 2014年 Huang Xiu Yong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonInfo : NSObject
DEFINE_SINGLETON_FOR_HEADER(PersonInfo)

@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * userId;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * photo;
@property (nonatomic, retain) NSString * consignee;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSString * qq;
@property (nonatomic, retain) NSString * zipCode;
@property (nonatomic, retain) NSString * phone;

@property (nonatomic, assign) NSInteger collectionCount;
@property (nonatomic, assign) NSInteger level;
@property (nonatomic, assign) NSInteger userExp;
@property (nonatomic, assign) NSInteger nextUserExp;
@property (nonatomic, assign) CGFloat cash;
@property (nonatomic, assign) NSInteger pointTb;
@property (nonatomic, assign) NSInteger pointSite;
@property (nonatomic, assign) CGFloat cashAll;
@property (nonatomic, assign) NSInteger messageCount;
@property (nonatomic, assign) NSInteger pointTbTo;
@property (nonatomic, assign) NSInteger cashTo;
@property (nonatomic, assign) BOOL isBindAli;
@property (nonatomic, assign) BOOL isBindQQ;
@property (nonatomic, assign) BOOL isBindSina;
@property (nonatomic, assign) BOOL isSignToday;


-(void)loginSuccessWith:(NSDictionary *)dic;
-(void)loginOut;
-(void)loadUserData;
-(void)saveUserData;

-(void)getUserInfo:(NSString *)userName withPwd:(NSString *)pwd success:(void (^)(id json))success failure:(void (^)(id json))failure;
-(void)getAvaterWithId:(NSString *)userId success:(void (^)(id json))success failure:(void (^)(id json))failure;

-(void)isLoginWithcompletion:(void (^)(BOOL flag))completion;
-(void)isLoginWithPresent:(void (^)(BOOL flag))completion WithType:(BOOL)presentType;


- (BOOL)isNewTrace;
- (void)saveTraceFlag:(NSString *)flag;
@end
