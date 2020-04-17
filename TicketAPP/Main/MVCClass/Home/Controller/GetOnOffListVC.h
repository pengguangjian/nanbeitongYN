//
//  GetOnOffListVC.h
//  TicketAPP
//
//  Created by caochun on 2019/11/5.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "BaseVC.h"

NS_ASSUME_NONNULL_BEGIN
typedef void (^GetOnOffListVCGetONHandler)(id obj);
typedef void (^GetOnOffListVCGetOffHandler)(id obj);

@interface GetOnOffListVC : BaseVC
@property (nonatomic, copy) NSString *trip_id;
@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic, copy) GetOnOffListVCGetONHandler getONHandler;
@property (nonatomic, copy) GetOnOffListVCGetOffHandler getOffHander;

///座位数
@property (nonatomic , assign) NSInteger pipoCount;

@end

NS_ASSUME_NONNULL_END
