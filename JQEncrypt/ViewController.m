//
//  ViewController.m
//  JQEncrypt
//
//  Created by life on 2020/8/13.
//  Copyright © 2020 life. All rights reserved.
//

#import "ViewController.h"
#import "UserInfoStorage.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //加密并保存用户名到本地
    [UserInfoStorage saveUserName:@"zjq123"];
    
    NSLog(@"获取保存到本地的用户名：%@",[UserInfoStorage userName]);
    
    // Do any additional setup after loading the view.
}


@end
