//
//  TicketBookVC.m
//  TicketAPP
//
//  Created by 肖世恒 on 2019/7/30.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "TicketBookVC.h"
#import "SelectPayTypeVC.h"
#import "DHSelectSeatView.h"
#import "ContactListVC.h"
#import "SeatObj.h"
#import "ContactObj.h"
#import "GetOnOffListVC.h"
#import "BusCompanyInfoVC.h"
#import "GetOnOffObj.h"

@interface TicketBookVC ()

{
    NSArray *selectSeatArr;
    ContactObj *selectCo;
    
    GetOnOffObj *getOnObj;
    GetOnOffObj *getOffObj;
}
@property (weak, nonatomic) IBOutlet UILabel *zhan;
@property (weak, nonatomic) IBOutlet UILabel *paiojia;
@property (weak, nonatomic) IBOutlet UITextField *number;
@property (weak, nonatomic) IBOutlet UILabel *orderpr;
@property (weak, nonatomic) IBOutlet UILabel *pipoNuber;
@property (strong, nonatomic) IBOutlet UIView *contactBgView;

@property (nonatomic,strong) NSString *XLnumber;

@end

@implementation TicketBookVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.getOffTextField.keyboardType = UIKeyboardTypeASCIICapable;
    self.getOnTextField.placeholder = LS(@"请输入其他上车点1");
    self.getOffTextField.placeholder = LS(@"请输入其他下车点1");
     //监听输入内容
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFiledEditChanged:)
                                                 name:@"UITextFieldTextDidChangeNotification"
                                               object:self.getOffTextField];
    
    
    self.view.backgroundColor =  UIColorFromHex(0xf6f6f6);
    
    self.XLnumber = @"1";
    
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    NSDate *date = [formatter dateFromString:self.model.setout_time];
//    NSDateFormatter *formatterddd = [[NSDateFormatter alloc] init];
//    [formatterddd setDateFormat:@"MM-dd HH:mm"];
//    NSString *oneDayStr = [formatterddd stringFromDate:date];
    
    NSString *chufa = NSBundleLocalizedString(@"出发");
    NSString *titStr = [NSString stringWithFormat:@"%@%@",self.model.setout_time,chufa];
    self.navigationItem.title = titStr;
    
    NSString *zhannaem = [NSString stringWithFormat:@"%@-%@",self.model.start_name,self.model.end_name];
    
    self.zhan.text = zhannaem;
    
//    NSString *piaojia = NSBundleLocalizedString(@"票价");
//    NSString *jiage = [NSString stringWithFormatPrice:self.model.price];
//    NSString *pajial = [NSString stringWithFormat:@"%@%@",piaojia,jiage];
//    self.paiojia.text = pajial;
    
    NSInteger hour = [_model.duration integerValue]/60;
    NSInteger minute = [_model.duration integerValue]%60;
    NSString *totalTimeStr = [NSString stringWithFormat:@"%@：",LS(@"全程时间")];
    if (hour>0) {
        totalTimeStr = [totalTimeStr stringByAppendingFormat:@"%zi%@", hour,LS(@"小时")];
    }
    if (minute>0) {
        totalTimeStr = [totalTimeStr stringByAppendingFormat:@"%zi%@", minute,LS(@"分钟")];
    }
    self.paiojia.text = totalTimeStr;
    
    WEAK_SELF;
    self.number.text = self.XLnumber;
    self.number.yb_inputCP = YBInputControlProfile.creat.set_textControlType(YBTextControlType_number).set_textChanged(^(UITextField *field){
        
        weakSelf.XLnumber = field.text;
        [weakSelf upddddd];
        
    });
   
    [XBUtils setViewBorderRadius:self.number Radius:16];
    
    [self upddddd];
    
    self.name.textColor = DEFAULTCOLOR1;
    self.phoneAndEmail.textColor = COL2;
    self.phoneAndEmailViewHeight.constant = 0.0f;
    self.contactView.hidden = YES;
    
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.frame = CGRectMake(0, 0 , DEVICE_Width-30, self.contactBgView.frame.size.height);
    layer.backgroundColor   = [UIColor clearColor].CGColor;

    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:layer.frame cornerRadius:3.0f];
    layer.path             = path.CGPath;
    layer.lineWidth         = 1.0f;
    layer.lineDashPattern    = @[@4, @4];
    layer.fillColor          = [UIColor clearColor].CGColor;
    layer.strokeColor       = DEFAULTCOLOR1.CGColor;

    [self.contactBgView.layer addSublayer:layer];
    
    [self setIsShowGetOnInputView:NO];
    [self setIsShowGetOffInputView:NO];
    
    _seatDestLabel.text = LS(@"请选择座位号");
    _connectDescLabel.text = LS(@"请选择联系人");
    _connectDescLabel1.text = LS(@"用于发送购物信息");
    _getOnDescLabel1.text = LS(@"请选择上车点");
    _memoDescLabel.text = LS(@"备注");
    _getOffDescLabel2.text = LS(@"备注");
    _getOffDescLabel1.text = LS(@"请选择下车点");
    _busDescLabel.text = LS(@"汽车运营信息");
}

