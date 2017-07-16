//
//  ViewController.m
//  RunTime-text2
//
//  Created by 王晓栋 on 2017/6/20.
//  Copyright © 2017年 com.qinqin.www. All rights reserved.
//

#import "ViewController.h"
#import <objc/message.h>

@interface ViewController ()<UITabBarDelegate,UITableViewDelegate>
{
    NSString *property0;
    NSString *property1;
}
@property(nonatomic,strong)NSString *property2;

@end

@implementation ViewController


// getter 方法
NSString *attribute0Getter(id classInstance,SEL _cmd){
    //获取变量,如果获取不到,就自己创建
    Ivar ivar = class_getInstanceVariable([classInstance class], "_attribute0");
    return object_getIvar([classInstance class], ivar);
    
}
// set 方法
void attribute0Setter(id classInstance,NSString *newName){
    //获取变量,如果没有说明不存在
    Ivar ivar = class_getInstanceVariable([classInstance class], "_attribute0");
    id oldName = object_getIvar(classInstance, ivar);
    if (oldName !=newName) object_setIvar(classInstance, ivar, [newName copy]);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加--为动态创建类添加变量
    /**
     * 1.只能给动态创建的类添加变量,用 objc_allocateClassPair 创建类
     * 2.添加变量只能在 objc_allocateClassPair 和 class_getInstanceVariable 之间添加才有用
     *
     */
    Class creatClass0 = objc_allocateClassPair([NSObject class], "createClass0", 0);
    class_addIvar(creatClass0, "_attribute0", sizeof(NSString *), log(sizeof(NSString*)),"i");
    Ivar ivar = class_getInstanceVariable(creatClass0, "_attribute0");//获取变量,如果获取不到说明不存在
    NSLog(@">>>>>>>0:class_getInstanceVariable=%@",[NSString stringWithUTF8String:ivar_getName(ivar)]);
    objc_registerClassPair(creatClass0);
    NSLog(@"\n");
    
    //添加--为动态创建的类添加变量然后添加属性,类和变量和属性都是动态创建的
    
    objc_property_attribute_t type2 = {"T","@\"NSString\""};
    objc_property_attribute_t ownership2 = {"C",""};
    objc_property_attribute_t backingIvar2 = {"V","_attribute0"};
    objc_property_attribute_t attrs2[] = {type2,ownership2,backingIvar2};
    class_addProperty(creatClass0, "_attribute0", attrs2, 3);
    SEL getter = NSSelectorFromString(@"attribute0Getter");
    SEL setter = NSSelectorFromString(@"attribute0Setter");
   BOOL succ0 = class_addMethod(creatClass0, getter,(IMP)attribute0Getter, "@@:");
   BOOL succ1 = class_addMethod(creatClass0, setter,(IMP)attribute0Setter, "@@:");
    NSLog(@">>>>>>>1:class_addMethod=%zd ,2=%zd",@(succ0),@(succ1));
    
    id idclass = [[creatClass0 alloc]init];
    NSLog(@">>>>>>>2:%@",[idclass performSelector:getter withObject:nil]);
    [idclass performSelector:getter withObject:@"为动态添加类,先添加变量再添加属性"];
    NSLog(@">>>>>>>3:%@",[idclass performSelector:getter withObject:nil]);
    
    
    //class 获取整个类的实例方法的列表
    unsigned int class_copyMethodCount = 0;
    Method *methods = class_copyMethodList([self class], &class_copyMethodCount);
    for (NSInteger i = 0 ; i < class_copyMethodCount; i++) {
        Method method = methods[i];
        SEL name  = method_getName(method);
        NSLog(@">>>>>>>class_copyMethodList:%@",NSStringFromSelector(name));
    }
    free(methods);//释放
    NSLog(@"\n");
    
    
    //添加 - 协议
    /**
     * class_copyProtocolList 1.要添加的类 2:协议对象
     * 获得协议列表
     */
    unsigned int class_copyProtocolCount = 0;
    Protocol *__unsafe_unretained *protocols =  class_copyProtocolList([self class],&class_copyProtocolCount);
    for (NSInteger i = 0 ; i < class_copyProtocolCount; i++) {
        Protocol *protocol = protocols[i];
        const char *name = protocol_getName(protocol);
        objc_property_t property = protocol_getProperty(protocol, "separatorStyle", YES, YES);
        NSLog(@">>>>>>>>class_copyProtocolList;%@",[NSString stringWithUTF8String:name]);
    }
    free(protocols);//释放
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{return 0;}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
