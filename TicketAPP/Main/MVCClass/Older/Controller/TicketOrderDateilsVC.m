//
//  TicketOrderDateilsVC.m
//  TicketAPP
//
//  Created by Mac on 2020/4/9.
//  Copyright © 2020 macbook. All rights reserved.
//

#import "TicketOrderDateilsVC.h"
#import "TicketOrderDateilsView.h"

#import "TickerOrderDateilsModel.h"

#import "PaymentWebViewController.h"
#import "TicketConfirmCV.h"
#import "RefundNoticeView.h"

@interface TicketOrderDateilsVC ()<TicketOrderDateilsViewDelegate>
{
    TicketOrderDateilsView *songView;
    
    TicketOrderModel *dateilsModel;
}

@property (nonatomic , retain) RefundNoticeView *refundNoticeView;

@end

@implementation TicketOrderDateilsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSBundleLocalizedString(@"订单详情");
    
    
    
    [self drawUI];
    [self getdata];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setShadowImage:nil];
    
}


-(void)drawUI
{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    TicketOrderDateilsView *tview = [[TicketOrderDateilsView alloc] init];
    [self.view addSubview:tview];
    [tview setDelegate:self];
    [tview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.offset(SYS_TopHeight);
        make.width.offset(SCREEN_WIDTH);
        make.height.offset(SCREENH_HEIGHT-SYS_TopHeight);
    }];
    songView = tview;
    
    
}

-(void)getdata
{
    [AFHTTP requestBookinglistOb_id:_order_id success:^(id responseObject) {
        TickerOrderDateilsModel *model = [TickerOrderDateilsModel dicToModelValue:responseObject];
        model.ob_id = self->_order_id;
        model.ob_setout_time = self->_ob_setout_time;
        model.did = self->_order_id;
        self->dateilsModel = model;
        [self->songView drawValue:model];
    } failure:^(NSError *error) {
        [MBManager showBriefAlert:error.localizedDescription];
    }];;
}

-(void)tviewActionBack:(NSInteger)tag
{
    if(tag == 1)
    {///支付
        PaymentWebViewController *vc = [[PaymentWebViewController alloc]init];
        vc.order_id = _order_id;
        vc.order_type = @"1";
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {///退款
        WEAK_SELF;
        self.refundNoticeView = [RefundNoticeView sharedSingleton];
        [self.refundNoticeView setConfirmRefundNoticeViewBloak:^(TicketOrderModel * _Nonnull model, NSString * _Nonnull shouming) {
            
           [weakSelf goTicketConfirm:model shouming:shouming];
        }];
        
        [self.refundNoticeView showMenu:dateilsModel];
    }
    
}

- (void)goTicketConfirm:(TicketOrderModel *)model shouming:(NSString *)shoumg{
    
    TicketConfirmCV *vc = [[TicketConfirmCV alloc]init];
    vc.model = model;
    vc.shouming = shoumg;
    [self.navigationController pushViewController:vc animated:YES];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
