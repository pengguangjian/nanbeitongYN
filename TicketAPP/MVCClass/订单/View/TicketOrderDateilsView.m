//
//  TicketOrderDateilsView.m
//  TicketAPP
//
//  Created by Mac on 2020/4/9.
//  Copyright © 2020 macbook. All rights reserved.
//

#import "TicketOrderDateilsView.h"
#import "TicketOrderModel.h"
#import "TickerOrderDateilsModel.h"

@interface TicketOrderDateilsView ()
{
    UIScrollView *scvback;
}


@end

@implementation TicketOrderDateilsView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self setBackgroundColor:RGB(242, 244, 245)];
        [self drawUI];
    }
    return self;
}

-(void)drawUI
{
    UIView *viewback = [[UIView alloc] init];
    [viewback setBackgroundColor:UIColorFromHex(0x56b157)];
    [viewback setAlpha:0.84];
    [self addSubview:viewback];
    [viewback mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.equalTo(@100);
    }];
    
    
    scvback = [[UIScrollView alloc] init];
    [scvback setShowsVerticalScrollIndicator:NO];
    [scvback setShowsHorizontalScrollIndicator:NO];
    [self addSubview:scvback];
    [scvback setBackgroundColor:[UIColor whiteColor]];
    [scvback.layer setMasksToBounds:YES];
    [scvback.layer setCornerRadius:5];
    [scvback mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.offset(0);
        make.bottom.equalTo(self).offset(-20);
    }];
}


-(void)drawValue:(id)model
{
    if(model==nil)return;
    TickerOrderDateilsModel *tmodel = model;
    
    
    UILabel *lbfirsttemp ;
    if(tmodel.order_status.intValue == 1)
    {
        UILabel *lbpeytishi = [[UILabel alloc] init];
        lbpeytishi.text = [NSString stringWithFormat:@"请在%@之前完成付款，否则订单将取消",tmodel.failure_description_date];
        if([NSBundle getLanguagekey] == LanguageVI)
        {
            lbpeytishi.text = [NSString stringWithFormat:@"Vui lòng hoàn tất thanh toán trước %@, nếu không đơn hàng sẽ bị hủy",tmodel.failure_description_date];
        }
        else if([NSBundle getLanguagekey] == LanguageEN)
        {
            lbpeytishi.text = [NSString stringWithFormat:@"Please complete the payment before %@, otherwise the order will be cancelled",tmodel.failure_description_date];
        }
        [lbpeytishi setTextColor:RGB(120, 120, 120)];
        [lbpeytishi setTextAlignment:NSTextAlignmentLeft];
        [lbpeytishi setFont:[UIFont systemFontOfSize:12]];
        [lbpeytishi setNumberOfLines:0];
        [scvback addSubview:lbpeytishi];
        [lbpeytishi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.width.equalTo(scvback.mas_width).offset(-30);
            make.top.offset(15);
        }];
        lbfirsttemp = lbpeytishi;
        
    }
    
    UILabel *lbqidian = [[UILabel alloc] init];
    [lbqidian setText:NSBundleLocalizedString(@"起点")];
    [lbqidian setTextColor:RGB(120, 120, 120)];
    [lbqidian setTextAlignment:NSTextAlignmentLeft];
    [lbqidian setFont:[UIFont systemFontOfSize:12]];
    [scvback addSubview:lbqidian];
    [lbqidian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.height.offset(20);
        if(tmodel.order_status.intValue == 1)
        {
            make.top.equalTo(lbfirsttemp.mas_bottom).offset(15);
        }
        else
        {
            make.top.offset(25);
        }
    }];
    UIView *viewqd = [[UIView alloc] init];
    [viewqd setBackgroundColor:UIColorFromHex(0x56b157)];
    [scvback addSubview:viewqd];
    [viewqd.layer setMasksToBounds:YES];
    [viewqd.layer setCornerRadius:5];
    [viewqd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(lbqidian);
        make.top.equalTo(lbqidian.mas_bottom);
        make.size.sizeOffset(CGSizeMake(10, 10));
    }];
    
    UIView *viewlinesx = [[UIView alloc] init];
    [viewlinesx setBackgroundColor:RGB(234, 234, 234)];
    [scvback addSubview:viewlinesx];
    [viewlinesx mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(viewqd);
        make.top.equalTo(viewqd.mas_bottom).offset(2);
        make.size.sizeOffset(CGSizeMake(1, 35));
    }];
    
    
    UIView *viewzd = [[UIView alloc] init];
    [viewzd setBackgroundColor:RGB(242, 174, 49)];
    [scvback addSubview:viewzd];
    [viewzd.layer setMasksToBounds:YES];
    [viewzd.layer setCornerRadius:5];
    [viewzd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(viewlinesx);
        make.top.equalTo(viewlinesx.mas_bottom).offset(2);
        make.size.equalTo(viewqd);
    }];
    
    UILabel *lbzongdian = [[UILabel alloc] init];
    [lbzongdian setText:NSBundleLocalizedString(@"终点")];
    [lbzongdian setTextColor:RGB(120, 120, 120)];
    [lbzongdian setTextAlignment:NSTextAlignmentLeft];
    [lbzongdian setFont:[UIFont systemFontOfSize:12]];
    [scvback addSubview:lbzongdian];
    [lbzongdian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbqidian);
        make.top.equalTo(viewzd.mas_bottom);
        make.centerX.equalTo(viewzd);
        make.height.offset(20);
    }];
    
    UILabel *lbqdValue = [[UILabel alloc] init];
    [lbqdValue setText:tmodel.from];
    [lbqdValue setTextColor:RGB(50, 50, 50)];
    [lbqdValue setTextAlignment:NSTextAlignmentLeft];
    [lbqdValue setFont:[UIFont systemFontOfSize:16]];
    [lbqdValue setNumberOfLines:2];
    [scvback addSubview:lbqdValue];
    [lbqdValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@100);
        make.centerY.equalTo(lbqidian.mas_bottom);
        make.width.equalTo(@190);
