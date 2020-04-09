//
//  ModifyThePwsVC.m
//  TicketAPP
//
//  Created by xiaoshiheng on 2019/8/13.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "ModifyThePwsVC.h"
#import "GGVerifyCodeViewBtn.h"

@interface ModifyThePwsVC ()

@property (weak, nonatomic) IBOutlet UITextField *iphoneTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;
@property (weak, nonatomic) IBOutlet UITextField *pwd2TF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet GGVerifyCodeViewBtn *codeBtn;

@end

@implementation ModifyThePwsVC


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = NSBundleLocalizedString(@"修改密码");
    
    UserModel *mode = [[UserInfo sharedInstance] fetchLoginUserInfo];
    
    self.iphoneTF.text = mode.account;
    self.iphoneTF.enabled = NO;
    
    self.pwdTF.secureTextEntry = YES;
    self.pwd2TF.secureTextEntry = YES;
    
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)clickCode:(id)sender {
    
    [self.view endEditing:YES];
    if(![XBUtils isPhone:self.iphoneTF.text]){
        [MBManager showBriefAlert:NSBundleLocalizedString(@"请输入手机号码")];
        return;
    }
    WEAK_SELF;
    [AFHTTP requestSmscodePhone:self.iphoneTF.text status:@"5" success:^(id responseObject){
        [weakSelf.codeBtn timeFailBeginFrom:60];
    }];
    
    
}

- (IBAction)clickquren:(id)sender {
    
    if(!kStringIsEmpty(self.pwdTF.text)){
        [MBManager showBriefAlert:NSBundleLocalizedString(@"请输入密码")];
        return;
    }
    if(![self.pwdTF.text isEqualToString:self.pwd2TF.text]){
        [MBManager showBriefAlert:NSBundleLocalizedString(@"两次密码不一致")];
        return;
    }
    if(![XBUtils isPhone:self.iphoneTF.text]){
        [MBManager showBriefAlert:NSBundleLocalizedString(@"请输入手机号码")];
        return;
    }
    if(!kStringIsEmpty(self.codeTF.text)){
        [MBManager showBriefAlert:NSBundleLocalizedString(@"请输入验证码")];
        return;
    }
    
    [self requestPasswordPhone];
}

- (void)requestPasswordPhone{
    
    WEAK_SELF;
    [AFHTTP requestforgetpasswordPhone:self.iphoneTF.text password_new:self.pwdTF.text verify_code:self.codeTF.text success:^(id responseObject) {
        
        [weakSelf onBack];
        [MBManager showBriefAlert:NSBundleLocalizedString(@"修改成功")];
        
    }];
    
    
}

@end
