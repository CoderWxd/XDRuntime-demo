//
//  ViewController.m
//  RunTime-text6
//
//  Created by 王晓栋 on 2017/7/6.
//  Copyright © 2017年 com.qinqin.www. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 方法交换
    Method method1 =  class_getInstanceMethod([self class], @selector(method1));
    Method method2 =  class_getInstanceMethod([self class], @selector(method2));
    Method method3 =  class_getInstanceMethod([self class], @selector(method3));
    method_setImplementation(method1, (IMP)method_getImplementation(method2));
    [self method1];
    
    
    
    method_exchangeImplementations(method1, method2);
    [self method1];
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)method1{
    NSLog(@"method1");
}
- (void)method2{
    NSLog(@"method2");
}
- (void)method3{
    NSLog(@"method3");
}


@end
