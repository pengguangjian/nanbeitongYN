//
//  LogisticsOrderRefundVC.m
//  TicketAPP
//
//  Created by 肖世恒 on 2019/8/1.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "LogisticsOrderRefundVC.h"
#import "TicketConfirmModel.h"
#import "WebModel.h"

@interface LogisticsOrderRefundVC ()
//车票金额
@property (strong, nonatomic)  UILabel *mouniLabel;
//预计手续费
@property (strong, nonatomic)  UILabel *sxflabel;
//预计退款金额
@property (strong, nonatomic)  UILabel *yujituikuanlabel;
//说明
@property (strong, nonatomic)  UILabel *shouminglabel;

@end

@implementation LogisticsOrderRefundVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = NSBundleLocalizedString(@"退款");
    self.view.backgroundColor = UIColorFromHex(0xf6f6f6);
    [self drawUI];
    
    self.mouniLabel.text = @"";
    self.sxflabel.text = @"";
    self.yujituikuanlabel.text = @"";
    
    
    
    [self requestReplyrefund];
    
    [self getRequestDesc];
}


-(void)drawUI
{
    UIScrollView *scvback = [[UIScrollView alloc] init];
    [scvback setBackgroundColor:RGB(244, 244, 244)];
    [self.view addSubview:scvback];
    [scvback mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(SYS_TopHeight);
        make.left.right.equalTo(self.view);
        make.height.offset(DEVICE_Height-SYS_TopHeight);
    }];
    
    
    UIView *viewback = [[UIView alloc] init];
    [viewback setBackgroundColor:[UIColor whiteColor]];
    [scvback addSubview:viewback];
    [viewback mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(0);
        make.width.offset(DEVICE_Width);
    }];
    UIView *viewlast;
    NSArray *arrname = @[LS(@"定金"),LS(@"预计手续费"),LS(@"预计退款金额")];
    for(int i = 0 ; i < arrname.count; i++)
    {
        UIView *viewitem = [[UIView alloc] init];
        [scvback addSubview:viewitem];
        [viewitem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(viewback);
            make.top.offset(50*i);
            make.height.offset(50);
        }];
        UILabel *lbtemp = [self drawitem:arrname[i] andview:viewitem];
        if(i==0)
        {
            self.mouniLabel = lbtemp;
            [lbtemp setTextColor:RGB(235, 90, 78)];
        }
        else if (i==1)
        {
            self.sxflabel = lbtemp;
            [lbtemp setTextColor:RGB(150, 150, 150)];
        }
        else if (i==2)
        {
            self.yujituikuanlabel = lbtemp;
            [lbtemp setTextColor:RGB(235, 90, 78)];
        }
        viewlast = viewitem;
    }
    
    
    ////shouminglabel
    UILabel *lbsm = [[UILabel alloc] init];
    [lbsm setTextColor:RGB(130, 130, 130)];
    [lbsm setTextAlignment:NSTextAlignmentLeft];
    [lbsm setNumberOfLines:0];
    [lbsm setFont:[UIFont systemFontOfSize:14]];
    [viewback addSubview:lbsm];
    [lbsm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.equalTo(viewback).offset(-10);
        make.top.equalTo(viewlast.mas_bottom).offset(10);
    }];
    self.shouminglabel = lbsm;
    
    [viewback mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lbsm.mas_bottom).offset(10);
    }];
    
    
    UIButton *btquxiao = [[UIButton alloc] init];
    [btquxiao setTitle:LS(@"取消") forState:UIControlStateNormal];
    [btquxiao setTitleColor:RGB(100, 100, 100) forState:UIControlStateNormal];
    [btquxiao.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [btquxiao setBackgroundColor:[UIColor whiteColor]];
    [btquxiao.layer setMasksToBounds:YES];
    [btquxiao.layer setCornerRadius:3];
    [btquxiao addTarget:self action:@selector(quxiaoClick:) forControlEvents:UIControlEventTouchUpInside];
    [scvback addSubview:btquxiao];
    [btquxiao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.sizeOffset(CGSizeMake(120, 40));
        make.top.equalTo(lbsm.mas_bottom).offset(30);
        make.left.equalTo(@35);
    }];
    
    
    UIButton *btqueding = [[UIButton alloc] init];
    [btqueding setTitle:LS(@"确认退款") forState:UIControlStateNormal];
    [btqueding setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
    [btqueding.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [btqueding setBackgroundColor:DEFAULTCOLOR1];
    [btqueding.layer setMasksToBounds:YES];
    [btqueding.layer setCornerRadius:3];
    [btqueding addTarget:self action:@selector(querenClick:) forControlEvents:UIControlEventTouchUpInside];
    [scvback addSubview:btqueding];
    [btqueding mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.sizeOffset(CGSizeMake(120, 40));
        make.top.equalTo(btquxiao);
        make.right.equalTo(viewback).equalTo(@-35);
    }];
    
    [scvback mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(btquxiao.mas_bottom).offset(30);
    }];
    
    
}

