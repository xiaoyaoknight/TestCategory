//
//  ViewController.m
//  TestCategory
//
//  Created by wangzelong on 2020/4/8.
//  Copyright © 2020 wangzelong. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "Person+A.h"
#import <objc/runtime.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    Person *person = [[Person alloc] init];
//    [person test];
    [self aaa];
}

- (void)aaa {
    u_int count;
    Method *methods = class_copyMethodList([Person class], &count);
    NSInteger index = 0;
    for (int i = 0; i < count; i++) {
        SEL name = method_getName(methods[i]);
        NSString *strName = [NSString stringWithCString:sel_getName(name) encoding:NSUTF8StringEncoding];
        NSLog(@"%@", strName);
        if ([strName isEqualToString:@"test"]) {
            index = i;
        }
    }
    
    SEL sel = method_getName(methods[index]);
    IMP imp = method_getImplementation(methods[index]);
    ((void (*)(id, SEL))imp)(self,sel);
}

@end