- (void)textFiledEditChanged:(NSNotification*)notification {

    UITextField *textField = notification.object;
    NSString *str = textField.text;
    for (int i = 0; i<str.length; i++) {

        NSString*string = [str substringFromIndex:i];
        NSString *regex = @"[\u4e00-\u9fa5]{0,}$"; // 中文
        // 2、拼接谓词
        NSPredicate *predicateRe1 = [NSPredicate predicateWithFormat:@"self matches %@", regex];
        // 3、匹配字符串
        BOOL resualt = [predicateRe1 evaluateWithObject:string];

        if (resualt) {
            //是中文替换为空字符串
            str =  [str stringByReplacingOccurrencesOfString:[str substringFromIndex:i] withString:@""];
        }
    }
    textField.text = str;

}


//更新票价 和人数
//- (void)upddddd{
//
//    CGFloat danjia = [self.model.price floatValue];
//    NSInteger piponumber = [self.XLnumber integerValue];
//    NSString *numdd = [NSString stringWithFormat:@"%lf",danjia*piponumber];
//    self.orderpr.text = [NSString stringWithFormatPrice:numdd];
//
//    NSString *gong = NSBundleLocalizedString(@"共");
//    NSString *ren = NSBundleLocalizedString(@"人");
//    NSString *pipoddd = [NSString stringWithFormat:@"%@%@%@",gong,self.XLnumber,ren];
//    self.pipoNuber.text = pipoddd;
//
//
//}

- (void)upddddd{
    
    if (selectSeatArr && selectSeatArr.count>0) {
        
        double totalPrice = 0;
        for (SeatObj *so in selectSeatArr) {
            so.price = [so.price stringByReplacingOccurrencesOfString:@"," withString:@""];
            totalPrice += [so.price doubleValue];
        }
        if(getOffObj)
        {
            if(getOffObj.surcharge_type.intValue == 2)
            {
                
                totalPrice += [getOffObj.surcharge doubleValue];
            }
        }
        if(getOnObj)
        {
            if(getOnObj.surcharge_type.intValue == 2)
            {
                
                totalPrice += [getOnObj.surcharge doubleValue];
            }
        }
        
        NSString *numdd = [NSString stringWithFormat:@"%.0lf",totalPrice];
        self.orderpr.text = [NSString stringWithFormatPrice:numdd];
        
        NSString *gong = NSBundleLocalizedString(@"共");
        NSString *ren = NSBundleLocalizedString(@"人");
        NSString *pipoddd = [NSString stringWithFormat:@"%@%zi%@",gong,selectSeatArr.count,ren];
        
        self.pipoNuber.text = pipoddd;
        
    } else {
        
        self.orderpr.text = [NSString stringWithFormatPrice:@"0"];
        
        NSString *gong = NSBundleLocalizedString(@"共");
        NSString *ren = NSBundleLocalizedString(@"人");
        NSString *pipoddd = [NSString stringWithFormat:@"%@0%@",gong,ren];
        self.pipoNuber.text = pipoddd;
    }
}

