//
//  ViewController.m
//  RunTime-text0
//
//  Created by 王晓栋 on 2017/6/14.
//  Copyright © 2017年 com.qinqin.www. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>

@interface ViewController ()
@property(nonatomic,strong)NSString *property0;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];    
    //获取类名
    //入参:类Class
    //返回:类名char数组
    const char *result0 = class_getName([ViewController class]);
    NSLog(@">>>>>>0=%@",[NSString stringWithUTF8String:result0]);
    
    //获取父类
    //入参:类Class
    //返回:类Class
     Class result1 = class_getSuperclass([ViewController class]);
    NSLog(@">>>>>>1=%@",result1);
    
    //获取实例大小
    //入参:类Class
    //返回:大小size_t
    size_t result2 = class_getInstanceSize([ViewController class]);
    NSLog(@">>>>>>2=%zu",result2);
    
    //获取类中指定名称实例成员变量的信息
    //入参:类Class,变量名
    //返回:变量信息Ivar
    //* 1.实例变量是指变量不是属性,例如某类有个属性为:name 那么它对应的实例变量就是 _name
    //* 2.这个方法可以获取属性的变量,也可以获取私有变量
    //* 3.如果获取的变量为空,那么 ivar_getName() 和 ivar_getTypeEncoding() 获取的值为空,name
    //[NSString stringWithUTF8String:ivarName] 执行崩溃
    const char *result3 = [@"property0" UTF8String];
    Ivar result4 = class_getInstanceVariable([ViewController class], result3);
    NSLog(@">>>>>>4=%@",result4);
    
    const char *result10 = [@"_property0" UTF8String];
    Ivar result11 = class_getInstanceVariable([ViewController class], result10);
    NSLog(@">>>>>>4==%@",[NSString stringWithUTF8String:ivar_getName(result11)]);
    
    //获取指定的属性
    //入参:类Class,属性名char数组
    // 返回:属性objc_property_t
    // * 1.属性不是变量,此方法只能获取属性
    // * 2.如果属性不存在那么返回的结构体为0(可以参考下面的判断)
    // * 3.属性不存在获取property_getName 和 property_getAttributes 会崩溃
    const char *result5 = [@"property0" UTF8String];
    objc_property_t result_5 = class_getProperty([ViewController class], result5);
    NSLog(@">>>>>>5=%@",[NSString stringWithUTF8String:property_getName(result_5)]);
    
    //获取方法实现
    //入参:类Class,方法名SEL
    //返回:方法实现IMP
    IMP result6 = class_getMethodImplementation([ViewController class], @selector(method1));
    result6();
    
    //获取方法实现
    //入参:类Class,方法名SEL
    //返回:方法实现IMP
    IMP result7 = class_getMethodImplementation_stret([ViewController class], @selector(method2));
    result7();
    
    //获取类方法
    //入参:
    //返回:
     Method result8 = class_getClassMethod([ViewController class], @selector(method1));
    NSLog(@">>>>>8=%@",result8);
    
    
    
}

- (void)method1{
    NSLog(@"method1");
}
- (void)method2{
    NSLog(@"method2");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
