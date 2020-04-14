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
@property (nonatomic, copy) NSString *address_name;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *real_time;
@property (nonatomic, copy) NSString *unfixed_point;
@property (nonatomic, copy) NSString *english_name;

@property (nonatomic, copy) NSString *additional_fee_type_txt;
///自定义地址，需要传递给后台
@property (nonatomic, copy) NSString *muUserAddress;

@end

NS_ASSUME_NONNULL_END
