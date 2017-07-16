//
//  ViewController.m
//  RunTime-text3
//
//  Created by 王晓栋 on 2017/7/5.
//  Copyright © 2017年 com.qinqin.www. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>

@interface ViewController ()
//<UITableViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self method0];
    BOOL result0 = class_replaceMethod([self class], @selector(method0),(IMP)method1 , NULL);
    NSLog(@">>>>>>>>0:%@",@(result0));
    
    //添加协议
    BOOL result1 = class_addProtocol([self class], NSProtocolFromString(@"UITableViewDelegate"));
    NSLog(@">>>>>>>>1:%@",@(result1));
    
    //添加方法
    BOOL result2 = class_addMethod([self class], @selector(method2222), NULL, NULL);
    NSLog(@">>>>>>>>2:%@",@(result2));
    
   BOOL result3 = class_isMetaClass([self class]);
    NSLog(@">>>>>>>>3:%@",@(result3));
    int version = 8;
   class_setVersion([self class], version);
    int result4 = class_getVersion([self class]);
    NSLog(@">>>>>>>>4:%@",@(result4));
    
    //协议是否遵守
    BOOL result5 = class_conformsToProtocol([self class], NSProtocolFromString(@"UITableViewDelegate"));
    BOOL result6 =  class_conformsToProtocol([self class], NSProtocolFromString(@"UITableViewDataSource"));
    NSLog(@">>>>>>>>5:%@",@(result5));
    NSLog(@">>>>>>>>6:%@",@(result6));
    
    //方法是否执行
    BOOL result7 = class_respondsToSelector([self class], @selector(method0));
    BOOL result8 = class_respondsToSelector([self class], @selector(method2));
    NSLog(@">>>>>>>>7:%@",@(result7));
    NSLog(@">>>>>>>>8:%@",@(result8));
    
    

    
}

- (void)method0{
    NSLog(@"method0");
}

void method1(){
    NSLog(@"method1");
}


+ (void)method2{
    NSLog(@"method2");
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
