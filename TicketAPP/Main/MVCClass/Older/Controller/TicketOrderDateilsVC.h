//
//  TicketOrderDateilsVC.h
//  TicketAPP
//
//  Created by Mac on 2020/4/9.
//  Copyright © 2020 macbook. All rights reserved.
//

#import "BaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface TicketOrderDateilsVC : BaseVC

@property (nonatomic , retain) NSString *order_id;
///出发时间
@property (nonatomic , retain) NSNumber *ob_setout_time;
///未支付有这个最后支付时间
@property (nonatomic , retain) NSString *failure_description_date;
@end

NS_ASSUME_NONNULL_END
