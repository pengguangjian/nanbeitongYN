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
}
@property (nonatomic, weak) MyTabBar *customTabBar;
@end

@implementation BaseTabBarVC
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    if(recttabbar.origin.y>0)
    {
        self.tabBar.frame = recttabbar;
    }
//    else
//    {
//        if([NSBundle getLanguagekey] == LanguageZH)
//        {
//            recttabbar = self.tabBar.bounds;
//        }
//        else
//        {
//            recttabbar = CGRectMake(self.tabBar.origin.x, self.tabBar.origin.y-10, self.tabBar.size.width, self.tabBar.size.height+10);
//        }
//    }
    for (UIView *subView in self.tabBar.subviews) {
            // UITabBarButton私有API, 普通开发者不能使用
            if ([subView isKindOfClass:[UIControl class]]) {
                // 判断如果子控件时UITabBarButton, 就删除
                [subView removeFromSuperview];
            }
        }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if([NSBundle getLanguagekey] == LanguageZH)
    {
        recttabbar = self.tabBar.bounds;
    }
    else
    {
        recttabbar = CGRectMake(self.tabBar.origin.x, self.tabBar.origin.y-10, self.tabBar.size.width, self.tabBar.size.height+10);
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // 创建自定义tabBar
        MyTabBar *customTabBar = [[MyTabBar alloc] init];
        [customTabBar setBackgroundColor:RGB(245, 244, 243)];
        customTabBar.frame=self.tabBar.bounds;
        [self.tabBar addSubview:customTabBar];
        self.customTabBar = customTabBar;
        customTabBar.delegate = self;
        
        [self setupChridViewController:[[HomeVC alloc] init] title:NSBundleLocalizedString(@"首页") normalImage:@"home" selectedImage:@"home_wei"];
        
        [self setupChridViewController:[[LogisticsVC alloc] init] title:NSBundleLocalizedString(@"物流") normalImage:@"logistics" selectedImage:@"logistics_wei"];
        
        [self setupChridViewController:[[OlderListVC alloc] init] title:NSBundleLocalizedString(@"订单") normalImage:@"older" selectedImage:@"older_wei"];
        
        [self setupChridViewController:[[BusinessVC alloc] init] title:NSBundleLocalizedString(@"商旅") normalImage:@"Business" selectedImage:@"Business_wei"];
        
        [self setupChridViewController:[[MineVC alloc] init] title:NSBundleLocalizedString(@"我的") normalImage:@"mine" selectedImage:@"mine_wei"];
        
    });
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // 遍历系统的tabbar移除不需要的控件
    NSLog(@"%@",self.tabBar.subviews);
    for (UIView *subView in self.tabBar.subviews) {
        // UITabBarButton私有API, 普通开发者不能使用
        if ([subView isKindOfClass:[UIControl class]]) {
            // 判断如果子控件时UITabBarButton, 就删除
            [subView removeFromSuperview];
        }
        
//        NSString * classname = NSStringFromClass([subView class]);
//        if ([classname isEqualToString:@"_UIBarBackground"] )
//        {
//            [subView setHidden:YES];
//        }
    }
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
