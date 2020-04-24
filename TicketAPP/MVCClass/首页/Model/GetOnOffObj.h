//
//  GetOnOffObj.h
//  TicketAPP
//
//  Created by caochun on 2019/11/6.
//  Copyright © 2019 macbook. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GetOnOffObj : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *point_id;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *real_time;

@property (nonatomic, copy) NSString *unfixed_point;

///英文状况下的名字和详细
@property (nonatomic, copy) NSString *english_name;
@property (nonatomic, copy) NSString *address_name;

///附加费描述
@property (nonatomic, copy) NSString *additional_fee_type_txt_c;
@property (nonatomic, copy) NSString *additional_fee_type_txt_v;
@property (nonatomic, copy) NSString *additional_fee_type_txt_e;
///自定义地址，需要传递给后台
@property (nonatomic, copy) NSString *muUserAddress;
///前端需要提示，线下收取附加费1线下 2线上
@property (nonatomic, copy) NSString *surcharge_type;
///前端需要提示，线上收取附加费，加在票价里面
@property (nonatomic, copy) NSString *surcharge;
///最少接送人数
@property (nonatomic, copy) NSString *min_customer;


///cell的otherlb的值
@property (nonatomic, copy) NSString *strcellOtherValue;

@end

NS_ASSUME_NONNULL_END
