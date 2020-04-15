//
//  TickerOrderDateilsModel.m
//  TicketAPP
//
//  Created by Mac on 2020/4/9.
//  Copyright © 2020 macbook. All rights reserved.
//

#import "TickerOrderDateilsModel.h"

@implementation TickerOrderDateilsModel
+(TickerOrderDateilsModel *)dicToModelValue:(NSDictionary *)dic
{
    TickerOrderDateilsModel *model = [TickerOrderDateilsModel new];
    model.from = [NSString stringWithFormat:@"%@",[dic objectForKey:@"from"]];
    model.to = [NSString stringWithFormat:@"%@",[dic objectForKey:@"to"]];
    model.pickup_info = [NSString stringWithFormat:@"%@",[dic objectForKey:@"pickup_info"]];
    model.drop_off_info = [NSString stringWithFormat:@"%@",[dic objectForKey:@"drop_off_info"]];
    
    model.seat_codes = [NSString stringWithFormat:@"%@",[dic objectForKey:@"seat_codes"]];
    if([[dic objectForKey:@"seat_codes"] isKindOfClass:[NSArray class]])
    {
        NSArray *arrcodes = [dic objectForKey:@"seat_codes"];
        model.seat_codes = [arrcodes componentsJoinedByString:@","];
        
    }
    model.amount_booking = [NSString stringWithFormat:@"%@",[dic objectForKey:@"amount_booking"]];
    model.arrival_date = [NSString stringWithFormat:@"%@",[dic objectForKey:@"arrival_date"]];
    model.created_date = [NSString stringWithFormat:@"%@",[dic objectForKey:@"created_date"]];
    model.code = [NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
    model.order_code = [NSString stringWithFormat:@"%@",[dic objectForKey:@"order_code"]];
    model.order_pay_time = [NSString stringWithFormat:@"%@",[dic objectForKey:@"order_pay_time"]];
    
    
    model.pickup_surcharge = [NSString stringWithFormat:@"%@",[dic objectForKey:@"pickup_surcharge"]];
    model.drop_off_surcharge = [NSString stringWithFormat:@"%@",[dic objectForKey:@"drop_off_surcharge"]];
    model.pickup_points_price_txt_c = [NSString stringWithFormat:@"%@",[dic objectForKey:@"pickup_points_price_txt_c"]];
    model.pickup_points_price_txt_e = [NSString stringWithFormat:@"%@",[dic objectForKey:@"pickup_points_price_txt_e"]];
    model.pickup_points_price_txt_v = [NSString stringWithFormat:@"%@",[dic objectForKey:@"pickup_points_price_txt_v"]];
    
    
    model.drop_off_points_price_txt_c = [NSString stringWithFormat:@"%@",[dic objectForKey:@"drop_off_points_price_txt_c"]];
    model.drop_off_points_price_txt_e = [NSString stringWithFormat:@"%@",[dic objectForKey:@"drop_off_points_price_txt_e"]];
    model.drop_off_points_price_txt_v = [NSString stringWithFormat:@"%@",[dic objectForKey:@"drop_off_points_price_txt_v"]];
    
//    model.pickup_surcharge = @"上车附加费用收取100,上车附加费用收取100,上车附加费用收取100,上车附加费用收取100";
//    model.drop_off_surcharge = @"下车附加费用收取100,下车附加费用收取100,下车附加费用收取100下车附加费用收取100下车附加费用收取100";
    
    if(model.order_pay_time.length==0)
    {
        model.order_pay_time = NSBundleLocalizedString(@"未支付");
    }
    if([[dic objectForKey:@"customer"] isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *customer = [dic objectForKey:@"customer"];
        model.name = [NSString stringWithFormat:@"%@",[customer objectForKey:@"name"]];
        model.phone = [NSString stringWithFormat:@"%@",[customer objectForKey:@"phone"]];
        model.email = [NSString stringWithFormat:@"%@",[customer objectForKey:@"email"]];
        
    }
    model.order_status = [NSString stringWithFormat:@"%@",[dic objectForKey:@"order_status"]];
    int istatus = [model.order_status intValue];
    switch (istatus) {
        case 1:
        {
            model.order_statusString =NSBundleLocalizedString(@"待支付") ;
        }
            break;
        case 2:
        {
            model.order_statusString = NSBundleLocalizedString(@"已支付");
        }
            break;
        case 3:
        {
            model.order_statusString = NSBundleLocalizedString(@"支付超时");
        }
            break;
        case 4:
        {
            model.order_statusString = NSBundleLocalizedString(@"已发车");
        }
            break;
        case 5:
        {
            model.order_statusString = NSBundleLocalizedString(@"已取消");
        }
            break;
        case 6:
        {
            model.order_statusString = NSBundleLocalizedString(@"申请退款");
        }
            break;
        case 7:
        {
            model.order_statusString = NSBundleLocalizedString(@"已退款");
        }
            break;
        case 8:
        {
            model.order_statusString = NSBundleLocalizedString(@"已完成");
        }
            break;
        default:
        {
            model.order_statusString = NSBundleLocalizedString(@"已取消");
        }
            break;
    }
    
    return model;
}

@end
