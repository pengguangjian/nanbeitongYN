//
//  AFHTTP+News.h
//  TicketAPP
//
//  Created by 肖世恒 on 2019/7/13.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "AFHTTP.h"

NS_ASSUME_NONNULL_BEGIN

@interface AFHTTP (News)


+ (void)requestNewslistSuccess:(HttpRequestSuccess)success
                       failure:(HttpRequestFailed)failure;

+ (void)requestNewsdetailNewsId:(NSString *)news_id
                        success:(HttpRequestSuccess)success;

@end

NS_ASSUME_NONNULL_END
