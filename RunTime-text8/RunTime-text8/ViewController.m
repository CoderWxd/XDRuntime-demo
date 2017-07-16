//
//  ViewController.m
//  RunTime-text8
//
//  Created by 王晓栋 on 2017/7/16.
//  Copyright © 2017年 com.qinqin.www. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //获取方法名
    //入参: 方法名SEL
    //返回: 方法名chat
    const char *result1 =  sel_getName(@selector(method1));
    NSLog(@">>>>>result1=%@",[NSString stringWithUTF8String:result1]);
    //获取方法 id
    //入参: 属性方法名chat
    //返回: SEL
    SEL result2 = sel_getUid(result1);
    NSLog(@">>>>>result2=%@",NSStringFromSelector(result2));
    
    //判断方法是否相同
    //入参 方法1 方法2
    //返回 是否相同BOOL
    SEL res1 = @selector(method1);
    SEL res2 = @selector(method2);
    BOOL result3 = sel_isEqual(res1, res2);
    NSLog(@">>>>>>result3=%zd",result3);
    
    //判断选择器是否有效
    //入参: SEL
    //返回: BOOL
    BOOL result4 = sel_isMapped(result2);
    NSLog(@">>>>>>result4=%zd",result4);
    
    //注册方法
    //入参:要注册的方法名
    //返回:返回方法名选择器
    //在系统中注册一个方法，将方法名映射到一个选择器，并返回这个选择器
    SEL result5 = sel_registerName("method1");
    NSLog(@">>>>>>result5=%@",NSStringFromSelector(result5));
}
-(void)method1{}
-(void)method2{}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
