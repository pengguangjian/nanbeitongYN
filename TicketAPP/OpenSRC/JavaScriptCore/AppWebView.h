//
//  MSApp.h
//  MeiShi
//
//  Created by caochun on 16/5/13.
//  Copyright © 2016年 More. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol AppWebViewProtocol <JSExport>

- (BOOL)paymentCompleted;

@end

@interface AppWebView : NSObject<AppWebViewProtocol>

@property (nonatomic, strong) UIViewController *currentVC;

- (BOOL)paymentCompleted;//支付成功


@end
