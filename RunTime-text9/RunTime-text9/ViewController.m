//
//  ViewController.m
//  RunTime-text9
//
//  Created by 王晓栋 on 2017/7/16.
//  Copyright © 2017年 com.qinqin.www. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
@interface ViewController ()<UITableViewDelegate>
{
    NSArray *_property1;
}
@property(nonatomic,strong)NSObject *property2;
@end


@implementation ViewController
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{}
- (void)viewDidLoad {
    [super viewDidLoad];
    unsigned int IvarListCount;
    Ivar *result1 = class_copyIvarList([self class], &IvarListCount);
    for (unsigned int i = 0; i < IvarListCount; i++ ) {
        Ivar ivar = result1[i];
        //获取变量实例
        id result2 = object_getIvar(self, ivar);
        NSLog(@">>>>>result2=%@",result2);
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        if ([ivarName isEqualToString:@"_property1"]) {
            //给实例设置变量
            //入参: 要设置变量的实例,变量结构体Ivar,变量值value
            //返回:void
            object_setIvar(self, ivar, @[@0,@1,@2,@3,@4]);
            }else if([ivarName isEqualToString:@"_property2"]){
                //给实例设置变量
                //入参: 要设置变量的实例,变量结构体Ivar,变量值value
                //返回:void
            object_setIvar(self, ivar, [[NSObject alloc]init]);
            
            }
        id result3 = object_getIvar(self, ivar);
        NSLog(@">>>>>>result3=%@",result3);

        
    }
    /**
     2017-07-16 11:35:51.215 RunTime-text9[1589:55172] >>>>>result2=(null)
     2017-07-16 11:35:51.216 RunTime-text9[1589:55172] >>>>>>result3=(
     0,
     1,
     2,
     3,
     4
     )
     2017-07-16 11:35:51.216 RunTime-text9[1589:55172] >>>>>result2=(null)
     2017-07-16 11:35:51.216 RunTime-text9[1589:55172] >>>>>>result3=<NSObject: 0x608000009d10>

     */
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
