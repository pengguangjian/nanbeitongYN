//
//  NSString+XBKit.h
//  TicketAPP
//
//  Created by xiaoshiheng on 2019/8/6.
//  Copyright © 2019 macbook. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (XBKit)


+ (instancetype)stringWithFormatPrice:(NSString *)priceStr;

#pragma mark - 判断是否为空对象
+ (NSString *)nullToString:(id)data;

@end

NS_ASSUME_NONNULL_END
