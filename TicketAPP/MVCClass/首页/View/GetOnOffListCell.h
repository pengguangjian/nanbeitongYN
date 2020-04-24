//
//  GetOnOffListCell.h
//  TicketAPP
//
//  Created by caochun on 2019/11/6.
//  Copyright © 2019 macbook. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GetOnOffListCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *addrLabel;
@property (weak, nonatomic) IBOutlet UILabel *beizhuLabel;

@end

NS_ASSUME_NONNULL_END
