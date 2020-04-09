//
//  PaymentWebViewController.m
//  TicketAPP
//
//  Created by xiaoshiheng on 2019/7/31.
//  Copyright © 2019 macbook. All rights reserved.
//

#import <WebKit/WebKit.h>
#import "PaymentWebViewController.h"
#import "WebViewJavascriptBridge.h"
#import "JSBridge.h"
#import "DHPaySuccessView.h"

@interface PaymentWebViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@property(nonatomic, strong) WebViewJavascriptBridge *bridge;

@end

@implementation PaymentWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.top.mas_equalTo(SYS_TopHeight);
        maker.right.left.bottom.equalTo(self.view);
    }];
    
    [self addLeftBarButtonImage:[UIImage imageNamed:@"navi_back"]];
    [self payment];
    
}
- (void)clickLeftBarButton:(UIButton *)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)payment{
    
    self.navigationItem.title = @"Payment";
    
    
    [WebViewJavascriptBridge enableLogging];
    _bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView];
    [_bridge setWebViewDelegate:self];
    
    [self registerMethod];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@api/payment/create",HTTPAPI];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *requestM = [NSMutableURLRequest requestWithURL:url];
    // 如果有webMethod并且是POST,则POST方式组合提交
    [requestM setHTTPMethod:@"POST"];
    NSString *body = [NSString stringWithFormat:@"order_id=%@&order_type=%@",self.order_id,self.order_type];
    NSLog(@"%@",body);
    [requestM setHTTPBody:[body dataUsingEncoding: NSUTF8StringEncoding]];

    [self.webView loadRequest:requestM];
  
    
//    NSString *urlStr = [NSString stringWithFormat:@"%@api/payment/create?order_id=%@&order_type=%@",HTTPAPI,self.order_id,self.order_type];
//    NSURL *url = [NSURL URLWithString:urlStr];
//    [self.webView loadData:nil MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:url];
    
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
//    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
//    JSBridge *jsBridge = [[JSBridge alloc] init];
//    [jsBridge regiestJSFunctionInContext:context andViewController:self];
    
    
    
    
    
    NSLog(@"webViewDidStartLoad");
    
    [MBManager showLoading];
    
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [MBManager hideAlert];
    
     NSLog(@"webViewDidFinishLoad");
    
    int htmlWidth= [[webView stringByEvaluatingJavaScriptFromString: @"document.body.scrollWidth"] intValue];//获取 html 宽度
    [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"var element = document.createElement('meta');  element.name = \"viewport\";  element.content = \"width=device-width,initial-scale=%f,minimum-scale=0.1,maximum-scale=2.0,user-scalable=yes\"; var head = document.getElementsByTagName('head')[0]; head.appendChild(element);", webView.frame.size.width / htmlWidth]];
    
    NSString *currentURL = webView.request.URL.absoluteString;
    NSLog(@"currentURL:%@",currentURL);
    
   
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [MBManager hideAlert];
    
    NSLog(@"didFailLoadWithError");
}
- (UIWebView *)webView{
    if(!_webView){
        
        _webView = [[UIWebView alloc]init];
        _webView.delegate = self;
        
    }
    return _webView;
}



- (void)registerMethod {
    
    //JS调用原生
    [self.bridge registerHandler:@"paymentCompleted" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        if (responseCallback) {
            // 反馈给JS
//            [SVProgressHUD showSuccessWithStatus:@"成功调用原生"];
            
            DHPaySuccessView *paySuccessView = [DHPaySuccessView sharedView];
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            [window addSubview:paySuccessView];
            
            [paySuccessView show];
            
        }
        
    }];
    
    
}

@end
