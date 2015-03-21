//
//  AppDelegate.m
//  ContatosIP67
//
//  Created by ios5034 on 09/03/15.
//  Copyright (c) 2015 ios5034. All rights reserved.
//

#import "AppDelegate.h"
#import "ListaContatosViewController.h"
#import "ContatosNoMapaViewController.h"
#import "ContatosIP67-Swift.h"
#import "NavigationController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [UIWindow new];
    UIScreen *screen = [UIScreen mainScreen];
    CGRect limite = [screen bounds];
    self.window.frame = limite;
    
    ListaContatosViewController *view = [ListaContatosViewController new];
    NavigationController *navController = [[NavigationController alloc] initWithRootViewController:view];
    
    ContatosNoMapa_swift *maps = [ContatosNoMapa_swift new];
    
 // ContatosNoMapaViewController *maps2 = [ContatosNoMapaViewController new];
    NavigationController *navControllerMaps = [[NavigationController alloc] initWithRootViewController:maps];
    
    UITabBarController *tabBar = [UITabBarController new];
    tabBar.viewControllers = @[navController, navControllerMaps];
    
    self.window.rootViewController = tabBar;
    
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
    
    self.dao = [ContatoDao contatoDaoInstance];
    [self.dao saveContext];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
}


@end
