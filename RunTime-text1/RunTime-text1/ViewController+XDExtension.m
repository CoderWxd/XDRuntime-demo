//
//  ViewController+XDExtension.m
//  RunTime-text1
//
//  Created by 王晓栋 on 2017/6/15.
//  Copyright © 2017年 com.qinqin.www. All rights reserved.
//

#import "ViewController+XDExtension.h"


#import <objc/runtime.h>
#define TF_SYNTHESIZE_CATEGORY_PROPERTY_RETAIN(GETTER,SETTER) TF_SYNTHESIZE_CATEGORY_PROPERTY(GETTER,SETTER,OBJC_ASSOCIATION_RETAIN_NONATOMIC,id)
#define TF_SYNTHESIZE_CATEGORY_PROPERTY_COPY(GETTER,SETTER)   TF_SYNTHESIZE_CATEGORY_PROPERTY(GETTER,SETTER,OBJC_ASSOCIATION_COPY,id)
#define TF_SYNTHESIZE_CATEGORY_PROPERTY_ASSIGN(GETTER,SETTER) TF_SYNTHESIZE_CATEGORY_PROPERTY(GETTER,SETTER,OBJC_ASSOCIATION_ASSIGN,id)
#define TF_SYNTHESIZE_CATEGORY_PROPERTY_BLOCK(GETTER,SETTER,TYPE)   TF_SYNTHESIZE_CATEGORY_PROPERTY(GETTER,SETTER,OBJC_ASSOCIATION_COPY,TYPE)

#define TF_SYNTHESIZE_CATEGORY_PROPERTY(GETTER,SETTER,objc_AssociationPolicy,TYPE)\
- (TYPE)GETTER{return objc_getAssociatedObject(self, @selector(GETTER));}\
- (void)SETTER:(TYPE)obj{objc_setAssociatedObject(self, @selector(GETTER), obj, objc_AssociationPolicy);}
@interface ViewController()
{
    NSString *property5;
}
@property(nonatomic,strong)NSString *property5;

@end
@implementation ViewController (XDExtension)
TF_SYNTHESIZE_CATEGORY_PROPERTY_RETAIN(property5, setProperty5);

+(void)method1{
    NSLog(@"%s",__func__);
}
@end
