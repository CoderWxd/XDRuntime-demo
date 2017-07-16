//
//  ViewController.m
//  RunTime-text1
//
//  Created by 王晓栋 on 2017/6/15.
//  Copyright © 2017年 com.qinqin.www. All rights reserved.
//

#import "ViewController.h"
#import "ViewController+XDExtension.h"
#import <objc/runtime.h>

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString *property1;
    NSString *property2;
    NSArray  *property3;
}
@property(nonatomic,strong)NSString *property4;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // class获取--整个成员变量列表
    /**
     * 获取所有私有成员变量列表
     * 获取的私有变量的名和定义的一样
     * 获取的属性的名前面加下划线
     */
    unsigned int copyIvarListCount;
    Ivar *ivars = class_copyIvarList([ViewController class], &copyIvarListCount);
    for (NSInteger i = 0;  i < copyIvarListCount; i++) {
        const char *ivarName = ivar_getName(ivars[i]);
       const char *ivarType =  ivar_getTypeEncoding(ivars[i]);
        NSLog(@">>>>>>>class_copyIvarList:%@==%@",[NSString stringWithUTF8String:ivarName],[NSString stringWithUTF8String:ivarType]);
    }
    free(ivars);//释放
    
    // Class-获取整个属性列表(只获取属性,不获取变量)
    /**
     *  获取的属性名和定义的一样,不加下划线
     *
     */
    unsigned int copyIvarListCount1;
    objc_property_t *propertys = class_copyPropertyList([ViewController class], &copyIvarListCount1);
    for (NSInteger i = 0; i < copyIvarListCount1; i++) {
        
        objc_property_t property = propertys[i];
        const char *properyName = property_getName(property);
        NSLog(@">>>>>>class_copyPropertyList:%@",[NSString stringWithUTF8String:properyName]);
    }
    free(propertys);//释放
    
    //class获取--获取整个类的实例方法的方法列表
    /**
     *  获取所有的实例方法,不包括静态方法
     *  不获取父类的方法,
     *  隐式的 set get 方法也能获取
     */
    unsigned int copyMethodList;
    Method *methods = class_copyMethodList([ViewController class], &copyMethodList);
    for (NSInteger i = 0; i< copyMethodList; i++) {
        Method method = methods[i];
         SEL methodName = method_getName(method);
        NSLog(@">>>>>>class_copyMethodList=%@",NSStringFromSelector(methodName));
//        method_getTypeEncoding(<#Method m#>)
//        method_getReturnType(<#Method m#>, <#char *dst#>, <#size_t dst_len#>)
    }
    free(methods);//释放
    
    NSLog(@"\n");
    
    
    //Class-获取所有的协议
    /**
     * 1.class_copyProtocolList 第一个参数:添加协议的类,第二个:协议对象
     * 2.获得协议里的具体内容
     */
    unsigned int copyProtocolListCount = 0;
    Protocol *__unsafe_unretained *protocols = class_copyProtocolList([ViewController class],&copyProtocolListCount);
    for (NSInteger i = 0; i < copyProtocolListCount; i++) {
        Protocol *pro = protocols[i];
         const char *proName = protocol_getName(pro);
        BOOL isEqualPro = protocol_isEqual(pro, pro);
            NSLog(@">>>>>class_copyProtocolList=%@,isEqualPro=%d",[NSString stringWithUTF8String:proName],isEqualPro);
    }
    free(protocols);//释放
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{return 0;}

- (void)method{
    NSLog(@"method");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
