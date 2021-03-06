//
//  UserInfoStorage.m
//  ManLiao
//
//  Created by Manloo on 15/12/4.
//  Copyright © 2015年 manloo. All rights reserved.
//

#import "UserInfoStorage.h"
#import "JQEncrypt.h"
static NSString * const username = @"username";
static NSString * const password = @"password";
static NSString * const userinfo = @"userinfo";
static NSString * const CFBundleVersion = @"CFBundleVersion";
static NSString * const payPasswordKey = @"payPassword";
static NSString * const payPasswordUserKey = @"payPasswordToUser";
static NSString * const gestureLockKey = @"gestureLock";
static NSString * const gestureLockUserKey = @"gestureLockToUser";

static NSString * const isOpenGestureLockkey = @"isOpenGestureLock";
static NSString * const isOpenGestureLockUserkey = @"isOpenGestureLockToUser";

static NSString * const isOpenFingerprintPasswordKey = @"isOpenFingerprintPassword";
static NSString * const isOpenFingerprintPasswordUserKey = @"isOpenFingerprintPasswordToUser";


@implementation UserInfoStorage

+ (void)saveUserName:(NSString *)userName
{
    NSString *enctyptString = [JQEncrypt doEncryptStr:userName];
    NSLog(@"加密后：%@",enctyptString);
    [self saveValue:enctyptString forKey:username];
}

+ (NSString *)userName
{
    NSString *enctyptString = [self valueWithKey:username];
    NSLog(@"解密前：%@",enctyptString);
    NSString *decEn = [JQEncrypt doDecEncryptStr:enctyptString];
    return decEn;
}
/**
 *  获取登录密码
 *
 *  @return password
 */
+ (NSString *)password
{
    NSString *enctyptString = [self valueWithKey:password];
    NSString *decEn = [JQEncrypt doDecEncryptStr:enctyptString];
    
    return decEn;
}

/**
 *  保存登录密码
 *
 *  @param pwd 登录密码
 */
+ (void)savePassword:(NSString *)pwd
{
    NSString *enctyptString = [JQEncrypt doEncryptStr:pwd];
    [self saveValue:enctyptString forKey:password];
}

/**
 *  保存登录用户信息
 *
 *  @param userinfoDic 登录用户信息
 */
+ (void)saveUserInfo:(NSDictionary *)userinfoDic
{
    [self saveValue:userinfoDic forKey:userinfo];
}
/**
 *  获取已登录用户信息
 *
 */
+ (NSDictionary*)userInfo
{
    return [self valueWithKey:userinfo];
}
/**
 *  清除用户登录个人信息的保存记录
 *
 */
+ (void)clearLoginInfo
{
    [self saveValue:@"" forKey:userinfo];
}

/**
 *  清除登录账号和密码的保存记录
 *
 */
+ (void)clearLoginUser
{
    [self saveValue:@"" forKey:username];
    [self saveValue:@"" forKey:password];
}


+ (NSString *)localVersion
{
    return [self valueWithKey:CFBundleVersion];
}

+ (void)saveVersion:(NSString *)currentVersion
{
    [self saveValue:currentVersion forKey:CFBundleVersion];
}

/**
 * 保存支付密码
 * @param payPassword 支付密码
 */
+ (void)savePayPassword:(NSString *)payPassword
{
    NSString *enctyptString = [JQEncrypt doEncryptStr:payPassword];
    NSString *toUser = [JQEncrypt doEncryptStr:[self userName]?:@""];
    [self saveValue:enctyptString forKey:payPasswordKey];
    [self saveValue:toUser forKey:payPasswordUserKey];
}
/**
 * 获取本地储存支付密码
 */
+ (NSString *)payPassword
{
    NSString *enctyptString = [self valueWithKey:payPasswordKey];
    NSString *decEn = [JQEncrypt doDecEncryptStr:enctyptString];
    NSString *formUserEnctypt = [self valueWithKey:payPasswordUserKey];
    NSString *formUser = [JQEncrypt doDecEncryptStr:formUserEnctypt];
    if ([formUser isEqualToString:[self userName]]) {
        return decEn;
    }else
    {
        return nil;
    }
}

/**
 * 保存手势密码
 * @param gestureLock 手势密码
 */
+ (void)saveGestureLock:(NSString *)gestureLock
{
    NSString *enctyptString = [JQEncrypt doEncryptStr:gestureLock];
    NSString *toUser = [JQEncrypt doEncryptStr:[self userName]?:@""];
    [self saveValue:enctyptString forKey:gestureLockKey];
    [self saveValue:toUser forKey:gestureLockUserKey];
}
/**
 * 获取本地储存手势密码
 */
+ (NSString *)gestureLock
{
    NSString *enctyptString = [self valueWithKey:gestureLockKey];
    
    NSString *decEn = [JQEncrypt doDecEncryptStr:enctyptString];
    
    NSString *formUserEnctypt = [self valueWithKey:gestureLockUserKey];
    NSString *formUser = [JQEncrypt doDecEncryptStr:formUserEnctypt];
    
    if ([formUser isEqualToString:[self userName]]) {
        return decEn;
    }else
    {
        return nil;
    }
}

/**
 * 是否开启手势密码
 * @param isOpen 是否开启
 */
+ (void)saveIsOpenGestureLock:(BOOL)isOpen 
{
    NSString *enctyptString = [JQEncrypt doEncryptStr:isOpen?@"1":@"0"];
    NSString *toUser = [JQEncrypt doEncryptStr:[self userName]?:@""];
    [self saveValue:enctyptString forKey:isOpenGestureLockkey];
    [self saveValue:toUser forKey:isOpenGestureLockUserkey];
}
/**
 * 获取是否开启手势密码
 */
+ (BOOL)isOpenGestureLock
{
    NSString *enctyptString = [self valueWithKey:isOpenGestureLockkey];
    NSString *decEn = [JQEncrypt doDecEncryptStr:enctyptString];
    
    NSString *formUserEnctypt = [self valueWithKey:isOpenGestureLockUserkey];
    NSString *formUser = [JQEncrypt doDecEncryptStr:formUserEnctypt];
    
    if ([formUser isEqualToString:[self userName]]) {
        return [decEn isEqualToString:@"1"];
    }else
    {
        return 0;
    }
    
}

/**
 * 是否开启指纹密码
 * @param isOpen 是否开启
 */
+ (void)saveIsOpenFingerprintPassword:(BOOL)isOpen
{
    NSString *enctyptString = [JQEncrypt doEncryptStr:isOpen?@"1":@"0"];
    NSString *toUser = [JQEncrypt doEncryptStr:[self userName]?:@""];
    [self saveValue:enctyptString forKey:isOpenFingerprintPasswordKey];
    [self saveValue:toUser forKey:isOpenFingerprintPasswordUserKey];
    
}
/**
 * 获取是否开启指纹密码
 */
+ (BOOL)isOpenFingerprintPassword
{
    NSString *enctyptString = [self valueWithKey:isOpenFingerprintPasswordKey];
    NSString *decEn = [JQEncrypt doDecEncryptStr:enctyptString];
    
    NSString *formUserEnctypt = [self valueWithKey:isOpenFingerprintPasswordUserKey];
    NSString *formUser = [JQEncrypt doDecEncryptStr:formUserEnctypt];
    
    if ([formUser isEqualToString:[self userName]]) {
        return [decEn isEqualToString:@"1"];
    }else
    {
        return 0;
    }
}


@end
