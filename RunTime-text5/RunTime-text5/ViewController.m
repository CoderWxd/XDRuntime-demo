//
//  ViewController.m
//  RunTime-text5
//
//  Created by 王晓栋 on 2017/7/5.
//  Copyright © 2017年 com.qinqin.www. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    Method m = class_getInstanceMethod([self class], @selector(parameter1:parameter2:parameter3:));
    //获取方法名
    SEL sel = method_getName(m);
    NSLog(@">>>>sel=%@",NSStringFromSelector(sel));
    //2017-07-05 20:25:13.777 RunTime-text5[8192:257243] sel=parameter1:parameter2:parameter3:
    

    //获取方法实现
    //入参: objc_property_t，attributeName属性的属性键
    //返回: 属性的属性值char数组

//    * Returns the implementation of a method.
//    *
//    * @param m The method to inspect.
//    *
//    * @return A function pointer of type IMP.
//    */
    IMP result2 = method_getImplementation(m);
    
    //获取参数个数
    //入参: 方法描述结构体Method
    //返回: 属性的个数
    unsigned int result3 = method_getNumberOfArguments(m);
    NSLog(@">>>>result3=%d",result3);
    //2017-07-05 21:23:09.829 RunTime-text5[9096:290129] >>>>result3=5
    for (unsigned int i =0 ; i < result3; i++) {
        char result5[1024] = {};
        //获取参数的属性参数
        //入参: 方法描述结构体Method，返回值的容器char数组，容器大小。返回值的类型字符串会被copy到第二个参数里。
        //返回: void
        method_getArgumentType(result3, i, result5, 1024);
        NSLog(@">>>>>>>>4:%s",result3);
    }
    
    
    //获取方法描述
    // 入参: 获取方法描述结构体method
    // 返回: 方法描述结构体objc_method_description
    // Defines a method
    //    struct objc_method_description {
    //        SEL name;               /**< The name of the method */
    //        char *types;            /**< The types of the method arguments */
    //    };
  struct objc_method_description result5 = *method_getDescription(m);
    NSLog(@">>>>>>name=%@,types=%@",NSStringFromSelector(result5.name),[NSString stringWithUTF8String:result5.types]);
    //2017-07-05 20:50:44.509 RunTime-text5[8689:272278] >>>>>>name=parameter1:parameter2:parameter3:,types=@40@0:8@16@24@32

    // 获取返回类型
    //入参: 方法描述结构体Method 返回值的容器char数组，容器大小。返回值的类型字符串会被copy到第二个参数里。
    //返回: 方法的类型
    char result6[1024] ={};
    method_getReturnType(m, result6, 1024);
    NSLog(@">>>>result6=%s",result6);
    
}
-(NSArray *)parameter1:(NSString *)type1 parameter2:(NSString *)type2 parameter3:(NSString *)type3{
    NSLog(@"parameter1");
    return @[];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
