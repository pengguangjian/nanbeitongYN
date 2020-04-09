//
//  JSBridge.h
//  MeiShi
//
//  Created by caochun on 16/5/13.
//  Copyright © 2016年 More. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <JavaScriptCore/JavaScriptCore.h>
#import "AppWebView.h"

@interface JSBridge : NSObject

@property (nonatomic,strong) JSContext *jsContext;

@property (nonatomic, strong) AppWebView *appWebView;

- (void)regiestJSFunctionInContext:(JSContext *) jsContext andViewController:(UIViewController*)currentVC;

@end