//        make.height.offset(20);
    }];
    
    
    UILabel *lbzdValue = [[UILabel alloc] init];
    [lbzdValue setText:tmodel.to];
    [lbzdValue setTextColor:RGB(50, 50, 50)];
    [lbzdValue setTextAlignment:NSTextAlignmentLeft];
    [lbzdValue setFont:[UIFont systemFontOfSize:16]];
    [lbzdValue setNumberOfLines:2];
    [scvback addSubview:lbzdValue];
    [lbzdValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbqdValue);
        make.centerY.equalTo(lbzongdian.mas_top);
        make.width.equalTo(@190);
//        make.height.offset(20);
    }];
    
    ////[NSDate timestampToTimeStr:[model.ob_setout_time floatValue]]
    
    UILabel *lbchufatime = [[UILabel alloc] init];
    [lbchufatime setText:[NSString stringWithFormat:@"%@%@",[NSDate timestampToTimeStr:[tmodel.ob_setout_time floatValue]],NSBundleLocalizedString(@"出发")]];
    [lbchufatime setTextColor:RGB(50, 50, 50)];
    [lbchufatime setTextAlignment:NSTextAlignmentLeft];
    [lbchufatime setFont:[UIFont systemFontOfSize:14]];
    [scvback addSubview:lbchufatime];
    [lbchufatime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbqidian);
        make.top.equalTo(lbzdValue.mas_bottom);
        make.height.offset(50);
    }];
    
    
    UIView *viewline = [[UIView alloc] init];
    [viewline setBackgroundColor:RGB(234, 234, 234)];
    [scvback addSubview:viewline];
    [viewline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.width.equalTo(scvback.mas_width).offset(-30);
        make.top.equalTo(lbchufatime.mas_bottom);
        make.height.offset(1);
    }];
    
    //预计到达时间  预定时间
    NSArray *arrname = @[NSBundleLocalizedString(@"上车点"),NSBundleLocalizedString(@"下车点"),NSBundleLocalizedString(@"座位号"),NSBundleLocalizedString(@"价  格"),NSBundleLocalizedString(@"预计到达"),NSBundleLocalizedString(@"预定时间"),NSBundleLocalizedString(@"支付时间"),NSBundleLocalizedString(@"订单号"),NSBundleLocalizedString(@"订单编号"),NSBundleLocalizedString(@"订单状态")];
    
    NSArray *arrvalue = @[tmodel.pickup_info,tmodel.drop_off_info,tmodel.seat_codes,tmodel.amount_booking,tmodel.arrival_date,tmodel.created_date,tmodel.order_pay_time,tmodel.code,tmodel.order_code,tmodel.order_statusString];
    UIView *viewlast=viewline;
    for(int i = 0 ; i < arrname.count; i++)
    {
        UIView *viewitem = [[UIView alloc] init];
        [scvback addSubview:viewitem];
        [viewitem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(0);
            make.width.equalTo(scvback);
            make.top.equalTo(viewlast.mas_bottom);
            make.height.offset(60);
            
        }];
        BOOL isline = YES;
        BOOL isjiachu = NO;
        ///需要去设置lbValueitem的值
        UILabel *lbValueitem = [self drawitemView:viewitem andname:arrname[i] andisline:isline andisjiachuline:isjiachu];
        [lbValueitem setText:arrvalue[i]];
        if(i==9)
        {///申请退款 2退款，1支付 其他不显示
            UIButton *btitem = [[UIButton alloc] init];
            [btitem setBackgroundColor:UIColorFromHex(0x56b157)];
            [btitem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btitem.titleLabel setFont:[UIFont systemFontOfSize:14]];
            [btitem.layer setMasksToBounds:YES];
            [btitem.layer setCornerRadius:2];
            [btitem setHidden:YES];
            if(tmodel.order_status.intValue == 1)
            {///支付
                [btitem setTitle:NSBundleLocalizedString(@"支付") forState:UIControlStateNormal];
                [btitem setTag:1];
                [btitem setHidden:NO];
            }
            else if (tmodel.order_status.intValue == 2)
            {
                [btitem setTag:2];
                [btitem setTitle:NSBundleLocalizedString(@"申请退款") forState:UIControlStateNormal];
                [btitem setHidden:NO];
            }
            [btitem addTarget:self action:@selector(payOrBackAction:) forControlEvents:UIControlEventTouchUpInside];
            [viewitem addSubview:btitem];
            [btitem mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.sizeOffset(CGSizeMake(100, 30));
                make.centerY.equalTo(viewitem);
                make.right.equalTo(viewitem).offset(-15);
            }];
        }
        viewlast = viewitem;
        if(i==0)
        {
            if(tmodel.pickup_surcharge.intValue>0)
            {
                UILabel *lb = [[UILabel alloc] init];
                [lb setText:tmodel.pickup_points_price_txt_c];
                if([NSBundle getLanguagekey] == LanguageVI)
                {
                    [lb setText:tmodel.pickup_points_price_txt_v];
                }else if([NSBundle getLanguagekey] == LanguageEN)
                {
                    [lb setText:tmodel.pickup_points_price_txt_e];
                }
                
                [lb setTextColor:RGB(120, 120, 120)];
                [lb setTextAlignment:NSTextAlignmentLeft];
                [lb setFont:[UIFont systemFontOfSize:13]];
                [lb setNumberOfLines:0];
                [scvback addSubview:lb];
                [lb mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.offset(15);
                    make.top.equalTo(viewitem.mas_bottom).offset(5);
                    make.right.equalTo(viewitem).offset(-15);
                }];
                UIView *viewline = [[UIView alloc] init];
                [viewline setBackgroundColor:RGB(234, 234, 234)];
                [scvback addSubview:viewline];
                [viewline mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.offset(15);
                    make.width.equalTo(viewitem.mas_width).offset(-30);
                    make.top.equalTo(lb.mas_bottom);
                    make.height.offset(1);
                    
                }];
                viewlast = viewline;
            }
            
        }
        else if (i==1)
        {
            if(tmodel.drop_off_surcharge.intValue>0)
            {
                UILabel *lb = [[UILabel alloc] init];
                [lb setText:tmodel.drop_off_points_price_txt_c];
                if([NSBundle getLanguagekey] == LanguageVI)
                {
                    [lb setText:tmodel.drop_off_points_price_txt_v];
                }else if([NSBundle getLanguagekey] == LanguageEN)
                {
                    [lb setText:tmodel.drop_off_points_price_txt_e];
                }
                
                [lb setTextColor:RGB(120, 120, 120)];
                [lb setTextAlignment:NSTextAlignmentLeft];
                [lb setFont:[UIFont systemFontOfSize:13]];
                [lb setNumberOfLines:0];
                [scvback addSubview:lb];
                [lb mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.offset(15);
                    make.top.equalTo(viewitem.mas_bottom).offset(5);
                    make.right.equalTo(viewitem).offset(-15);
                }];
                UIView *viewline = [[UIView alloc] init];
                [viewline setBackgroundColor:RGB(234, 234, 234)];
                [scvback addSubview:viewline];
                [viewline mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.offset(15);
                    make.width.equalTo(viewitem.mas_width).offset(-30);
                    make.top.equalTo(lb.mas_bottom);
                    make.height.offset(1);
                    
                }];
                viewlast = viewline;
            }
            
        }
        
        
    }
    
    UIView *viewlianxiren = [[UIView alloc] init];
    [viewlianxiren setBackgroundColor:RGB(242, 244, 245)];
    [scvback addSubview:viewlianxiren];
    [viewlianxiren mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(viewlast);
        make.top.equalTo(viewlast.mas_bottom);
        make.height.offset(60);
    }];
    UILabel *lblianxiren = [[UILabel alloc] init];
    [lblianxiren setText:NSBundleLocalizedString(@"联系人信息")];
    [lblianxiren setTextColor:RGB(120, 120, 120)];
    [lblianxiren setTextAlignment:NSTextAlignmentLeft];
    [lblianxiren setFont:[UIFont systemFontOfSize:14]];
    [viewlianxiren addSubview:lblianxiren];
    [lblianxiren mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.top.bottom.equalTo(viewlianxiren);
    }];
    
    ///联系人信息
    NSArray *arrname1 = @[NSBundleLocalizedString(@"联系人"),NSBundleLocalizedString(@"手机号"),@"Email"];
    NSArray *arrvalue1 = @[tmodel.name,tmodel.phone,tmodel.email];
    for(int i = 0 ; i < arrname1.count; i++)
   {
       UIView *viewitem = [[UIView alloc] init];
       [scvback addSubview:viewitem];
       [viewitem mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.offset(0);
           make.width.equalTo(scvback);
           make.top.equalTo(viewlianxiren.mas_bottom).offset(60*i);
           make.height.offset(60);
           
       }];
       
       
       BOOL isline = YES;
       BOOL isjiachu = NO;
       ///需要去设置lbValueitem的值
       UILabel *lbValueitem = [self drawitemView:viewitem andname:arrname1[i] andisline:isline andisjiachuline:isjiachu];
       [lbValueitem setText:arrvalue1[i]];
       viewlast = viewitem;
   }
    
    [scvback mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(viewlast.mas_bottom).offset(10);
    }];
    
}

