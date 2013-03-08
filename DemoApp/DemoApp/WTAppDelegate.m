//
//  WTAppDelegate.m
//  DemoApp
//
//  Created by Alex Skalozub on 3/8/13.
//  Copyright (c) 2013 Alex Skalozub. All rights reserved.
//

#import "WTAppDelegate.h"

#import "WTViewController.h"

@implementation WTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self.viewController = [[WTViewController alloc] initWithNibName:@"WTViewController_iPhone" bundle:nil];
    } else {
        self.viewController = [[WTViewController alloc] initWithNibName:@"WTViewController_iPad" bundle:nil];
    }
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
