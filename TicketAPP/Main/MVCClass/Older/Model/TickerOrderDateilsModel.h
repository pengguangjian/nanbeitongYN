//
//  TickerOrderDateilsModel.h
//  TicketAPP
//
//  Created by Mac on 2020/4/9.
//  Copyright © 2020 macbook. All rights reserved.
//

#import "TicketOrderModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TickerOrderDateilsModel : TicketOrderModel
//id
@property (nonatomic, retain) NSString *did;
///出发地点
@property (nonatomic, retain) NSString *from;
///目的地
@property (nonatomic, retain) NSString *to;
///上车点
@property (nonatomic, retain) NSString *pickup_info;
///下车点
@property (nonatomic, retain) NSString *drop_off_info;
///座位代码
@property (nonatomic, retain) NSString *seat_codes;
///价格
@property (nonatomic, retain) NSString *amount_booking;
///预计到达时间
@property (nonatomic, retain) NSString *arrival_date;
///下单时间
@property (nonatomic, retain) NSString *created_date;
///订单号
@property (nonatomic, retain) NSString *code;
///订单编号(父类有)
//@property (nonatomic, retain) NSString *order_code;
///支付时间
@property (nonatomic, retain) NSString *order_pay_time;
///订单状态
@property (nonatomic, retain) NSString *order_status;
@property (nonatomic, retain) NSString *order_statusString;
///联系人
@property (nonatomic, retain) NSString *name;
///联系电话
@property (nonatomic, retain) NSString *phone;
///email
@property (nonatomic, retain) NSString *email;



+(TickerOrderDateilsModel *)dicToModelValue:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