///高度一般60 isjiacl:加粗线
-(UILabel *)drawitemView:(UIView *)view andname:(NSString *)strname andisline:(BOOL)isline andisjiachuline:(BOOL)isjiacl
{
    
    UILabel *lbname = [[UILabel alloc] init];
    [lbname setText:strname];
    [lbname setTextColor:RGB(120, 120, 120)];
    [lbname setTextAlignment:NSTextAlignmentLeft];
    [lbname setFont:[UIFont systemFontOfSize:12]];
    [lbname setNumberOfLines:2];
    [view addSubview:lbname];
    [lbname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.top.offset(10);
        make.height.offset(40);
        make.width.mas_equalTo(@80);
    }];
    
    
    UILabel *lbValue = [[UILabel alloc] init];
    [lbValue setTextColor:RGB(50, 50, 50)];
    [lbValue setTextAlignment:NSTextAlignmentLeft];
    [lbValue setFont:[UIFont systemFontOfSize:14]];
    [lbValue setNumberOfLines:2];
    [view addSubview:lbValue];
    [lbValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@100);
        make.top.equalTo(lbname);
        make.height.offset(40);
        make.right.equalTo(view).offset(-15);
    }];
    
    
    if(isline)
    {
        UIView *viewline = [[UIView alloc] init];
        [viewline setBackgroundColor:RGB(234, 234, 234)];
        [view addSubview:viewline];
        [viewline mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.width.equalTo(view.mas_width).offset(-30);
            make.bottom.equalTo(view.mas_bottom);
            if(isjiacl)
            {
                make.height.offset(2);
            }
            else
            {
                make.height.offset(1);
            }
            
        }];
    }
    
    return lbValue;
}

-(void)payOrBackAction:(UIButton *)sender
{
    [self.delegate tviewActionBack:sender.tag];

}


@end
