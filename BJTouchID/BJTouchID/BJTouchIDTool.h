//
//  BJTouchIDTool.h
//  BJTouchID
//
//  Created by KuangBing on 16/3/25.
//  Copyright © 2016年 KuangBing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LocalAuthentication/LocalAuthentication.h>

/*
 * LAErrorSystemCancel        切换到其他APP
 * LAErrorUserCancel          用户取消验证Touch ID
 * LAErrorTouchIDNotEnrolled  TouchID is not enrolled
 * LAErrorUserFallback        用户选择输入密码
 */

typedef NS_ENUM(NSInteger, TouchIdValidationResult)
{
    kTouchIdSystemCancel,   // 切换到其他APP
    kTouchIdUserCancel,     // 用户取消验证Touch ID
    kTouchIdUserFallback,   // 用户点击其他按钮
    kTouchIdNotEnrolled,    // 不支持TouchId机型
    kTouchIdPasscodeNotSet, // 没有设置验证密码
    kTouchIdOther           // 其他
};//这个枚举并没有用到,可将它删除，也可以自定义替换Block返回

@protocol BJTouchIdDelegate <NSObject>

@required

/**
 *  TouchID验证成功
 *  Authentication Successul
 */
- (void)BJTouchIDAuthorizeSuccess;


/**
 *  在TouchID对话框中点击输入密码按钮
 *
 *  User tapped the fallback button
 */
- (void)BJTouchIDAuthorizeErrorUserFallback;

/**
 *  TouchID验证失败
 *
 *  Authentication Failure
 */
- (void)WJTouchIDAuthorizeFailure;


@optional
/**
 *  取消TouchID验证 (用户点击了取消)
 *
 *  Authentication was canceled by user (e.g. tapped Cancel button).
 */
- (void)WJTouchIDAuthorizeErrorUserCancel;



@end


@interface BJTouchIDTool : NSObject

typedef void(^TouchIdFailureBack)(LAError result);

+(instancetype)sharedInstance;


/**
 *  TouchId 验证
 *
 *  @param localizedReason TouchId信息
 *  @param title           验证错误按钮title
 *  @param backSucces      成功返回Block
 *  @param backFailure     失败返回Block
 */
- (void)evaluatePolicy:(NSString *)localizedReason
         fallbackTitle:(NSString *)title
          SuccesResult:(void(^)())backSucces
         FailureResult:(TouchIdFailureBack)backFailure;




@end
