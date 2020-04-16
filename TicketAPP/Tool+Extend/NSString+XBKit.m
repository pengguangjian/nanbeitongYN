//
//  NSString+XBKit.m
//  TicketAPP
//
//  Created by xiaoshiheng on 2019/8/6.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "NSString+XBKit.h"

@implementation NSString (XBKit)

+ (instancetype)stringWithFormatPrice:(NSString *)priceStr
{
//    //容错
//    if (!priceStr) {
//        priceStr = @"0";
//    }
//
//    //,
//    priceStr = [priceStr stringByReplacingOccurrencesOfString:@"," withString:@""];
//    //包含￥  去掉
//    NSString* showStr = [NSString stringWithString:priceStr];
//    NSRange rangeMoney1 = [priceStr rangeOfString:@"￥"];
//    if (rangeMoney1.length != 0) {
//        //如果包含
//        showStr = [showStr stringByReplacingOccurrencesOfString:@"￥" withString:@""];
//    }
//
//    NSRange rangeMoney2 = [priceStr rangeOfString:@"元"];
//    if (rangeMoney2.length != 0) {
//        //如果包含
//        showStr = [showStr stringByReplacingOccurrencesOfString:@"元" withString:@""];
//    }
//    double doubleShowValue = [showStr doubleValue];
//    NSString *tempStr = [self accurateNumberStr:[NSString stringWithFormat:@"%lf", doubleShowValue] afterPoint:2];
    NSString *resultStr ;
    
    resultStr = [NSString stringWithFormat:@"%@₫", priceStr];
    
    return resultStr;
    
}

+ (NSString *)accurateNumberStr:(NSString *)numberStr afterPoint:(NSInteger)afterPoint {
    
    //保留小数点后两
    NSDecimalNumberHandler *numberHandler = [NSDecimalNumberHandler
                                             decimalNumberHandlerWithRoundingMode:NSRoundDown
                                             scale:afterPoint
                                             raiseOnExactness:NO
                                             raiseOnOverflow:NO
                                             raiseOnUnderflow:NO
                                             raiseOnDivideByZero:YES];
    
    NSDecimalNumber *tempResult = [NSDecimalNumber decimalNumberWithString:numberStr];
    
    NSDecimalNumber *roundedOunces = [tempResult decimalNumberByRoundingAccordingToBehavior:numberHandler];
    
    return [NSString stringWithFormat:@"%.2lf",[roundedOunces doubleValue]];
}

#pragma mark - 判断是否为空对象
+ (NSString *)nullToString:(id)data
{
    return [self nullToString:data preset:@""];
}

#pragma mark - 判断是否为空对象,并设置预设值
+ (NSString *)nullToString:(id)data preset:(NSString *)presetStr{
    NSString *str;
    if (data == [NSNull null] || data == nil || data == Nil || [data isKindOfClass:[NSNull class]] || [[NSString stringWithFormat:@"%@",data] isEqualToString:@"<null>"] || [[NSString stringWithFormat:@"%@",data] isEqualToString:@"(null)"] || [[NSString stringWithFormat:@"%@",data] isEqualToString:@"<NULL>"]) {
        str = presetStr;
    }else{
        str = [NSString stringWithFormat:@"%@",data];
    }
    return str;
}

@end