- (IBAction)clickJJJ:(id)sender {
    NSInteger number =  [self.XLnumber integerValue];
    if(NO){
        //不是数字 结束
        return;
    }
    number ++ ;
    NSString *numbernew = [NSString stringWithFormat:@"%i",number];
    self.number.text = numbernew;
    self.XLnumber = numbernew;
    
    [self upddddd];
}
- (IBAction)clickJIAN:(id)sender {
    NSInteger number =  [self.XLnumber integerValue];
    if(NO){
        //不是数字 结束
        return;
    }
    number -- ;
    if(number == 0){
        //最后结果 = 0 结束
        return;
    }
    NSString *numbernew = [NSString stringWithFormat:@"%i",number];
    self.number.text = numbernew;
    self.XLnumber = numbernew;
    
    [self upddddd];
}

#pragma mark - 提交订单
- (IBAction)playeOK:(id)sender {
    
    [self.view endEditing:YES];
    
    if((!(selectSeatArr.count>0))){
        [MBManager showBriefAlert:NSBundleLocalizedString(@"请选择座位")];
        return;
    }
    
    if(!selectCo){
        [MBManager showBriefAlert:NSBundleLocalizedString(@"请选择联系人")];
        return;
    }
    
    if(!getOnObj)
    {
        [MBManager showBriefAlert:NSBundleLocalizedString(@"请选择上车点")];
        return;
    }
    if(!getOffObj)
    {
        [MBManager showBriefAlert:NSBundleLocalizedString(@"请选择下车点")];
        return;
    }
    if([self->getOffObj.unfixed_point intValue] == 1 && _getOffTextField.text.length==0)
    {
        [MBManager showBriefAlert:NSBundleLocalizedString(@"请输入下车点备注")];
        return;
    }
    if([self->getOnObj.unfixed_point intValue] == 1 && _getOnTextField.text.length==0)
    {
        [MBManager showBriefAlert:NSBundleLocalizedString(@"请输入上车点备注")];
        return;
    }
    
    [SVProgressHUD showWithStatus:LS(@"车位预约中")];
    
    
    WEAK_SELF;
//    [AFHTTP requestAddticketorderStation_begin:self.start_id station_end:self.end_id price:self.model.price setout_time:self.model.setout_time count_ticket:self.XLnumber success:^(NSDictionary *dic){
//
//
//        NSString *order_id = dic[@"order_id"];
//        if(kStringIsEmpty(order_id)){
//            //下单成功
//            [weakSelf requestPaymentorder_id:order_id];
//        }
//
//    }];
    
    HttpManager *hm = [HttpManager createHttpManager];
    
    hm.responseHandler = ^(id responseObject) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            ResponseData *rd = [ResponseData mj_objectWithKeyValues:responseObject];
            [SVProgressHUD dismiss];
            
            if ([rd.code isEqualToString:SUCCESS] ) {
                
                NSLog(@"");
                NSString *order_id = [rd.data objectForKey:@"order_id"];//[rd.data objectForKey:@"order_code"];
                if(kStringIsEmpty(order_id)){
                    //下单成功
                    [weakSelf requestPaymentorder_id:order_id];
                }
                
            } else {
                [SVProgressHUD showErrorWithStatus:rd.msg];
            }
        });
    };
    
    NSMutableDictionary *dataDic = [[NSMutableDictionary alloc] init];
    [dataDic setObject:_model.ID forKey:@"trip_code"];
    [dataDic setObject:_seatLabel.text forKey:@"seats"];
    
    [dataDic setObject:selectCo.id forKey:@"contact_id"];
    if (getOnObj) {
        [dataDic setObject:getOnObj.id forKey:@"Pickup_id"];
        [dataDic setObject:getOnObj.name forKey:@"pickup"];
        if(getOnObj.muUserAddress.length>0)
        {
            [dataDic setObject:[NSString stringWithFormat:@"%@-%@", getOnObj.name,getOnObj.muUserAddress] forKey:@"pickup"];
        }
    }
    if (getOffObj) {
        [dataDic setObject:getOffObj.id forKey:@"drop_off_point_id"];
        [dataDic setObject:getOffObj.name forKey:@"drop_off_info"];
        if(getOffObj.muUserAddress.length>0)
        {
            [dataDic setObject:[NSString stringWithFormat:@"%@-%@",getOffObj.name,getOffObj.muUserAddress] forKey:@"drop_off_info"];
        }
    }
    
