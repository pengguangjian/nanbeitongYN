//
//  CellPendIngOrderNoPay.m
//  TicketAPP
//
//  Created by Mac on 2020/4/14.
//  Copyright © 2020 macbook. All rights reserved.
//

#import "CellPendIngOrderNoPay.h"

@interface CellPendIngOrderNoPay ()
@property (weak, nonatomic) IBOutlet UILabel *orderNoLabel;
@property (weak, nonatomic) IBOutlet UILabel *zhannamelabel;
@property (weak, nonatomic) IBOutlet UILabel *fachelabel;
@property (weak, nonatomic) IBOutlet UILabel *qianqianlabel;
@property (weak, nonatomic) IBOutlet UILabel *piponumbr;
@property (weak, nonatomic) IBOutlet UIButton *outButton;
@property (weak, nonatomic) IBOutlet UILabel *tishilabel;


@property (weak, nonatomic) IBOutlet UILabel *orderCancleTSlabel;

@end

@implementation CellPendIngOrderNoPay

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.tishilabel.text = NSBundleLocalizedString(@"温馨提示：请提前准时到达始发站");
    ViewBorderRadius(self.outButton, 5, 0, UIColorFromHex(0x989898));
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(TicketOrderModel *)model{
    
    _model = model;
    
    if([model.ob_status intValue] == 1){
        //支付
        [self.outButton setTitle:NSBundleLocalizedString(@"支付") forState:UIControlStateNormal];
    }else{
        //待坐车
        [self.outButton setTitle:NSBundleLocalizedString(@"退票退款") forState:UIControlStateNormal];
    }
    
    
    NSString *zhanname = [NSString stringWithFormat:@"%@-%@",model.start_name,model.end_name];
    self.zhannamelabel.text = zhanname;
    self.qianqianlabel.text = [NSString stringWithFormatPrice:model.ob_all_price];
    
    NSString *fache = NSBundleLocalizedString(@"发车");
    self.fachelabel.text = [NSString stringWithFormat:@"%@%@",[NSDate timestampToTimeStr:[model.ob_setout_time floatValue]],fache];
    
    NSString *gong = NSBundleLocalizedString(@"共");
    NSString *ren = NSBundleLocalizedString(@"人");
    NSString *piponumstr = [NSString stringWithFormat:@"%@%@%@",gong,model.ob_count,ren];
    self.piponumbr.text = piponumstr;
    
    self.orderNoLabel.text = [NSString stringWithFormat:@"%@：%@",LS(@"订单号"), model.order_code];
    
    self.orderCancleTSlabel.text = [NSString stringWithFormat:@"请在%@之前完成付款，否则订单将取消",model.failure_description_date];
    if([NSBundle getLanguagekey] == LanguageVI)
    {
        self.orderCancleTSlabel.text = [NSString stringWithFormat:@"Vui lòng hoàn tất thanh toán trước %@, nếu không đơn hàng sẽ bị hủy",model.failure_description_date];
    }
    else if([NSBundle getLanguagekey] == LanguageEN)
    {
        self.orderCancleTSlabel.text = [NSString stringWithFormat:@"Please complete the payment before %@, otherwise the order will be cancelled",model.failure_description_date];
    }
}

- (IBAction)tuipiaoClick:(id)sender {
    
    if(self.selectCellViewBloak){
        self.selectCellViewBloak(self.model);
    }
    
    
}

@end
