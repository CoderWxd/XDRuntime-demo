//
//  ViewController.m
//  RunTime-text4
//
//  Created by 王晓栋 on 2017/7/5.
//  Copyright © 2017年 com.qinqin.www. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>

@interface ViewController ()
{
    NSString *property1;
    NSString *property2;
    NSString *property3;
}
@property(nonatomic,strong)NSString *property4;
@property(nonatomic,strong)NSString *property5;
@property(nonatomic,strong)NSString *property6;
@property(nonatomic,strong)UIView *redView;
@property(nonatomic,assign)NSInteger count;

@end

@implementation ViewController


//编码值 	含意
//c 	代表char类型
//i 	代表int类型
//s 	代表short类型
//l 	代表long类型，在64位处理器上也是按照32位处理
//q 	代表long long类型
//C 	代表unsigned char类型
//I 	代表unsigned int类型
//S 	代表unsigned short类型
//L 	代表unsigned long类型
//Q 	代表unsigned long long类型
//f 	代表float类型
//d 	代表double类型
//B 	代表C++中的bool或者C99中的_Bool
//v 	代表void类型
//* 	代表char *类型
//@ 	代表对象类型
//# 	代表类对象 (Class)
//: 	代表方法selector (SEL)
//[array type] 	代表array
//{name=type…} 	代表结构体
//(name=type…) 	代表union
//bnum 	A bit field of num bits
//^type 	A pointer to type
//? 	An unknown type (among other things, this code is used for function pointers)


- (void)viewDidLoad {
    [super viewDidLoad];
    //class 获取整个成员变量的列表
    /**
     * 1.获取所有私有变量和成员变量
     * 2.获取的私有变量和定义的变量名一样
     * 3.获取的成员变量自动加下划线
     */
    unsigned int outCount;
    Ivar *ivars = class_copyIvarList([self class], &outCount);
    for (NSInteger i = 0 ; i < outCount; i++) {
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        ptrdiff_t pp = ivar_getOffset(ivar);
        const char *encoding = ivar_getTypeEncoding(ivar);
        NSLog(@"Ivar>>>>name=%@,pp=%td,encoding=%@",[NSString stringWithUTF8String:name],pp,[NSString stringWithUTF8String:encoding]);
    }
    free(ivars);
    /**
     2017-07-05 19:24:00.051 RunTime-text4[7147:217017] name=property1,pp=760,encoding=@"NSString"
     2017-07-05 19:24:00.051 RunTime-text4[7147:217017] name=property2,pp=768,encoding=@"NSString"
     2017-07-05 19:24:00.052 RunTime-text4[7147:217017] name=property3,pp=776,encoding=@"NSString"
     2017-07-05 19:24:00.052 RunTime-text4[7147:217017] name=_property4,pp=784,encoding=@"NSString"
     2017-07-05 19:24:00.052 RunTime-text4[7147:217017] name=_property5,pp=792,encoding=@"NSString"
     2017-07-05 19:24:00.052 RunTime-text4[7147:217017] name=_property6,pp=800,encoding=@"NSString"
     2017-07-05 19:24:00.052 RunTime-text4[7147:217017] name=_redView,pp=808,encoding=@"UIView"
     2017-07-05 19:24:00.052 RunTime-text4[7147:217017] name=_count,pp=816,encoding=q
     */
    
    
    //class 获取属性列表
    unsigned int propertyOutCount;
    objc_property_t *propertys = class_copyPropertyList([self class], &propertyOutCount);
    for (NSInteger i = 0; i < propertyOutCount; i ++) {
        objc_property_t property = propertys[i];
        const char *name = property_getName(property);
        const char *attributes = property_getAttributes(property);
        NSLog(@"property>>>>>>name=%@,attributes=%@",[NSString stringWithUTF8String:name],[NSString stringWithUTF8String:attributes]);

//        const char *attributeName = nil;
//        char *attValue = property_copyAttributeValue(property, &attributeName);
//        NSLog(@"property>>>>>>name=%@,attributes=%@,attValue=%@,attributeName=%@",[NSString stringWithUTF8String:name],[NSString stringWithUTF8String:attributes],[NSString stringWithUTF8String:attValue],[NSString stringWithUTF8String:attributeName]);
    }
    /**
     2017-07-05 20:08:04.934 RunTime-text4[7926:247624] property>>>>>>name=property4,attributes=T@"NSString",&,N,V_property4
     2017-07-05 20:08:04.934 RunTime-text4[7926:247624] property>>>>>>name=property5,attributes=T@"NSString",&,N,V_property5
     2017-07-05 20:08:04.934 RunTime-text4[7926:247624] property>>>>>>name=property6,attributes=T@"NSString",&,N,V_property6
     2017-07-05 20:08:04.935 RunTime-text4[7926:247624] property>>>>>>name=redView,attributes=T@"UIView",&,N,V_redView
     2017-07-05 20:08:04.935 RunTime-text4[7926:247624] property>>>>>>name=count,attributes=Tq,N,V_count

     */
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