//    if(self.getOffTextField.text.length>0)
//    {
//        [dataDic setObject:self.getOffTextField.text forKey:@"pickup"];
//    }
//    if(self.getOnTextField.text.length>0)
//    {
//        [dataDic setObject:self.getOnTextField.text forKey:@"drop_off_info"];
//    }
    
    [hm getRequetInterfaceData:dataDic withInterfaceName:@"api/ticketorder/ordersubmit"];
}

- (void)requestPaymentorder_id:(NSString *)order_id{
    
    PaymentWebViewController *vc = [[PaymentWebViewController alloc]init];
    vc.order_id = order_id;
    vc.order_type = @"1";
    [self.navigationController pushViewController:vc animated:YES];
    
    //选择微信支付宝支付EnsurePayVC
    
//    SelectPayTypeVC *vc = [[SelectPayTypeVC alloc] initWithNibName:@"SelectPayTypeVC" bundle:nil];
//    vc.order_id = order_id;
//    vc.order_type = @"1";
//    vc.isFromTicket = YES;
//    [self.navigationController pushViewController:vc animated:YES];

}


- (IBAction)selectSeatBtnOnTouch:(id)sender {
    
    if ([_model.unchoosable intValue] != 0) {
        
        NSString *message = LS(@"根据公交运营商的要求，提早去公交车站的顾客可以选择自己的座位。");
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:LS(@"温馨提示") message:message preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:LS(@"我已知晓") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            [self toSelectSeat];
            
        }]];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    } else {
        [self toSelectSeat];
    }
    
    
}

#pragma mark - 选择座位
- (void)toSelectSeat {
    
    
    DHSelectSeatView *selectSeatView = [DHSelectSeatView sharedView:_model.ID andNoMoSelect:selectSeatArr];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:selectSeatView];
    
    __block __typeof(self)bself = self;
    selectSeatView.handler = ^(NSArray *selectArr) {
        
        self->selectSeatArr = selectArr;
        
        NSString *seatStr = nil;
        for (SeatObj *so in self->selectSeatArr) {
            if (so.seat_code) {
                if (seatStr) {
                    seatStr = [seatStr stringByAppendingString:@","];
                    seatStr = [seatStr stringByAppendingString:so.seat_code];
                } else {
                    seatStr = so.seat_code;
                }
            }
        }
        
        if(![self->_seatLabel.text isEqualToString:seatStr])
        {
            self->getOnObj = nil;
            self->getOffObj = nil;
            self->_getOffLabel.text = @"";
            self->_getOnLabel.text = @"";
            ///调整价格
            [self upddddd];
            [self setIsShowGetOffInputView:NO];
            [self setIsShowGetOnInputView:NO];
        }
        self->_seatLabel.text = seatStr;
        
        [bself upddddd];
        
    };
    [selectSeatView show];
    
}

- (IBAction)selectContactBtnOnTouch:(id)sender {
    
    WEAK_SELF;
    ContactListVC *contactListVC = [[ContactListVC alloc] init];
    [contactListVC setStartSelectSuccessBlock:^(ContactObj *co){
        NSLog(@"");
        self->selectCo = co;
        self.phoneAndEmailViewHeight.constant = 40.0f;
        self.contactView.hidden = NO;
        self.name.text = co.name;
        self.phoneAndEmail.text = [NSString stringWithFormat:@"%@：%@  %@：%@",LS(@"电话"),co.phone,LS(@"邮箱"),co.email];
    }];
    [self.navigationController pushViewController:contactListVC animated:YES];
    
}

