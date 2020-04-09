//
//  TicketOrderDateilsView.h
//  TicketAPP
//
//  Created by Mac on 2020/4/9.
//  Copyright © 2020 macbook. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TicketOrderDateilsViewDelegate <NSObject>
///2退款，1支付
-(void)tviewActionBack:(NSInteger)tag;

@end

@interface TicketOrderDateilsView : UIView

@property (nonatomic,weak)id<TicketOrderDateilsViewDelegate>delegate;

-(void)drawValue:(id)model;

@end

NS_ASSUME_NONNULL_END
