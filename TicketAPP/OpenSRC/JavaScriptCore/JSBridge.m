//
//  JSBridge.m
//  MeiShi
//
//  Created by caochun on 16/5/13.
//  Copyright © 2016年 More. All rights reserved.
//

#import "JSBridge.h"

@implementation JSBridge


- (void)regiestJSFunctionInContext:(JSContext *) jsContext andViewController:(UIViewController*)currentVC{
    
    self.jsContext = jsContext;
    
    _appWebView = [[AppWebView alloc]init];
    _appWebView.currentVC = currentVC;
    jsContext[@"appWebView"] = _appWebView;
    
}



//注册js方法，然后在利用JSValue调用
- (void)regiestJSFunction {
    //注册一个函数
    [self.jsContext evaluateScript:@"var hello = function(){ return 'hello' }"];
    //调用
    JSValue *value1 = [self.jsContext evaluateScript:@"hello()"];
    
    //注册一个匿名函数
    JSValue *jsFunction = [self.jsContext evaluateScript:@" (function(){ return 'hello objc' })"];
    //调用
    JSValue *value2 = [jsFunction callWithArguments:nil];
    
    
}



//注册一个objc方法给js调用
- (void)regiestNativeFunction {
    //注册一个objc方法给js调用
    self.jsContext[@"log"] = ^(NSString *msg){
        NSLog(@"js:msg:%@",msg);
    };
    //另一种方式，利用currentArguments获取参数
    self.jsContext[@"log"] = ^() {
        NSArray *args = [JSContext currentArguments];
        for (id obj in args) { NSLog(@"%@",obj); }
    };
    
    //使用js调用objc
    [self.jsContext evaluateScript:@"log('hello,i am js side')"];
}

//注册js错误处理
- (void)jsExceptionHandler {
    self.jsContext.exceptionHandler = ^(JSContext *con, JSValue *exception) {
        NSLog(@"%@", exception);
        con.exception = exception;
    };
}



@end