#pragma mark - 选择下车点
- (IBAction)getOffBtnOnTouch:(id)sender {
    
    if(selectSeatArr.count==0)
    {
        [SVProgressHUD showInfoWithStatus:LS(@"请先选择座位")];
        
        return;
    }
    
    GetOnOffListVC *vc = [[GetOnOffListVC alloc] initWithNibName:@"GetOnOffListVC" bundle:nil];
    vc.trip_id = _model.ID;
    vc.titleStr = LS(@"请选择下车点");
    vc.pipoCount = selectSeatArr.count;
    vc.getOffHander = ^(id  _Nonnull obj) {
        self->getOffObj = obj;
        
        NSArray *componds = [self->getOffObj.real_time componentsSeparatedByString:@" "];
        self->_getOffLabel.text = [NSString stringWithFormat:@"%@ %@",[componds firstObject], self->getOffObj.name];
        if(self->getOffObj.address.length>0)
        {
            self->_getOffLabel.text = [NSString stringWithFormat:@"%@ %@-%@",[componds firstObject], self->getOffObj.name,self->getOffObj.address];
        }
        if([NSBundle getLanguagekey] == LanguageEN)
        {
            if(self->getOffObj.english_name.length>0)
            {
                self->_getOffLabel.text = [NSString stringWithFormat:@"%@ %@",[componds firstObject], self->getOffObj.english_name];
                if(self->getOffObj.address_name.length>0)
                {
                    self->_getOffLabel.text = [NSString stringWithFormat:@"%@ %@-%@",[componds firstObject], self->getOffObj.english_name,self->getOffObj.address_name];
                }
            }
            
        }
        
//        if(self->getOffObj.muUserAddress.length>0)
//        {
//
//            self->_getOffLabel.text = [NSString stringWithFormat:@"%@ %@-%@",[componds firstObject], self->getOffObj.name,self->getOffObj.muUserAddress];
//            if([NSBundle getLanguagekey] == LanguageEN)
//            {
//                if(self->getOffObj.english_name.length>0)
//                {
//                    self->_getOffLabel.text = [NSString stringWithFormat:@"%@ %@-%@",[componds firstObject], self->getOffObj.english_name,self->getOffObj.muUserAddress];
//                }
//
//            }
//        }
        if(self->getOffObj.surcharge.intValue>0)
        {
            NSString *strtemp = self->_getOffLabel.text;
            NSString *strtempwrite = [NSString stringWithFormat:@"%@-%@",strtemp,self->getOffObj.additional_fee_type_txt_c];
            if([NSBundle getLanguagekey] == LanguageVI)
            {
                strtempwrite = [NSString stringWithFormat:@"%@-%@",strtemp,self->getOffObj.additional_fee_type_txt_v];
            }
            else if([NSBundle getLanguagekey] == LanguageEN)
            {
                strtempwrite = [NSString stringWithFormat:@"%@-%@",strtemp,self->getOffObj.additional_fee_type_txt_e];
            }
            self->_getOffLabel.text = strtempwrite;
        }
        
        NSString *strtemp = self->_getOffLabel.text;
        if([NSString nullToString:self->getOffObj.min_customer].length>0 && ![self->getOffObj.min_customer isEqualToString:@"0"])
        {
            if(strtemp.length>0)
            {
                
                if([NSBundle getLanguagekey] == LanguageVI)
                {
                    strtemp = [NSString stringWithFormat:@"%@\nChỉ đón từ %@ khách trở lên",strtemp,self->getOffObj.min_customer];
                }
                else if([NSBundle getLanguagekey] == LanguageEN)
                {
                    strtemp = [NSString stringWithFormat:@"%@\nPick up from more than %@ guests",strtemp,self->getOffObj.min_customer];
                }
                else
                {
                    strtemp = [NSString stringWithFormat:@"%@\n%@名顾客以上才接送",strtemp,self->getOffObj.min_customer];
                }
            }
            else
            {
                
                if([NSBundle getLanguagekey] == LanguageVI)
                {
                    strtemp = [NSString stringWithFormat:@"Chỉ đón từ %@ khách trở lên",self->getOffObj.min_customer];
                }
                else if([NSBundle getLanguagekey] == LanguageEN)
                {
                    strtemp = [NSString stringWithFormat:@"Pick up from more than %@ guests",self->getOffObj.min_customer];
                }
                else
                {
                    strtemp = [NSString stringWithFormat:@"%@名顾客以上才接送",self->getOffObj.min_customer];
                }
            }
            
            self->_getOffLabel.text =  strtemp;
        }
        
        ///调整价格
        [self upddddd];
        
        
        if ([self->getOffObj.unfixed_point intValue] == 1) {
            [self setIsShowGetOffInputView:YES];
            self.getOffTextField.text = self->getOffObj.muUserAddress;
        } else {
            [self setIsShowGetOffInputView:NO];
        }
        
    };
    [self.navigationController pushViewController:vc animated:YES];
    
}
#pragma mark - 选择上车点
- (IBAction)getOnBtnOnTouch:(id)sender {
    
    if(selectSeatArr.count==0)
    {
        [SVProgressHUD showInfoWithStatus:@"请先选择座位"];
        return;
    }
    
    GetOnOffListVC *vc = [[GetOnOffListVC alloc] initWithNibName:@"GetOnOffListVC" bundle:nil];
    vc.trip_id = _model.ID;
    vc.pipoCount = selectSeatArr.count;
    vc.titleStr = LS(@"请选择上车点");
    vc.getONHandler = ^(id  _Nonnull obj) {
        self->getOnObj = obj;
        
        NSArray *componds = [self->getOnObj.real_time componentsSeparatedByString:@" "];
        
        
        self->_getOnLabel.text = [NSString stringWithFormat:@"%@ %@",[componds firstObject], self->getOnObj.name];
        if(self->getOnObj.address.length>0)
        {
            self->_getOnLabel.text = [NSString stringWithFormat:@"%@ %@-%@",[componds firstObject], self->getOnObj.name,self->getOnObj.address];
        }
        if([NSBundle getLanguagekey] == LanguageEN)
        {
            if(self->getOnObj.english_name.length>0)
            {
                self->_getOnLabel.text = [NSString stringWithFormat:@"%@ %@",[componds firstObject], self->getOnObj.english_name];
                if(self->getOnObj.address_name.length>0)
                {
                    self->_getOnLabel.text = [NSString stringWithFormat:@"%@ %@-%@",[componds firstObject], self->getOnObj.english_name,self->getOnObj.address_name];
                }
            }
            
        }
        
//        if(self->getOnObj.muUserAddress.length>0)
//        {
//
//            self->_getOnLabel.text = [NSString stringWithFormat:@"%@ %@-%@",[componds firstObject], self->getOnObj.name,self->getOnObj.muUserAddress];
//
//            if([NSBundle getLanguagekey] == LanguageEN)
//            {
//                if(self->getOnObj.english_name.length>0)
//                {
//                    self->_getOnLabel.text = [NSString stringWithFormat:@"%@ %@-%@",[componds firstObject], self->getOnObj.english_name,self->getOnObj.muUserAddress];
//                }
//
//            }
//        }
        
        if(self->getOnObj.surcharge.intValue>0)
        {
            NSString *strtemp = self->_getOnLabel.text;
            NSString *strtempwrite = [NSString stringWithFormat:@"%@-%@",strtemp,self->getOnObj.additional_fee_type_txt_c];
            if([NSBundle getLanguagekey] == LanguageVI)
            {
                strtempwrite = [NSString stringWithFormat:@"%@-%@",strtemp,self->getOnObj.additional_fee_type_txt_v];
            }
            else if([NSBundle getLanguagekey] == LanguageEN)
            {
                strtempwrite = [NSString stringWithFormat:@"%@-%@",strtemp,self->getOnObj.additional_fee_type_txt_e];
            }
            
            self->_getOnLabel.text = strtempwrite;
        }
        
        NSString *strtemp = self->_getOnLabel.text;
        if([NSString nullToString:self->getOnObj.min_customer].length>0 && ![self->getOnObj.min_customer isEqualToString:@"0"])
        {
            if(strtemp.length>0)
            {
                
                if([NSBundle getLanguagekey] == LanguageVI)
                {
                    strtemp = [NSString stringWithFormat:@"%@\nChỉ đón từ %@ khách trở lên",strtemp,self->getOnObj.min_customer];
                }
                else if([NSBundle getLanguagekey] == LanguageEN)
                {
                    strtemp = [NSString stringWithFormat:@"%@\nPick up from more than %@ guests",strtemp,self->getOnObj.min_customer];
                }
                else
                {
                    strtemp = [NSString stringWithFormat:@"%@\n%@名开始接送",strtemp,self->getOnObj.min_customer];
                }
            }
            else
            {
                
                if([NSBundle getLanguagekey] == LanguageVI)
                {
                    strtemp = [NSString stringWithFormat:@"Chỉ đón từ %@ khách trở lên",self->getOnObj.min_customer];
                }
                else if([NSBundle getLanguagekey] == LanguageEN)
                {
                    strtemp = [NSString stringWithFormat:@"Pick up from more than %@ guests",self->getOnObj.min_customer];
                }
                else
                {
                    strtemp = [NSString stringWithFormat:@"%@名开始接送",self->getOnObj.min_customer];
                }
            }
            
            self->_getOnLabel.text =  strtemp;
        }
        
        ///调整价格
        [self upddddd];
        
        if ([self->getOnObj.unfixed_point intValue] == 1) {
            [self setIsShowGetOnInputView:YES];
            self.getOnTextField.text = self->getOnObj.muUserAddress;
        } else {
            [self setIsShowGetOnInputView:NO];
        }
        
    };
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - 汽车运营信息
- (IBAction)checkBusInfoBtnOnTouch:(id)sender {
    
    BusCompanyInfoVC *vc = [[BusCompanyInfoVC alloc] initWithNibName:@"BusCompanyInfoVC" bundle:nil];
    vc.trip_code = _model.trip_code;
    vc.company_id = _model.company_id;
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - 显示和影藏上下车点备注
- (void)setIsShowGetOnInputView:(BOOL)isShow {
    self.getOnTextField.text = nil;
    if (isShow) {
        self.getOnInputViewAlignTop.constant = 5;
        self.getOnInputViewHeight.constant = 50;
        self.getOnInputView.hidden = NO;
        self.getOnDescLabel.hidden = NO;
        self.getOnTextField.hidden = NO;
    } else {
        self.getOnInputViewAlignTop.constant = 0;
        self.getOnInputViewHeight.constant = 0;
        self.getOnInputView.hidden = YES;
        self.getOnDescLabel.hidden = YES;
        self.getOnTextField.hidden = YES;
    }
}

- (void)setIsShowGetOffInputView:(BOOL)isShow {
    self.getOffTextField.text = nil;
    if (isShow) {
        self.getOffInputViewAlignTop.constant = 5;
        self.getOffInputViewHeight.constant = 50;
        self.getOffInputView.hidden = NO;
        self.getOffDescLabel.hidden = NO;
        self.getOffTextField.hidden = NO;
    } else {
        self.getOffInputViewAlignTop.constant = 0;
        self.getOffInputViewHeight.constant = 0;
        self.getOffInputView.hidden = YES;
        self.getOffDescLabel.hidden = YES;
        self.getOffTextField.hidden = YES;
    }
}


@end
