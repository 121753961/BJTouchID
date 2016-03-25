//
//  BJTouchIDTool.m
//  BJTouchID
//
//  Created by KuangBing on 16/3/25.
//  Copyright © 2016年 KuangBing. All rights reserved.
//

#import "BJTouchIDTool.h"

@implementation BJTouchIDTool

+(instancetype)sharedInstance{
    static BJTouchIDTool *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[BJTouchIDTool alloc] init];
    });
    return instance;
}


-(void)evaluatePolicy:(NSString *)localizedReason fallbackTitle:(NSString *)title SuccesResult:(void (^)())backSucces FailureResult:(TouchIdFailureBack)backFailure{
    
    // 初始化上下对象
    LAContext *context = [[LAContext alloc]init];
    
    context.localizedFallbackTitle = title;
    
    // 错误对象
    NSError *error = nil;
    
    //首先使用 canEvaluatePolicy 判断设备支持状态
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:localizedReason reply:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                //验证成功，返回主线程处理
                NSLog(@"验证成功");
                dispatch_async(dispatch_get_main_queue(), ^{
                    backSucces(success);
                });
                
            } else {
                NSLog(@"验证失败");
                NSLog(@"%@",error.localizedDescription);
                dispatch_async(dispatch_get_main_queue(), ^{
                    backFailure(error.code);
                });
            }
        }];
    }else{
        NSLog(@"不支持指纹识别，LOG出错误详情");
        NSLog(@"%@",error.localizedDescription);
        dispatch_async(dispatch_get_main_queue(), ^{
            backFailure(error.code);
        });
    }
}


@end
