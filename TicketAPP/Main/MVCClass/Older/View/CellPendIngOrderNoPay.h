//
//  CellPendIngOrderNoPay.h
//  TicketAPP
//
//  Created by Mac on 2020/4/14.
//  Copyright © 2020 macbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TicketOrderModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CellPendIngOrderNoPay : UITableViewCell

@property (nonatomic,strong) TicketOrderModel *model;

@property (nonatomic, copy) void (^selectCellViewBloak)(TicketOrderModel *model);


@end

NS_ASSUME_NONNULL_END
