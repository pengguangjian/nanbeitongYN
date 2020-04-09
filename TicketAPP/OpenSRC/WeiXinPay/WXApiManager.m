//
//  WXApiManager.m
//  SDKSample
//
//  Created by Jeason on 16/07/2015.
//
//

#import "WXApiManager.h"

@implementation WXApiManager

#pragma mark - LifeCycle
+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static WXApiManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[WXApiManager alloc] init];
    });
    return instance;
}

- (void)dealloc {
    self.delegate = nil;
}

#pragma mark - WXApiDelegate
- (void)onResp:(BaseResp *)resp {
    if([resp isKindOfClass:[PayResp class]]) {
        //支付返回结果，实际支付结果需要去微信服务器端查询
        NSString *strMsg;
        
        switch (resp.errCode) {
            case WXSuccess:
            {
                strMsg = @"支付结果：成功！";
                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                
                if (_delegate && [_delegate respondsToSelector:@selector(WXPayResult:)]) {
                    
                    [_delegate WXPayResult:WXPayResultSucess];
                }
                
                break;
            }
                
            default:
            {
                
                if (_delegate && [_delegate respondsToSelector:@selector(WXPayResult:)]) {
                    
                    [_delegate WXPayResult:WXPayResultFail];
                }
                
                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                break;
            }
                
        }
        
    }

}

/**
 *  获取顶层ViewController
 *
 *  @return UIViewController
 */
- (UIViewController *)appTopViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}





//- (void)onReq:(BaseReq *)req {
//    if ([req isKindOfClass:[GetMessageFromWXReq class]]) {
//        if (_delegate
//            && [_delegate respondsToSelector:@selector(managerDidRecvGetMessageReq:)]) {
//            GetMessageFromWXReq *getMessageReq = (GetMessageFromWXReq *)req;
//            [_delegate managerDidRecvGetMessageReq:getMessageReq];
//        }
//    } else if ([req isKindOfClass:[ShowMessageFromWXReq class]]) {
//        if (_delegate
//            && [_delegate respondsToSelector:@selector(managerDidRecvShowMessageReq:)]) {
//            ShowMessageFromWXReq *showMessageReq = (ShowMessageFromWXReq *)req;
//            [_delegate managerDidRecvShowMessageReq:showMessageReq];
//        }
//    } else if ([req isKindOfClass:[LaunchFromWXReq class]]) {
//        if (_delegate
//            && [_delegate respondsToSelector:@selector(managerDidRecvLaunchFromWXReq:)]) {
//            LaunchFromWXReq *launchReq = (LaunchFromWXReq *)req;
//            [_delegate managerDidRecvLaunchFromWXReq:launchReq];
//        }
//    }
//}

@end