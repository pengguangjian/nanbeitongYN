//
//  BaseTabBarVC.m
//  TicketAPP
//
//  Created by macbook on 2019/6/25.
//  Copyright © 2019年 macbook. All rights reserved.
//

#import "BaseTabBarVC.h"
#import "HomeVC.h"
#import "MineVC.h"
#import "OlderListVC.h"
#import "BusinessVC.h"
#import "LogisticsVC.h"

#import "MyTabBar.h"

@interface BaseTabBarVC ()<MyTabBarDelegate>
{
    CGRect recttabbar;
    BOOL isload;
}
@property (nonatomic, weak) MyTabBar *customTabBar;
@end

@implementation BaseTabBarVC
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    if(recttabbar.size.height==0)
    {
        float ftemptab = self.tabBar.size.height;
        float ftemptabY = self.tabBar.frame.origin.y;
        if([NSBundle getLanguagekey] == LanguageZH)
        {
            recttabbar = CGRectMake(0, ftemptabY, DEVICE_Width, ftemptab);
        }
        else
        {
            recttabbar = CGRectMake(0, ftemptabY-10, DEVICE_Width, ftemptab+10);
        }
        
    }
    if(!(self.tabBar.frame.origin.y==recttabbar.origin.y && self.tabBar.frame.size.height == recttabbar.size.height))
    {
        self.tabBar.frame = recttabbar;
    }
    if(isload==NO)
    {
        isload = YES;
        [self setTabBarVC];
    }
    
    for (UIView *subView in self.tabBar.subviews) {
            // UITabBarButton私有API, 普通开发者不能使用
            if ([subView isKindOfClass:[UIControl class]]) {
                // 判断如果子控件时UITabBarButton, 就删除
                [subView removeFromSuperview];
            }
        }
}

-(void)setTabBarVC
{
    
//    //Tabbar 未选中颜色
//    if ([UIDevice currentDevice].systemVersion.floatValue < 10.0) {
//        [UITabBar appearance].tintColor = UIColorFromHex(0x6d6d6d);
//    } else {
//        [UITabBar appearance].unselectedItemTintColor = UIColorFromHex(0x6d6d6d);
//    }
//    [UITabBar appearance].selectedImageTintColor = UIColorFromHex(0x56b157);
    
    // 创建自定义tabBar
    MyTabBar *customTabBar = [[MyTabBar alloc] init];
    [customTabBar setBackgroundColor:RGB(245, 244, 243)];
    customTabBar.frame=CGRectMake(0, 0, DEVICE_Width, self.tabBar.frame.size.height);
    [self.tabBar addSubview:customTabBar];
    self.customTabBar = customTabBar;
    customTabBar.delegate = self;
    
    [self setupChridViewController:[[HomeVC alloc] init] title:NSBundleLocalizedString(@"首页") normalImage:@"home" selectedImage:@"home_wei"];
    
    [self setupChridViewController:[[LogisticsVC alloc] init] title:NSBundleLocalizedString(@"物流") normalImage:@"logistics" selectedImage:@"logistics_wei"];
    
    [self setupChridViewController:[[OlderListVC alloc] init] title:NSBundleLocalizedString(@"订单") normalImage:@"older" selectedImage:@"older_wei"];
    
    [self setupChridViewController:[[BusinessVC alloc] init] title:NSBundleLocalizedString(@"商旅") normalImage:@"Business" selectedImage:@"Business_wei"];
    
    [self setupChridViewController:[[MineVC alloc] init] title:NSBundleLocalizedString(@"我的") normalImage:@"mine" selectedImage:@"mine_wei"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // 遍历系统的tabbar移除不需要的控件
//    NSLog(@"%@",self.tabBar.subviews);
//    for (UIView *subView in self.tabBar.subviews) {
//        // UITabBarButton私有API, 普通开发者不能使用
//        if ([subView isKindOfClass:[UIControl class]]) {
//            // 判断如果子控件时UITabBarButton, 就删除
//            [subView removeFromSuperview];
//        }
////        NSString * classname = NSStringFromClass([subView class]);
////        if ([classname isEqualToString:@"_UIBarBackground"] )
////        {
////            [subView setHidden:YES];
////        }
//    }
}

#pragma mark - IWTabBarD·elegate
- (void)tabBar:(MyTabBar *)tabBar selectedButtonfrom:(NSInteger)from to:(NSInteger)to
{
  
    NSLog(@"从第%ld控制器切换到第%ld控制器",(long)from,(long)to);
   
    // 切换控制器
    self.selectedIndex = to;

}


- (void)setupChridViewController:(UIViewController *)vc title:(NSString *)title normalImage:(NSString *)normalImage selectedImage:(NSString *)selectedImage{
    self.tabBarController.tabBar.tintColor = UIColorFromHex(0xffffff);
    vc.title = title;
    if (normalImage.length && selectedImage.length )
    {
        vc.tabBarItem.image = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ;
        vc.tabBarItem.selectedImage = [[UIImage imageNamed:normalImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ;
    }
    
    BaseNavigationController * navVC=[[BaseNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:navVC];
    // 3.调用自定义tabBar的添加按钮方法, 创建一个与当前控制器对应的按钮
    [self.customTabBar addTabBarButton: vc.tabBarItem];
    
}

@end