-(UILabel *)drawitem:(NSString *)name andview:(UIView *)view
{
    
    UILabel *lbname = [[UILabel alloc] init];
    [lbname setText:name];
    [lbname setTextColor:RGB(30, 30, 30)];
    [lbname setTextAlignment:NSTextAlignmentLeft];
    [lbname setFont:[UIFont systemFontOfSize:14]];
    [view addSubview:lbname];
    [lbname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.bottom.equalTo(view);
    }];
    
    
    UILabel *lbvalue = [[UILabel alloc] init];
    [lbvalue setTextColor:RGB(30, 30, 30)];
    [lbvalue setTextAlignment:NSTextAlignmentRight];
    [lbvalue setFont:[UIFont systemFontOfSize:14]];
    [view addSubview:lbvalue];
    [lbvalue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view).offset(-10);
        make.top.bottom.equalTo(view);
    }];
    
    UIView *viewline = [[UIView alloc] init];
    [viewline setBackgroundColor:RGB(245, 245, 245)];
    [view addSubview:viewline];
    [viewline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(view);
        make.height.offset(1);
    }];
    
    return lbvalue;
}




- (void)getRequestDesc{
    
    WEAK_SELF;
    [AFHTTP requestInfoagreement555555success:^(NSDictionary *responseObject){
        WebModel *model = [WebModel mj_objectWithKeyValues:responseObject[@"content"]];
        weakSelf.shouming = [weakSelf filterHTML:model.content];
        
        NSString *shouming = NSBundleLocalizedString(@"说明");
        NSString *shouming2 = self.shouming;
        
        self.shouminglabel.text = [NSString stringWithFormat:@"%@\n%@",shouming,shouming2];
    }];
}

- (NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    //    NSString * regEx = @"<([^>]*)>";
    //    html = [html stringByReplacingOccurrencesOfString:regEx withString:@""];
    return html;
}


- (void)requestReplyrefund{
    
    WEAK_SELF;
    [AFHTTP requestLogisticsReplyrefundOb_id:self.model.ol_id success:^(NSDictionary *dic){
        
        [weakSelf chulishuju:dic];
        
    } failure:^(NSError *errer){
        
        [weakSelf onBack];
        
    }];
    
}
- (void)chulishuju:(NSDictionary *)dic{
    
    NSDictionary *info = dic[@"info"];
    if([info isKindOfClass:[NSDictionary class]]){
        
        TicketConfirmModel *model = [TicketConfirmModel mj_objectWithKeyValues:info];
        
        self.mouniLabel.text = [NSString stringWithFormatPrice:model.all_price];
        
        self.sxflabel.text = [NSString stringWithFormatPrice:model.service_charge];
        
        self.yujituikuanlabel.text =  [NSString stringWithFormatPrice:model.back_money];
        
    }
        

}
- (void)requestsurerefund{
    
    WEAK_SELF;
    [AFHTTP requestLogisticssurerefundOrder_id:self.model.ol_id success:^(NSDictionary *dic){
        
        [MBManager showBriefAlert:NSBundleLocalizedString(@"申请成功")];
        
        [weakSelf onBack];
        
    }];
    
}

-(void)onBack
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)quxiaoClick:(id)sender {
    
    [self onBack];
    
}
- (IBAction)querenClick:(id)sender {
    
    [self requestsurerefund];
    
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
