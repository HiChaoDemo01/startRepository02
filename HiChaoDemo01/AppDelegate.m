//
//  AppDelegate.m
//  HiChaoDemo01
//
//  Created by Mac on 16/7/2.
//  Copyright © 2016年 surker. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]initWithFrame:kMainBounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //创建tabbarcontroll
    UITabBarController *tabBar = [[UITabBarController alloc]init];
    IntroduceVC *introduceVC = [IntroduceVC new];
    
    //设置tabBar的字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Helvetica" size:13],NSFontAttributeName,[UIColor lightGrayColor],NSForegroundColorAttributeName,  nil]  forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Helvetica" size:13],NSFontAttributeName,[UIColor redColor],NSForegroundColorAttributeName,  nil]  forState:UIControlStateSelected];
    tabBar.tabBar.tintColor = [UIColor redColor];
    
     MainVC *mainVC = [MainVC new];
    UINavigationController *MainNav = [[UINavigationController alloc]initWithRootViewController:mainVC];
    mainVC.title = @"首页";
    mainVC.tabBarItem.image = [UIImage imageNamed:@"bottom_home_icon"];
    mainVC.tabBarItem.selectedImage = [UIImage imageNamed:@"bottom_home_icon_on"];
    
     MatchVC *matchVC = [MatchVC new];
    UINavigationController *matchNav = [[UINavigationController alloc]initWithRootViewController:matchVC];
   
    matchVC.title =@"搭配";
    
    matchVC.tabBarItem.image = [UIImage imageNamed:@"bottom_dapei_icon"];
    matchVC.tabBarItem.selectedImage = [UIImage imageNamed:@"bottom_dapei_icon_on"];
    
    CommunityVC *commVC = [CommunityVC new];
    UINavigationController *commNav = [[UINavigationController alloc]initWithRootViewController:commVC];
    commVC.title = @"社区";
    commVC.tabBarItem.image = [UIImage imageNamed:@"bottom_bbs_icon@3x"];
    commVC.tabBarItem.selectedImage = [UIImage imageNamed:@"bottom_bbs_icon_on@3x"];
    HiChaoVC *hiChaoVC = [HiChaoVC new];
    UINavigationController *hiChaoNav = [[UINavigationController alloc]initWithRootViewController:hiChaoVC];
    hiChaoVC.title =@"男衣邦";
    hiChaoVC.tabBarItem.image =[UIImage imageNamed:@"bottom_clothes_icon"];
    hiChaoVC.tabBarItem.selectedImage = [UIImage imageNamed:@"bottom_clothes_icon"];
    
    ShoppingCarVC *shoppingCarVC = [ShoppingCarVC new];
    UINavigationController *shoppingCarNav = [[UINavigationController alloc]initWithRootViewController:shoppingCarVC];
    shoppingCarVC.title = @"购物车";
    shoppingCarVC.tabBarItem.image = [UIImage imageNamed:@"icon_shopping64x64"];
    shoppingCarVC.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_shopping64x64on"];
    
    tabBar.viewControllers =@[MainNav,matchNav,commNav,shoppingCarNav,hiChaoNav];
    
    self.window .rootViewController = introduceVC;
    
    __block IntroduceVC *weakSelf = introduceVC;
    
    //回调block 改变根视图
    [introduceVC didEnterRootVC:^{
        [weakSelf.view removeFromSuperview];
       
        self.window.rootViewController = tabBar;
        
        
    }];
    
    [self.window makeKeyAndVisible];
    
    
        
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
