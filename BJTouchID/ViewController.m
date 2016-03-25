//
//  ViewController.m
//  BJTouchID
//
//  Created by KuangBing on 16/3/25.
//  Copyright © 2016年 KuangBing. All rights reserved.
//

#import "ViewController.h"
#import "BJTouchIDTool.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[BJTouchIDTool sharedInstance]evaluatePolicy:@"请将手指放上Home键" fallbackTitle:@"输入密码" SuccesResult:^{
        NSLog(@"succes");
    } FailureResult:^(LAError result) {
        NSLog(@"%zd",result);
        switch (result) {
            case LAErrorSystemCancel:
            {
                NSLog(@"切换到其他APP");
                break;
            }
            case LAErrorUserCancel:
            {
                NSLog(@"用户取消验证Touch ID");
                
                break;
            }
            case LAErrorTouchIDNotEnrolled:
            {
                NSLog(@"TouchID is not enrolled");
                break;
            }
            case LAErrorUserFallback:
            {
                
                NSLog(@"用户选择输入密码");
                
                break;
            }
            default:
            {
                
                NSLog(@"其他情况");
                
                break;
            }
                
        }
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
