
//
//  BaseViewController.m
//  
//
//  Created 
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)dealloc{
    NSLog(@"dealloc-%@",[self class]);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.navigationController.viewControllers.count>1) {
        self.tabBarController.tabBar.hidden = YES;
    }
     self.automaticallyAdjustsScrollViewInsets = NO;

}


-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
}


@end
